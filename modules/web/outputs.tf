output "web_launch_template_id" {
  description = "ID of the web server launch template"
  value       = aws_launch_template.web.id
}

output "web_asg_name" {
  description = "Name of the web server Auto Scaling Group"
  value       = aws_autoscaling_group.web.name
}