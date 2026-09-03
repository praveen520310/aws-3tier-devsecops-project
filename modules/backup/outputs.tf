output "backup_vault_name" {
  description = "Name of the AWS Backup vault"
  value       = aws_backup_vault.main.name
}

output "backup_plan_id" {
  description = "ID of the AWS Backup plan"
  value       = aws_backup_plan.main.id
}

output "backup_plan_arn" {
  description = "ARN of the AWS Backup plan"
  value       = aws_backup_plan.main.arn
}