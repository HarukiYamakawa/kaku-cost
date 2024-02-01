# Paramater Storeに登録したドメイン名を取得
data "aws_ssm_parameter" "domain_name" {
  name = "domain-name"
}

# domainのホストゾーンを取得
data "aws_route53_zone" "default" {
  name         = data.aws_ssm_parameter.domain_na Ame.value
  private_zone = false
}

#acm証明書を取得
data "aws_acm_certificate" "default" {
  domain   = data.aws_ssm_parameter.domain_name.value
}