# ---------------------------------------------------------------------------
# Threat detection and posture management.
#   GuardDuty    - analyzes CloudTrail, VPC flow, and DNS logs for threats
#   Security Hub - scores the account against security standards
# Both have 30-day free trials; see README for costs and cleanup.
# ---------------------------------------------------------------------------

resource "aws_guardduty_detector" "main" {
  enable                       = true
  finding_publishing_frequency = "FIFTEEN_MINUTES"
}

resource "aws_securityhub_account" "main" {
  enable_default_standards = false # subscribe explicitly below
}

resource "aws_securityhub_standards_subscription" "cis" {
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/cis-aws-foundations-benchmark/v/1.4.0"
  depends_on    = [aws_securityhub_account.main]
}

resource "aws_securityhub_standards_subscription" "fsbp" {
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/aws-foundational-security-best-practices/v/1.0.0"
  depends_on    = [aws_securityhub_account.main]
}
