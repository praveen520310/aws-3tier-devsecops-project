variable "environment" {
  description = "Environment name"
  type        = string
}

variable "app_subnet_ids" {
  description = "Subnet IDs for the application servers"
  type        = list(string)
}

variable "app_security_group_id" {
  description = "Security group ID for application servers"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name for application servers"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for application servers"
  type        = string
  default     = "t3.micro"
}