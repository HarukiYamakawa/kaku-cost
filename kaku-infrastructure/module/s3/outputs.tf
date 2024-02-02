output "alb_access_logs_bucket_id" {
  value = "${aws_s3_bucket.alb_access_log_bucket.id}"
}

output "waf_traffic_log_bucket_arn" {
  value = "${aws_s3_bucket.waf_traffic_log_bucket.arn}"
}

output "rds_audit_log_bucket_name" {
  value = "${aws_s3_bucket.rds_audit_log_bucket.bucket}"
}