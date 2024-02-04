output "sg_alb_id" {
    value = "${aws_security_group.sg_alb.id}"
}

output "sg_nodejs_id" {
    value = "${aws_security_group.sg_nodejs.id}"
}

output "sg_puma_id" {
    value = "${aws_security_group.sg_puma.id}"
}

output "sg_mysql_id" {
    value = "${aws_security_group.sg_mysql.id}"
}

output "sg_vpc_endpoint_id" {
    value = "${aws_security_group.sg_vpc_endpoint.id}"
}