resource "aws_lb" "default" {
  name               = "${var.name_prefix}-alb"
  load_balancer_type = "application"
  internal           = false
  idle_timeout = 60
  enable_deletion_protection = false

  subnets= [
    var.subnet_ingress_1_id,
    var.subnet_ingress_2_id
  ]

  security_groups    = [var.sg_alb_id]

  tags = {
    Name = "${var.tag_name}-alb"
    group = "${var.tag_group}"
  }
}

#node.jsへのターゲットグループを定義
resource "aws_lb_target_group" "tg_nodejs" {
  name     = "${var.name_prefix}-alb-tg-nodejs"
  target_type = "ip"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    path                = "/next-api/health-check"
    port = "traffic-port"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
  }

  tags = {
    Name = "${var.tag_name}-alb-tg-nodejs"
    group = "${var.tag_group}"
  }
}

#pumaへのターゲットグループを定義
resource "aws_lb_target_group" "tg_puma" {
  name     = "${var.name_prefix}-alb-tg-puma"
  target_type = "ip"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    path                = "/api/v1/health_check"
    port = "traffic-port"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
  }

  tags = {
    Name = "${var.tag_name}-alb-tg-puma"
    group = "${var.tag_group}"
  }
}


#port443でのnode.js用のターゲットグループへのリスナー(ルール)を定義
resource "aws_lb_listener" "alb_listener_https" {
  load_balancer_arn = aws_lb.default.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_nodejs.arn
  }
}

#port443のpuma用のターゲットグループへのリスナールールを定義
resource "aws_lb_listener_rule" "https-rule-puma" {
  listener_arn = aws_lb_listener.alb_listener_https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_puma.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}

#port80へのリクエストをport443へリダイレクトするリスナーを定義
resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_lb.default.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}