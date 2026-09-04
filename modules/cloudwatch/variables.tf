variable "environment" {
  description = "Environment name"
  type        = string
}

variable "sns_email" {
  description = "Email address for CloudWatch alarm notifications"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU utilization threshold for CloudWatch alarms"
  type        = number
  default     = 80
}

variable "alarm_period" {
  description = "CloudWatch alarm evaluation period in seconds"
  type        = number
  default     = 300
}