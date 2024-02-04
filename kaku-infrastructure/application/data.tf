# Paramater Storeに登録したドメイン名を取得
data "aws_ssm_parameter" "domain_name" {
  name = "domain-name"
}

# domainのホストゾーンを取得
data "aws_route53_zone" "default" {
  name         = data.aws_ssm_parameter.domain_name.value
  private_zone = false
}

#acm証明書を取得
data "aws_acm_certificate" "default" {
  domain   = data.aws_ssm_parameter.domain_name.value
}

data "aws_ssm_parameter" "alart_mail_address" {
  name = "alart-mail-address"
}

#secret managerのメタ情報を取得
data "aws_secretsmanager_secret" "db_secret" {
  name = "rds!cluster-6a0e1672-4723-4969-a019-98202dda7cd2"
}
#メタ情報をもとにsecretのARNを取得
data "aws_secretsmanager_secret_version" "db_secret_id" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}

data "aws_ssm_parameter" "next_public_rails_api_url" {
  name = "next-public-rails-api-url"
}

data "aws_ssm_parameter" "next_private_rails_api_url" {
  name = "next-private-rails-api-url"
}