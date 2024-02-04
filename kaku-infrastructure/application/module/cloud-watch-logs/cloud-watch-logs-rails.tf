resource "aws_cloudwatch_log_group" "puma-log" {
  name              = "/${var.name_prefix}/puma"
  retention_in_days = 3
}