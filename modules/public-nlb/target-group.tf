resource "aws_lb_target_group" "web" {
  name        = "${var.environment}-web-tg"
  port        = 80
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    protocol = "TCP"
    port     = "80"
  }

  tags = {
    Name        = "${var.environment}-web-tg"
    Environment = var.environment
    Tier        = "web"
  }
}

resource "aws_autoscaling_attachment" "web" {
  autoscaling_group_name = var.web_asg_name
  lb_target_group_arn    = aws_lb_target_group.web.arn
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}