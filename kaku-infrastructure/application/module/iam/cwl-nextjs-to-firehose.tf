resource "aws_iam_policy" "cwl-nextjs-policy" {
  name = "${var.name_prefix}-cwl-nextjs-policy"
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

resource "aws_iam_role" "cwl-nextjs-role" {
  name = "${var.name_prefix}-cwl-nextjs-role"

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

resource "aws_iam_role_policy_attachment" "cwl-nextjs-policy-attachment" {
  role       = aws_iam_role.cwl-nextjs-role.name
  policy_arn = aws_iam_policy.cwl-nextjs-policy.arn
}