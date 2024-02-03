# resource "aws_cloudwatch_metric_alarm" "alb_status_5xx" {
#   alarm_name          = "alb-status-5xx"
#   namespace           = "AWS/ApplicationELB"
#   metric_name         = "HTTPCode_ELB_5XX_Count"
#   dimensions = {
#     LoadBalancer = "app/kaku-alb/e19ee504b591caa8"
#   }
#   period              = 120
#   statistic           = "Sum"
#   threshold           = 5
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = 1

#   alarm_actions     = ["${var.alart_topic_arn}"]
# }