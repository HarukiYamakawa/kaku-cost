resource "aws_iam_policy" "firehose_ecs_nextjs_log_policy" {
  name = "${var.name_prefix}-firehose-ecs-nextjs-log-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:AbortMultipartUpload",
              "s3:GetBucketLocation",
              "s3:GetObject",
              "s3:ListBucket",
              "s3:ListBucketMultipartUploads",
              "s3:PutObject"
            ],
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_role" "firehose_ecs_nextjs_log_role" {
  name = "${var.name_prefix}-firehose-ecs-nextjs-log-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "firehose.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "firehose_ecs_nextjs_log_policy_attachment" {
  role       = aws_iam_role.firehose_ecs_nextjs_log_role.name
  policy_arn = aws_iam_policy.firehose_ecs_nextjs_log_policy.arn
}