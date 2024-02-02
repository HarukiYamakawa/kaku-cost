resource "aws_scheduler_schedule" "rds_audit_log_export_scheduler" {
  name = "rds-audit-log-export-scheduler"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "rate(24 hours)"

  target {
    # CloudWatchLogsのsdkのarn
    arn      = "arn:aws:scheduler:::aws-sdk:cloudwatchlogs:createExportTask"
    role_arn = "${var.iam_role_event_bridge_export_task_arn}"
    input = jsonencode({
      "Destination": "${var.s3_bucket_log_rds_name}",
      "DestinationPrefix": "exported-logs",
      "From": 1670000000000,
      "LogGroupName": "/aws/rds/cluster/kaku-rds-cluster/audit",
      "To": 5000000000000
  })
}
}