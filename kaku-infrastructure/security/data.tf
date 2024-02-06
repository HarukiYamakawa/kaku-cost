data "aws_ssm_parameter" "alart_mail_address" {
  name = "alart-mail-address"
}

# アカウントIDを取得
data "aws_caller_identity" "current" {}

data "aws_vpc" "vpc" {

  filter {
    name   = "tag:Name"
    values = ["${var.tag_name}-vpc"]
  }
}