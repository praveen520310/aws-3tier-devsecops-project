resource "aws_lb_target_group" "app" {
  name        = "${var.environment}-app-tg"
  port        = 8080
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    protocol = "TCP"
    port     = "8080"
  }

  tags = {
    Name        = "${var.environment}-app-tg"
    Environment = var.environment
    Tier        = "app"
  }
}

resource "aws_autoscaling_attachment" "app" {
  autoscaling_group_name = var.app_asg_name
  lb_target_group_arn    = aws_lb_target_group.app.arn
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.private.arn
  port              = 8080
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}