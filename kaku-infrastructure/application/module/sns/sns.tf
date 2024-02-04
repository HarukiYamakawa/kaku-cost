resource "aws_sns_topic" "alart_topic" {
  name = "${var.name_prefix}-alart-topic"
}

resource "aws_sns_topic_subscription" "alart-topic-subscription" {
  topic_arn = aws_sns_topic.alart_topic.arn
  protocol  = "email"
  endpoint  = "${var.email}"
}