resource "aws_cloudtrail" "default" {
  name                          = "default"
  s3_bucket_name                = "${var.cloud_trail_log_bucket_name}"
  s3_key_prefix                 = "${var.name_prefix}/cloudtrail/"
  include_global_service_events = false
}