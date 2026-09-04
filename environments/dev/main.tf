module "vpc" {
  source = "../../modules/vpc"

  environment = "dev"
}

module "security_groups" {
  source = "../../modules/security-groups"

  environment = "dev"
  vpc_id      = module.vpc.vpc_id
  vpc_cidr    = var.vpc_cidr
}

module "public_nlb" {
  source = "../../modules/public-nlb"

  environment       = "dev"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  web_asg_name      = module.web.web_asg_name
}

module "iam" {
  source = "../../modules/iam"

  environment = "dev"
}

module "web" {
  source = "../../modules/web"

  environment           = "dev"
  web_subnet_ids        = module.vpc.web_subnet_ids
  web_security_group_id = module.security_groups.web_security_group_id
  instance_profile_name = module.iam.ec2_instance_profile_name

  private_nlb_dns_name = module.private_nlb.private_nlb_dns_name
}

module "app" {
  source = "../../modules/app"

  environment           = "dev"
  app_subnet_ids        = module.vpc.app_subnet_ids
  app_security_group_id = module.security_groups.app_security_group_id
  instance_profile_name = module.iam.ec2_instance_profile_name

  rds_endpoint = module.rds.rds_endpoint
  db_password  = var.db_password

}

module "private_nlb" {
  source = "../../modules/private-nlb"

  environment    = "dev"
  vpc_id         = module.vpc.vpc_id
  app_subnet_ids = module.vpc.app_subnet_ids
  app_asg_name   = module.app.app_asg_name
}

module "rds" {
  source = "../../modules/rds"

  providers = {
    aws          = aws
    aws.region_b = aws.region_b
  }

  environment          = "dev"
  db_subnet_ids        = module.vpc.db_subnet_ids
  db_security_group_id = module.security_groups.db_security_group_id
  db_password          = var.db_password
}

module "backup" {
  source = "../../modules/backup"

  providers = {
    aws          = aws
    aws.region_b = aws.region_b
  }

  environment = "dev"
}

module "cloudwatch" {
  source = "../../modules/cloudwatch"

  environment = "dev"
  sns_email   = var.sns_email
}