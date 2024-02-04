# Route53にALBのDNSと紐づけるAレコードを作成
resource "aws_route53_record" "default" {
  zone_id = var.domain_zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# Route53にService Discovery用のプライベートDNSのホストゾーンを作成
resource "aws_service_discovery_private_dns_namespace" "default" {
  name = var.service_discovery_domain_name
  vpc  = var.vpc_id
}

resource "aws_service_discovery_service" "default" {
  name              = var.service_discovery_sub_domain_name
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.default.id
    dns_records {
      ttl  = 10
      type = "A"
    }
  }
}