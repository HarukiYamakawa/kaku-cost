resource "aws_s3_bucket" "vpc_flow_logs_bclg" {
  bucket = "${var.name_prefix}-vpc-flow-logs-bclg"

  tags = {
    Name = "${var.tag_name}-vpc-flow-logs-bclg"
    group = "${var.tag_group}"
  }
}

resource "aws_s3_bucket_public_access_block" "vpc_flow_logs_bclg_public_access_block" {
  bucket = aws_s3_bucket.vpc_flow_logs_bclg.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "vpc_flow_logs_bclg_policy_document" {
  statement {
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.vpc_flow_logs_bclg.arn}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }
  }
  statement {
    actions = [
      "s3:GetBucketAcl"
    ]

    resources = [
      aws_s3_bucket.vpc_flow_logs_bclg.arn
    ]

    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }
  }
}

resource "aws_s3_bucket_policy" "vpc_flow_logs_bclg_policy" {
  bucket = aws_s3_bucket.vpc_flow_logs_bclg.id
  policy = data.aws_iam_policy_document.vpc_flow_logs_bclg_policy_document.json
}

resource "aws_s3_bucket_lifecycle_configuration" "vpc_flow_logs_bclg_lifecycle_configuration" {
  bucket = aws_s3_bucket.vpc_flow_logs_bclg.id

  rule {
    id     = "transfer to glacier"
    status = "Enabled"

    transition {
      days          = 1
      storage_class = "GLACIER"
    }
  }

}