resource "aws_backup_vault" "main" {
  name = "${var.environment}-backup-vault"

  tags = {
    Name        = "${var.environment}-backup-vault"
    Environment = var.environment
  }
}

resource "aws_iam_role" "backup" {
  name = "${var.environment}-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "backup.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "${var.environment}-backup-role"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "backup" {
  role       = aws_iam_role.backup.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_backup_plan" "main" {
  name = "${var.environment}-backup-plan"

  rule {
    rule_name         = "${var.environment}-daily-backup"
    target_vault_name = aws_backup_vault.main.name
    schedule          = var.backup_schedule

    lifecycle {
      delete_after = var.retention_days
    }
  }

  tags = {
    Name        = "${var.environment}-backup-plan"
    Environment = var.environment
  }
}

resource "aws_backup_selection" "ec2" {
  name         = "${var.environment}-ec2-backup"
  iam_role_arn = aws_iam_role.backup.arn
  plan_id      = aws_backup_plan.main.id

  resources = [
    "arn:aws:ec2:ap-south-1:*:instance/*"
  ]
}