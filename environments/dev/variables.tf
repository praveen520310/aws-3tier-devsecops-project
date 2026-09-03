variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "sns_email" {
  description = "Email address for CloudWatch alarm notifications"
  type        = string
}