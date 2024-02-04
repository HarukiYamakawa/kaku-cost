resource "aws_cloudwatch_metric_alarm" "waf-sql-rule-set-count" {
  alarm_name          = "waf-sql-rule-set-count"
  namespace           = "AWS/WAFV2"
  metric_name         = "BlockedRequests"
  dimensions = {
    ManagedRuleGroup = "AWSManagedRulesSQLiRuleSet"
    WebACL           = "kaku-waf"
    Region           = "ap-northeast-1"
  }
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1

  alarm_actions     = ["${var.alart_topic_arn}"]
}