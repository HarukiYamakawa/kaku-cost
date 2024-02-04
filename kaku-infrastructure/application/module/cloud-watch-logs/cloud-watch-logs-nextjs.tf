resource "aws_cloudwatch_log_group" "nodejs-log" {
  name              = "/${var.name_prefix}/nodejs"
  retention_in_days = 3
}