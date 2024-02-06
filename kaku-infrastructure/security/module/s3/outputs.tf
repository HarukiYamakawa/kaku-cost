output "config_log_bucket_name" {
  value = "${aws_s3_bucket.config_log_bucket.bucket}"
}

output "cloud_trail_log_bucket_name" {
  value = "${aws_s3_bucket.cloud_trail_log_bucket.bucket}"
}

output "vpc_flow_log_bucket_arn" {
  value = "${aws_s3_bucket.vpc_flow_log_bucket.arn}"
}