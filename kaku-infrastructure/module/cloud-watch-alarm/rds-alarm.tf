resource "aws_cloudwatch_metric_alarm" "rds_connections" {
  alarm_name          = "rds-connections"
  namespace           = "AWS/RDS"
  metric_name         = "DatabaseConnections"
  period              = 60
  statistic           = "Minimum"
  threshold           = 5
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1

  alarm_actions     = ["${var.alart_topic_arn}"]
}