# SNS topic for CloudWatch alarm notifications
resource "aws_sns_topic" "alerts" {
  name = "${var.environment}-cloudwatch-alerts"

  tags = {
    Name        = "${var.environment}-cloudwatch-alerts"
    Environment = var.environment
  }
}

# Email subscription for SNS notifications
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.sns_email
}

# Web tier CPU alarm
resource "aws_cloudwatch_metric_alarm" "web_cpu" {
  alarm_name          = "${var.environment}-web-high-cpu"
  alarm_description   = "Alarm when web tier CPU utilization is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.cpu_threshold

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  dimensions = {
    AutoScalingGroupName = "${var.environment}-web-asg"
  }

  tags = {
    Name        = "${var.environment}-web-high-cpu"
    Environment = var.environment
    Tier        = "web"
  }
}

# App tier CPU alarm
resource "aws_cloudwatch_metric_alarm" "app_cpu" {
  alarm_name          = "${var.environment}-app-high-cpu"
  alarm_description   = "Alarm when app tier CPU utilization is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.cpu_threshold

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  dimensions = {
    AutoScalingGroupName = "${var.environment}-app-asg"
  }

  tags = {
    Name        = "${var.environment}-app-high-cpu"
    Environment = var.environment
    Tier        = "app"
  }
}