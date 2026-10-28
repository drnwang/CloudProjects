output "cloudtrail_bucket" {
  description = "S3 bucket holding CloudTrail logs."
  value       = aws_s3_bucket.trail_logs.id
}

output "cloudtrail_log_group" {
  description = "CloudWatch Logs group receiving CloudTrail events."
  value       = aws_cloudwatch_log_group.trail.name
}

output "guardduty_detector_id" {
  description = "GuardDuty detector ID."
  value       = aws_guardduty_detector.main.id
}

output "alerts_topic_arn" {
  description = "SNS topic for security alerts. Confirm the subscription email to start receiving alerts."
  value       = aws_sns_topic.security_alerts.arn
}
