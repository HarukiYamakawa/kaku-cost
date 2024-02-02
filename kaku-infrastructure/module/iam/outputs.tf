output "event_bridge_export_task_role_arn" {
    value = "${aws_iam_role.event_bridge_export_task_role.arn}"
}