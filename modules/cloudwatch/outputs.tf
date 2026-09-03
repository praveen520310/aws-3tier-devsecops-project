output "sns_topic_arn" {
  description = "ARN of the SNS topic used for CloudWatch alerts"
  value       = aws_sns_topic.alerts.arn
}

output "sns_topic_name" {
  description = "Name of the SNS topic"
  value       = aws_sns_topic.alerts.name
}

output "web_cpu_alarm_name" {
  description = "Name of the web tier CPU alarm"
  value       = aws_cloudwatch_metric_alarm.web_cpu.alarm_name
}

output "app_cpu_alarm_name" {
  description = "Name of the app tier CPU alarm"
  value       = aws_cloudwatch_metric_alarm.app_cpu.alarm_name
}