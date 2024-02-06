resource "aws_s3_bucket" "vpc_flow_log_bucket" {
  bucket = "${var.name_prefix}-vpc-flow-logs"

  tags = {
    Name = "${var.tag_name}-vpc-flow-logs"
    group = "${var.tag_group}"
  }
}

resource "aws_s3_bucket_public_access_block" "vpc_flow_log_bucket_public_access_block" {
  bucket = aws_s3_bucket.vpc_flow_log_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "vpc_flow_log_bucket_policy_document" {
  statement {
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.vpc_flow_log_bucket.arn}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
  }
  statement {
    actions = [
      "s3:GetBucketAcl"
    ]

    resources = [
      aws_s3_bucket.vpc_flow_log_bucket.arn
    ]

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
  }
}

resource "aws_s3_bucket_policy" "vpc_flow_log_bucket_policy" {
  bucket = aws_s3_bucket.vpc_flow_log_bucket.id
  policy = data.aws_iam_policy_document.vpc_flow_log_bucket_policy_document.json
}