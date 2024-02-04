# ALB用のセキュリティグループを定義
resource "aws_security_group" "sg_alb" {
  name        = "${var.name_prefix}-sg-alb"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_name}-sg-alb"
    group = "${var.tag_group}"
  }
}

resource "aws_security_group_rule" "sg_alb_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_alb.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sg_alb_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_alb.id
  cidr_blocks = ["0.0.0.0/0"]
}



resource "aws_security_group_rule" "sg_alb_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_alb.id
  cidr_blocks = ["0.0.0.0/0"]
}

#node.js用のセキュリティグループを定義
resource "aws_security_group" "sg_nodejs" {
  name        = "${var.name_prefix}-sg-nodejs"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_name}-sg-nodejs"
    group = "${var.tag_group}"
  }
}

resource "aws_security_group_rule" "sg_nodejs_ingress_http_from_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_nodejs.id
  source_security_group_id = aws_security_group.sg_alb.id
}

resource "aws_security_group_rule" "sg_nodejs_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_nodejs.id
  cidr_blocks = ["0.0.0.0/0"]
}

#puma用のセキュリティグループを定義
resource "aws_security_group" "sg_puma" {
  name        = "${var.name_prefix}-sg-puma"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_name}-sg-puma"
    group = "${var.tag_group}"
  }
}

resource "aws_security_group_rule" "sg_puma_ingress_http_from_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_puma.id
  source_security_group_id = aws_security_group.sg_alb.id
}

resource "aws_security_group_rule" "sg_puma_ingress_http_from_nodejs" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_puma.id
  source_security_group_id = aws_security_group.sg_nodejs.id
}


resource "aws_security_group_rule" "sg_puma_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_puma.id
  cidr_blocks = ["0.0.0.0/0"]
}

#mysql用のセキュリティグループを定義
resource "aws_security_group" "sg_mysql" {
  name        = "${var.name_prefix}-sg-mysql"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_name}-sg-mysql"
    group = "${var.tag_group}"
  }
}

resource "aws_security_group_rule" "sg_mysql_ingress_mysql_from_puma" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_mysql.id
  source_security_group_id = aws_security_group.sg_puma.id
}

resource "aws_security_group_rule" "sg_mysql_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_mysql.id
  cidr_blocks = ["0.0.0.0/0"]
}

#vpcendpoint用のセキュリティグループを定義
resource "aws_security_group" "sg_vpc_endpoint" {
  name        = "${var.name_prefix}-sg-vpc-endpoint"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_name}-sg-vpc-endpoint"
    group = "${var.tag_group}"
  }
}

resource "aws_security_group_rule" "sg_vpc_endpoint_ingress_https_from_nodejs" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_vpc_endpoint.id
  source_security_group_id = aws_security_group.sg_nodejs.id
}

resource "aws_security_group_rule" "sg_vpc_endpoint_ingress_https_from_puma" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_vpc_endpoint.id
  source_security_group_id = aws_security_group.sg_puma.id
}

resource "aws_security_group_rule" "sg_vpc_endpoint_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_vpc_endpoint.id
  cidr_blocks = ["0.0.0.0/0"]
}