variable "environment" {
  description = "Environment name"
  type        = string
}

variable "web_subnet_ids" {
  description = "Subnet IDs for the web servers"
  type        = list(string)
}

variable "web_security_group_id" {
  description = "Security group ID for web servers"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name for web servers"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for web servers"
  type        = string
  default     = "t3.micro"
}

variable "private_nlb_dns_name" {
  description = "DNS name of the internal private Network Load Balancer"
  type        = string
}

