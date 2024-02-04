data "aws_ssm_parameter" "alart_mail_address" {
  name = "alart-mail-address"
}

# アカウントIDを取得
data "aws_caller_identity" "current" {}