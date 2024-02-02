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

module "route53" {
  source = "./module/route53"

  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
  domain_name = data.aws_ssm_parameter.domain_name.value
  domain_zone_id = data.aws_route53_zone.default.zone_id
}

module "sns" {
  source = "./module/sns"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group

  email = data.aws_ssm_parameter.alart_mail_address.value
}

module "cloud_watch_alarm" {
  source = "./module/cloud-watch-alarm"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group

  alart_topic_arn = module.sns.alart_topic_arn
}

module "waf" {
  source = "./module/waf"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group

  alb_arn = module.alb.alb_arn
  waf_traffic_log_bucket_arn = module.s3.waf_traffic_log_bucket_arn
}