output "config_log_bucket_name" {
  value = "${aws_s3_bucket.config_log_bucket.bucket}"
}