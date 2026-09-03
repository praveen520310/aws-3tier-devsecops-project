output "public_nlb_id" {
  description = "ID of the public Network Load Balancer"
  value       = aws_lb.public.id
}

output "public_nlb_arn" {
  description = "ARN of the public Network Load Balancer"
  value       = aws_lb.public.arn
}

output "public_nlb_dns_name" {
  description = "DNS name of the public Network Load Balancer"
  value       = aws_lb.public.dns_name
}

output "web_target_group_arn" {
  description = "ARN of the web target group"
  value       = aws_lb_target_group.web.arn
}