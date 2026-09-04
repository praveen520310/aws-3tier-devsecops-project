resource "aws_launch_template" "app" {
  name_prefix   = "${var.environment}-app-"
  image_id      = "ami-0f918f7e67a3323f0"
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.instance_profile_name
  }

  vpc_security_group_ids = [
    var.app_security_group_id
  ]

  user_data = base64encode(<<-EOF
              #!/bin/bash

              set -e

              apt-get update -y
              apt-get install -y python3

              mkdir -p /opt/app

              cat > /opt/app/app.py <<'PYTHON'
              from http.server import BaseHTTPRequestHandler, HTTPServer

              class AppHandler(BaseHTTPRequestHandler):
                  def do_GET(self):
                      response = """
              <html>
              <head>
                <title>Dev App Server</title>
              </head>
              <body>
                <h1>Dev App Server is Running</h1>
                <p>Traffic reached the App Server through the Private NLB.</p>
              </body>
              </html>
                      """

                      self.send_response(200)
                      self.send_header("Content-Type", "text/html")
                      self.send_header("Content-Length", str(len(response.encode())))
                      self.end_headers()
                      self.wfile.write(response.encode())

              server = HTTPServer(("0.0.0.0", 8080), AppHandler)
              server.serve_forever()
              PYTHON

              cat > /etc/systemd/system/app.service <<'SERVICE'
              [Unit]
              Description=Dev Application Server
              After=network.target

              [Service]
              ExecStart=/usr/bin/python3 /opt/app/app.py
              Restart=always

              [Install]
              WantedBy=multi-user.target
              SERVICE

              systemctl daemon-reload
              systemctl enable app
              systemctl start app
              EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.environment}-app-server"
      Environment = var.environment
      Tier        = "app"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}