resource "aws_cloudwatch_event_rule" "security_hub" {
  name        = "security_hub_event"
  description = "security_hub_event"

  event_pattern = jsonencode({
    "source": [
        "aws.securityhub"
    ],
    "detail-type": [
        "Security Hub Findings - Imported"
    ]
    })
}

resource "aws_cloudwatch_event_target" "security_hub_to_sns" {
  rule      = aws_cloudwatch_event_rule.security_hub.name
  target_id = "SendToSNS"
  arn       = "${var.sns_arn}"
}