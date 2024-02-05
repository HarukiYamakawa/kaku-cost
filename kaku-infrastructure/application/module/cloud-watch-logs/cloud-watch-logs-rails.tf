resource "aws_cloudwatch_log_group" "puma-log" {
  name              = "/${var.name_prefix}/puma"
  retention_in_days = 3
}

# firelensのログを出力するためのロググループを作成
resource "aws_cloudwatch_log_group" "puma_firelens_log" {
  name              = "/${var.name_prefix}/puma_firelens"
  retention_in_days = 3
}