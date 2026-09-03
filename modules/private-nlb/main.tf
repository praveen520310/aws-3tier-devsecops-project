resource "aws_lb" "private" {
  name               = "${var.environment}-private-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.app_subnet_ids

  tags = {
    Name        = "${var.environment}-private-nlb"
    Environment = var.environment
    Tier        = "app"
  }
}