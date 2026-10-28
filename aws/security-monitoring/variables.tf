variable "region" {
  description = "AWS region to deploy the lab in."
  type        = string
  default     = "us-east-1"
}

variable "name_prefix" {
  description = "Prefix for resource names. Lowercase letters, numbers, and hyphens only."
  type        = string
  default     = "seclab"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.name_prefix))
    error_message = "name_prefix must be 3-20 characters: lowercase letters, numbers, and hyphens."
  }
}

variable "alert_email" {
  description = "Email address that receives security alerts. You must confirm the SNS subscription email."
  type        = string
}

variable "log_retention_days" {
  description = "How long to keep CloudTrail logs in S3 and CloudWatch Logs."
  type        = number
  default     = 90
}
