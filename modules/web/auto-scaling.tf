resource "aws_autoscaling_group" "web" {
  name = "${var.environment}-web-asg"

  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  vpc_zone_identifier = var.web_subnet_ids

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  health_check_type = "EC2"

  tag {
    key                 = "Name"
    value               = "${var.environment}-web-server"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Tier"
    value               = "web"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}