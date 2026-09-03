variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the Network Load Balancer"
  type        = list(string)
}

variable "web_asg_name" {
  description = "Name of the web server Auto Scaling Group"
  type        = string
}