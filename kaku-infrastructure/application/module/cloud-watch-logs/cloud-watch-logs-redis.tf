resource "aws_cloudwatch_log_group" "redis-log" {
  name              = "/${var.name_prefix}/redis"
  retention_in_days = 3
}