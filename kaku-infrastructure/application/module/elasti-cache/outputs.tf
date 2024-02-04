output "redis_endpoint" {
  value = aws_elasticache_cluster.default.cache_nodes.0.address
}