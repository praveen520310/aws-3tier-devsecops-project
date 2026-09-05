# =====================================================
# APPLICATION EC2 IAM ROLE
# Used by Web and App EC2 instances
# =====================================================

resource "aws_iam_role" "ec2" {
  name = "${var.environment}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "${var.environment}-ec2-role"
    Environment = var.environment
    Purpose     = "Web and App EC2"
  }
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.environment}-ec2-instance-profile"
  role = aws_iam_role.ec2.name

  tags = {
    Name        = "${var.environment}-ec2-instance-profile"
    Environment = var.environment
    Purpose     = "Web and App EC2"
  }
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


# =====================================================
# JENKINS IAM ROLE
# Used by Jenkins to run Terraform
# =====================================================

resource "aws_iam_role" "jenkins" {
  name = "${var.environment}-jenkins-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "${var.environment}-jenkins-role"
    Environment = var.environment
    Purpose     = "Jenkins Terraform"
  }
}


# =====================================================
# JENKINS INSTANCE PROFILE
# Reusable for Jenkins EC2 instances
# =====================================================

resource "aws_iam_instance_profile" "jenkins" {
  name = "${var.environment}-jenkins-instance-profile"
  role = aws_iam_role.jenkins.name

  tags = {
    Name        = "${var.environment}-jenkins-instance-profile"
    Environment = var.environment
    Purpose     = "Jenkins Terraform"
  }
}


# =====================================================
# JENKINS TERRAFORM PERMISSIONS
# =====================================================

resource "aws_iam_role_policy_attachment" "jenkins_admin" {
  role       = aws_iam_role.jenkins.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


# =====================================================
# JENKINS SSM ACCESS
# =====================================================

resource "aws_iam_role_policy_attachment" "jenkins_ssm" {
  role       = aws_iam_role.jenkins.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}