output "alb_access_logs_bucket_id" {
  value = "${aws_s3_bucket.alb_access_log_bucket.id}"
}