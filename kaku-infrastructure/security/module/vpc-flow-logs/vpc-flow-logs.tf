resource "aws_flow_log" "default" {
  log_destination      = "${var.vpc_flow_log_bucket_arn}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = "${var.vpc_id}"
}