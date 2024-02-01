output "alb_dns_name" {
    value = "${aws_lb.default.dns_name}"
}

output "alb_zone_id" {
    value = "${aws_lb.default.zone_id}"
}

output "tg_puma_arn" {
    value = "${aws_lb_target_group.tg_puma.arn}"
}

output "tg_nodejs_arn" {
    value = "${aws_lb_target_group.tg_nodejs.arn}"
}

output "alb_arn" {
    value = "${aws_lb.default.arn}"
}