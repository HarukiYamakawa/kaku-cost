resource "aws_iam_policy" "event_bridge_export_task_policy" {
  name = "${var.name_prefix}-event-bridge-export-task-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateExportTask",
                "logs:CancelExportTask",
                "logs:DescribeExportTasks",
                "logs:DescribeLogStreams",
                "logs:DescribeLogGroups"
            ],
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_role" "event_bridge_export_task_role" {
  name = "${var.name_prefix}-event-bridge-export-task-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "scheduler.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "event_bridge_export_task_policy_attachment" {
  role       = aws_iam_role.event_bridge_export_task_role.name
  policy_arn = aws_iam_policy.event_bridge_export_task_policy.arn
}