# ---------------------------------------------------------------------------
# Alerting: email notifications for high-risk activity.
#   - Root account used (CIS AWS Foundations 1.7 / 4.3)
#   - Console sign-in without MFA (CIS 4.2)
#   - Any GuardDuty finding with severity 7.0 or higher
# ---------------------------------------------------------------------------

resource "aws_sns_topic" "security_alerts" {
  name = "${var.name_prefix}-security-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.security_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# Allow CloudWatch alarms and EventBridge (GuardDuty findings) in this account to publish.
data "aws_iam_policy_document" "alerts_topic" {
  statement {
    sid       = "AllowCloudWatchAndEventBridge"
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.security_alerts.arn]
    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com", "events.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.account_id]
    }
  }
}

resource "aws_sns_topic_policy" "security_alerts" {
  arn    = aws_sns_topic.security_alerts.arn
  policy = data.aws_iam_policy_document.alerts_topic.json
}

locals {
  # CloudTrail patterns from the CIS AWS Foundations Benchmark.
  log_alerts = {
    RootAccountUsage = {
      pattern     = "{ $.userIdentity.type = \"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != \"AwsServiceEvent\" }"
      description = "The root account was used. Root should be locked away and never used day to day."
    }
    ConsoleLoginWithoutMFA = {
      pattern     = "{ ($.eventName = \"ConsoleLogin\") && ($.additionalEventData.MFAUsed != \"Yes\") && ($.userIdentity.type = \"IAMUser\") && ($.responseElements.ConsoleLogin = \"Success\") }"
      description = "An IAM user signed in to the console without MFA."
    }
  }
}

resource "aws_cloudwatch_log_metric_filter" "alerts" {
  for_each       = local.log_alerts
  name           = "${var.name_prefix}-${each.key}"
  log_group_name = aws_cloudwatch_log_group.trail.name
  pattern        = each.value.pattern

  metric_transformation {
    name      = each.key
    namespace = "${var.name_prefix}/CloudTrail"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "alerts" {
  for_each            = local.log_alerts
  alarm_name          = "${var.name_prefix}-${each.key}"
  alarm_description   = each.value.description
  namespace           = "${var.name_prefix}/CloudTrail"
  metric_name         = each.key
  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"
  alarm_actions       = [aws_sns_topic.security_alerts.arn]

  depends_on = [aws_cloudwatch_log_metric_filter.alerts]
}

# High-severity GuardDuty findings go straight to email.
resource "aws_cloudwatch_event_rule" "guardduty_high" {
  name        = "${var.name_prefix}-guardduty-high-severity"
  description = "GuardDuty findings with severity 7.0 or higher"
  event_pattern = jsonencode({
    source        = ["aws.guardduty"]
    "detail-type" = ["GuardDuty Finding"]
    detail = {
      severity = [{ numeric = [">=", 7] }]
    }
  })
}

resource "aws_cloudwatch_event_target" "guardduty_to_sns" {
  rule      = aws_cloudwatch_event_rule.guardduty_high.name
  target_id = "security-alerts-sns"
  arn       = aws_sns_topic.security_alerts.arn
}
