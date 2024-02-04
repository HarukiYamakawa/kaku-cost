resource "aws_sns_topic" "security_alart_topic" {
  name = "${var.name_prefix}-security-alart-topic"
}

resource "aws_sns_topic_subscription" "security_alart_topic_subscription" {
  topic_arn = aws_sns_topic.security_alart_topic.arn
  protocol  = "email"
  endpoint  = "${var.email}"
}

# EventBridgeのアラートを通知するための、SNSトピックポリシーを設定
resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.security_alart_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.security_alart_topic.arn]
  }
}