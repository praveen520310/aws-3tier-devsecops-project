output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value = [
    aws_subnet.public_az1.id,
    aws_subnet.public_az2.id
  ]
}

output "web_subnet_ids" {
  description = "Web subnet IDs"
  value = [
    aws_subnet.web_az1.id,
    aws_subnet.web_az2.id
  ]
}

output "app_subnet_ids" {
  description = "App subnet IDs"
  value = [
    aws_subnet.app_az1.id,
    aws_subnet.app_az2.id
  ]
}

output "db_subnet_ids" {
  description = "DB subnet IDs"
  value = [
    aws_subnet.db_az1.id,
    aws_subnet.db_az2.id
  ]
}