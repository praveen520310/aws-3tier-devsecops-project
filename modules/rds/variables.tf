variable "environment" {
  description = "Environment name"
  type        = string
}

variable "db_subnet_ids" {
  description = "Private DB subnet IDs"
  type        = list(string)
}

variable "db_security_group_id" {
  description = "Security group ID for the database"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master database username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master database password"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}