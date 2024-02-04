# macieを有効化
resource "aws_macie2_account" "default" {
  status                       = "ENABLED"
}