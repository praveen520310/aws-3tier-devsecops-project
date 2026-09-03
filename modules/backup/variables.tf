variable "environment" {
  description = "Environment name"
  type        = string
}

variable "backup_schedule" {
  description = "Backup schedule in cron format"
  type        = string
  default     = "cron(0 2 * * ? *)"
}

variable "retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}