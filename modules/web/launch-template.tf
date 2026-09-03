resource "aws_launch_template" "web" {
  name_prefix   = "${var.environment}-web-"
  image_id      = "ami-0f918f7e67a3323f0"
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.instance_profile_name
  }

  vpc_security_group_ids = [
    var.web_security_group_id
  ]

  user_data = base64encode(<<-EOF
              #!/bin/bash

              dnf update -y
              dnf install -y nginx

              systemctl enable nginx
              systemctl start nginx

              cat > /usr/share/nginx/html/index.html <<'HTML'
              <html>
              <head>
                <title>Dev Web Server</title>
              </head>
              <body>
                <h1>Dev Web Server is Running</h1>
                <p>Traffic reached the Web Server through the Public NLB.</p>
              </body>
              </html>
              HTML
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