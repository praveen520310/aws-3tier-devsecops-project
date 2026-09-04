resource "aws_launch_template" "web" {
  name_prefix   = "${var.environment}-web-"
  image_id      = "ami-0f918f7e67a3323f0"
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = true

    security_groups = [
      var.web_security_group_id
    ]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash

              dnf update -y
              dnf install -y nginx

              rm -f /etc/nginx/conf.d/default.conf

              cat > /etc/nginx/conf.d/app.conf <<NGINX
              server {
                  listen 80;
                  server_name _;

                  location / {
                      proxy_pass http://${var.private_nlb_dns_name}:8080;
                      proxy_set_header Host \$host;
                      proxy_set_header X-Real-IP \$remote_addr;
                      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
                      proxy_set_header X-Forwarded-Proto \$scheme;
                  }
              }
              NGINX

              nginx -t

              systemctl enable nginx
              systemctl restart nginx
              EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.environment}-web-server"
      Environment = var.environment
      Tier        = "web"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}