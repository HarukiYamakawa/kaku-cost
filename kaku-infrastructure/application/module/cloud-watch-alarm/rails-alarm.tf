#メトリクスフィルターの作成
resource "aws_cloudwatch_log_metric_filter" "puma-status-500-filter" {
  name           = "status-500"
  pattern        = "Completed 500"
  log_group_name = "${var.rails_log_group_name}"

  metric_transformation {
    #pumaのメトリクスフィルターの名前空間
    namespace = "${var.name_prefix}/puma/metric-filter"
    #メトリクス名
    name      = "Status-500"
    value     = "1"
  }
}

#上記のメトリクスフィルターに対するアラームの作成
resource "aws_cloudwatch_metric_alarm" "puma-status-500-alarm" {
  alarm_name          = "status-500"
  namespace           = "${var.name_prefix}/puma/metric-filter"
  metric_name         = "Status-500"
  period              = 300
  statistic           = "Sum"
  threshold           = 5
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1

  alarm_actions     = ["${var.alart_topic_arn}"]
}

#タスクのCPU使用率のメトリクスに対するアラームの作成
# resource "aws_cloudwatch_metric_alarm" "ecs-rails-cpu-usage" {
#   alarm_name          = "ecs-rails-cpu-usage"
#   namespace           = "AWS/ECS"
#   metric_name         = "CPUUtilization"
#   dimensions = {
#     ServiceName = "kaku-puma"
#     ClusterName = "kaku-puma"
#   }
#   #30秒間の平均値が0.25％以上の場合にアラームを発生
#   period              = 30
#   statistic           = "Average"
#   threshold           = 0.24
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = 1

#   alarm_actions     = ["${var.alart_topic_arn}"]
# }