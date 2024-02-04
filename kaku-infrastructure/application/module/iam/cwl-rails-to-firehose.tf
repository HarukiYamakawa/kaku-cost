resource "aws_iam_policy" "cwl-rails-policy" {
  name = "${var.name_prefix}-cwl-rails-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "firehose:*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_role" "cwl-rails-role" {
  name = "${var.name_prefix}-cwl-rails-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "logs.ap-northeast-1.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "cwl-rails-policy-attachment" {
  role       = aws_iam_role.cwl-rails-role.name
  policy_arn = aws_iam_policy.cwl-rails-policy.arn
}