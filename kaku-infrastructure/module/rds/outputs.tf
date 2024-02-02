output "primary_db_host" {
  value = aws_rds_cluster.default.endpoint
}

output "reader_db_host" {
  value = aws_rds_cluster.default.reader_endpoint
}

output "db_name" {
  value = aws_rds_cluster.default.database_name
}