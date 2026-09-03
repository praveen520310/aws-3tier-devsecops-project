output "private_nlb_id" {
  description = "ID of the private Network Load Balancer"
  value       = aws_lb.private.id
}

output "private_nlb_arn" {
  description = "ARN of the private Network Load Balancer"
  value       = aws_lb.private.arn
}

output "private_nlb_dns_name" {
  description = "DNS name of the private Network Load Balancer"
  value       = aws_lb.private.dns_name
}

output "app_target_group_arn" {
  description = "ARN of the application target group"
  value       = aws_lb_target_group.app.arn
}