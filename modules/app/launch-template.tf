resource "aws_launch_template" "app" {
  name_prefix   = "${var.environment}-app-"
  image_id      = "ami-0f918f7e67a3323f0"
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = false

    security_groups = [
      var.app_security_group_id
    ]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash

              set -e


              apt-get update -y
              apt-get install -y python3 python3-pip python3-venv snapd

              mkdir -p /opt/app

              python3 -m venv /opt/app/venv

              /opt/app/venv/bin/python -m pip install --upgrade pip
              /opt/app/venv/bin/python -m pip install --no-cache-dir mysql-connector-python
              /opt/app/venv/bin/python -c "import mysql.connector; print('mysql-connector-python installed successfully')"

              cat > /opt/app/app.py <<'PYTHON'
              import os
              from http.server import BaseHTTPRequestHandler, HTTPServer

              class AppHandler(BaseHTTPRequestHandler):

                  def do_GET(self):

                      if self.path == "/":
                          self.send_response(200)
                          self.send_header("Content-Type", "text/html")
                          self.end_headers()

                          self.wfile.write(
                              b"<h1>App Server is running</h1>"
                          )
                          return

                      if self.path == "/db":

                          try:
                              import mysql.connector

                              connection = mysql.connector.connect(
                                  host=os.environ["DB_HOST"],
                                  database=os.environ["DB_NAME"],
                                  user=os.environ["DB_USER"],
                                  password=os.environ["DB_PASSWORD"]
                              )

                              cursor = connection.cursor()

                              cursor.execute("SELECT DATABASE()")

                              result = cursor.fetchone()

                              cursor.close()
                              connection.close()

                              self.send_response(200)
                              self.send_header(
                                  "Content-Type",
                                  "text/html"
                              )
                              self.end_headers()

                              response = (
                                  "<h1>RDS Connection Successful</h1>"
                                  f"<p>Database: {result[0]}</p>"
                              )

                              self.wfile.write(
                                  response.encode()
                              )

                          except Exception as error:

                              self.send_response(500)
                              self.send_header(
                                  "Content-Type",
                                  "text/html"
                              )
                              self.end_headers()

                              response = (
                                  "<h1>RDS Connection Failed</h1>"
                                  f"<p>{error}</p>"
                              )

                              self.wfile.write(
                                  response.encode()
                              )

                          return

                      self.send_response(404)
                      self.end_headers()


              server = HTTPServer(
                  ("0.0.0.0", 8080),
                  AppHandler
              )

              server.serve_forever()
              PYTHON

              cat > /etc/systemd/system/app.service <<EOF_SERVICE
              [Unit]
              Description=3-Tier Application Server
              After=network.target

              [Service]
              Type=simple
              User=root

              Environment="DB_HOST=${var.rds_endpoint}"
              Environment="DB_NAME=appdb"
              Environment="DB_USER=admin"
              Environment="DB_PASSWORD=${var.db_password}"

              ExecStart=/opt/app/venv/bin/python /opt/app/app.py

              Restart=always
              RestartSec=5

              [Install]
              WantedBy=multi-user.target
              EOF_SERVICE

              systemctl daemon-reload
              systemctl enable app.service
              systemctl restart app.service

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