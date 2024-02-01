terraform {
  required_version = "1.6.3"
  backend "s3" {
    bucket = "kaku-tfstate-cost"
    key    = "kaku-infrastructure/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source = "./module/network"
  name_prefix = "kaku"
  tag_name = "kaku"
  tag_group = "kaku"
}

module "security-group" {
  source = "./module/security-group"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group

  vpc_id = module.network.vpc_id
}

module "alb" {
  source = "./module/alb"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group

  vpc_id = module.network.vpc_id
  subnet_ingress_1_id = module.network.public_subnet_ingress_1_id
  subnet_ingress_2_id = module.network.public_subnet_ingress_2_id
  sg_alb_id = module.security-group.sg_alb_id

  certificate_arn = data.aws_acm_certificate.default.arn

  alb_access_log_bucket_id = module.s3.alb_access_logs_bucket_id
}

module "s3" {
  source = "./module/s3"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group
}