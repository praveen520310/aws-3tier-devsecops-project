output "ec2_role_name" {
  description = "Name of the EC2 IAM role"
  value       = aws_iam_role.ec2.name
}

output "ec2_role_arn" {
  description = "ARN of the EC2 IAM role"
  value       = aws_iam_role.ec2.arn
}

output "ec2_instance_profile_name" {
  description = "Name of the EC2 instance profile"
  value       = aws_iam_instance_profile.ec2.name
}

# =====================================================
# JENKINS IAM OUTPUTS
# =====================================================

output "jenkins_role_name" {
  description = "Name of the Jenkins IAM role"
  value       = aws_iam_role.jenkins.name
}

output "jenkins_role_arn" {
  description = "ARN of the Jenkins IAM role"
  value       = aws_iam_role.jenkins.arn
}

output "jenkins_instance_profile_name" {
  description = "Name of the Jenkins instance profile"
  value       = aws_iam_instance_profile.jenkins.name
}