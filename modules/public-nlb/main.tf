resource "aws_lb" "public" {
  name               = "${var.environment}-public-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids

  tags = {
    Name        = "${var.environment}-public-nlb"
    Environment = var.environment
    Tier        = "public"
  }
}