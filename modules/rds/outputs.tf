output "db_instance_id" {
  description = "RDS instance identifier"
  value       = aws_db_instance.main.id
}

output "db_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.main.endpoint
}

output "db_port" {
  description = "RDS database port"
  value       = aws_db_instance.main.port
}

output "db_address" {
  description = "RDS database hostname"
  value       = aws_db_instance.main.address
}

output "read_replica_id" {
  description = "RDS cross-region read replica identifier"
  value       = aws_db_instance.read_replica.id
}

output "read_replica_address" {
  description = "RDS cross-region read replica hostname"
  value       = aws_db_instance.read_replica.address
}