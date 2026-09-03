output "app_launch_template_id" {
  description = "ID of the application server launch template"
  value       = aws_launch_template.app.id
}

output "app_asg_name" {
  description = "Name of the application server Auto Scaling Group"
  value       = aws_autoscaling_group.app.name
}