output "web_security_group_id" {
  description = "Security group ID for web tier"
  value       = aws_security_group.web.id
}

output "app_security_group_id" {
  description = "Security group ID for application tier"
  value       = aws_security_group.app.id
}

output "db_security_group_id" {
  description = "Security group ID for database tier"
  value       = aws_security_group.db.id
}