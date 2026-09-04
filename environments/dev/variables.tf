variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "sns_email" {
  description = "Email address for CloudWatch alarm notifications"
  type        = string
}