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