output "event_bridge_export_task_role_arn" {
    value = "${aws_iam_role.event_bridge_export_task_role.arn}"
}

output "ecs_task_execution_role_arn" {
    value = "${aws_iam_role.ecs_task_execution_role.arn}"
}

output "ecs_task_role_arn" {
    value = "${aws_iam_role.ecs_task_role.arn}"
}

output "firehose_ecs_rails_log_role_arn" {
    value = "${aws_iam_role.firehose_ecs_rails_log_role.arn}"
}

output "cwl_rails_role_arn" {
    value = "${aws_iam_role.cwl-rails-role.arn}"
}

output "firehose_ecs_nextjs_log_role_arn" {
    value = "${aws_iam_role.firehose_ecs_nextjs_log_role.arn}"
}

output "cwl_nextjs_role_arn" {
    value = "${aws_iam_role.cwl-nextjs-role.arn}"
}