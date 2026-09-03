variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "app_subnet_ids" {
  description = "Private app subnet IDs for the Network Load Balancer"
  type        = list(string)
}

variable "app_asg_name" {
  description = "Name of the application Auto Scaling Group"
  type        = string
}