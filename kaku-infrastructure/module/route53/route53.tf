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