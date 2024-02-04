# Security Hubを有効化
resource "aws_securityhub_account" "default" {
  #デフォルトで有効化されているセキュリティ基準を無効化
  enable_default_standards = false
}

#「AWS 基礎セキュリティのベストプラクティス」を有効化
resource "aws_securityhub_standards_subscription" "aws_foundational_security_best_practices" {
  depends_on = [aws_securityhub_account.default]

  standards_arn = "arn:aws:securityhub:ap-northeast-1::standards/aws-foundational-security-best-practices/v/1.0.0"
}