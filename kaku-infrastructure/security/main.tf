terraform {
  required_version = "1.6.3"
  backend "s3" {
    bucket = "kaku-tfstate-cost-security"
    key    = "kaku-infrastructure/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "s3" {
  source = "./module/s3"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group
}

module "iam" {
  source = "./module/iam"

  name_prefix = var.name_prefix
}

module "config" {
  source = "./module/config"

  config_log_bucket_name = module.s3.config_log_bucket_name
  config_role_arn = module.iam.config_role_arn
}

module "security-hub" {
  source = "./module/security-hub"
}

# module "sns" {
#   source = "./module/sns"

#   name_prefix = var.name_prefix
#   tag_name = var.tag_name
#   tag_group = var.tag_group

#   email = data.aws_ssm_parameter.alart_mail_address.value
# }

# module "event-bridge" {
#   source = "./module/event-bridge"

#   sns_arn = module.sns.security_alart_topic_arn
# }

module "macie" {
  source = "./module/macie"
}

module "iam-access-analyzer" {
  source = "./module/iam-access-analyzer"

  name_prefix = var.name_prefix
}

module "inspector" {
  source = "./module/inspector"

  account_id = data.aws_caller_identity.current.account_id
}

module "cloud-trail" {
  source = "./module/cloud-trail"

  cloud_trail_log_bucket_name = module.s3.cloud_trail_log_bucket_name
  name_prefix = var.name_prefix
}

module "vpc-flow-logs" {
  source = "./module/vpc-flow-logs"

  vpc_flow_log_bucket_arn = module.s3.vpc_flow_log_bucket_arn
  vpc_id = data.aws_vpc.vpc.id
}

module "guard-duty" {
  source = "./module/guard-duty"
}