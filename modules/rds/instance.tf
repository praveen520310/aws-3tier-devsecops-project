resource "aws_db_instance" "main" {
  identifier = "${var.environment}-rds"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class        = var.db_instance_class
  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp3"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.db_security_group_id]

  publicly_accessible = false

  multi_az = false

  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "sun:04:00-sun:05:00"

  skip_final_snapshot = true

  deletion_protection = false

  tags = {
    Name        = "${var.environment}-rds"
    Environment = var.environment
    Tier        = "database"
  }
}

resource "aws_db_instance" "read_replica" {
  provider = aws.region_b

  identifier = "${var.environment}-rds-replica"

  replicate_source_db = aws_db_instance.main.arn

  instance_class = var.db_instance_class

  publicly_accessible = false

  auto_minor_version_upgrade = true

  skip_final_snapshot = true

  tags = {
    Name        = "${var.environment}-rds-replica"
    Environment = var.environment
    Tier        = "database-replica"
  }
}