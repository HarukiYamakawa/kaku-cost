resource "aws_s3_bucket" "ecs_nextjs_log_bucket_bclg" {
  bucket = "${var.name_prefix}-ecs-nextjs-log-bclg"

  tags = {
    Name = "${var.tag_name}-ecs-nextjs-log-bclg"
    group = "${var.tag_group}"
  }
}

resource "aws_s3_bucket_public_access_block" "ecs_nextjs_log_bucket_bclg_public_access_block" {
  bucket = aws_s3_bucket.ecs_nextjs_log_bucket_bclg.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "ecs_nextjs_log_bucket_bclg_policy_document" {
  statement {
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.ecs_nextjs_log_bucket_bclg.arn}/*"
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
      aws_s3_bucket.ecs_nextjs_log_bucket_bclg.arn
    ]

    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }
  }
}

resource "aws_s3_bucket_policy" "ecs_nextjs_log_bucket_bclg_policy" {
  bucket = aws_s3_bucket.ecs_nextjs_log_bucket_bclg.id
  policy = data.aws_iam_policy_document.ecs_nextjs_log_bucket_bclg_policy_document.json
}

resource "aws_s3_bucket_lifecycle_configuration" "ecs_nextjs_log_bucket_bclg_lifecycle_configuration" {
  bucket = aws_s3_bucket.ecs_nextjs_log_bucket_bclg.id

  rule {
    id     = "transfer to glacier"
    status = "Enabled"

    transition {
      days          = 1
      storage_class = "GLACIER"
    }
  }

}