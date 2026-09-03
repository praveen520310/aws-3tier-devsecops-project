variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Environment name "
  type        = string
}

variable "availability_zones" {
  description = "Availability zones for the VPC"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets, one per AZ"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "web_subnet_cidrs" {
  description = "CIDR blocks for web tier subnets, one per AZ"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "app_subnet_cidrs" {
  description = "CIDR blocks for app tier subnets, one per AZ"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "db_subnet_cidrs" {
  description = "CIDR blocks for db tier subnets, one per AZ"
  type        = list(string)
  default     = ["10.0.31.0/24", "10.0.32.0/24"]
}