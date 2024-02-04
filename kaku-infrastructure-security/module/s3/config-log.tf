resource "aws_s3_bucket" "config_log_bucket" {
  bucket = "${var.name_prefix}-config-log-bucket"

  tags = {
    Name = "${var.tag_name}-config-log-bucket"
    group = "${var.tag_group}"
  }
}

resource "aws_s3_bucket_public_access_block" "config_log_bucket_public_access_block" {
  bucket = aws_s3_bucket.config_log_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "config_log_bucket_policy_document" {
  statement {
    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.config_log_bucket.arn}/*",
    ]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
  }
  statement {
    actions = [
      "s3:GetBucketAcl",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.config_log_bucket.arn
    ]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
  }
}

resource "aws_s3_bucket_policy" "config_log_bucket_policy" {
  bucket = aws_s3_bucket.config_log_bucket.id
  policy = data.aws_iam_policy_document.config_log_bucket_policy_document.json
}

resource "aws_s3_bucket_lifecycle_configuration" "config_log_bucket_lifecycle_configuration" {
  bucket = aws_s3_bucket.config_log_bucket.id

  rule {
    id     = "transfer to glacier"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }

}

# アクセスログの送信先を定義
resource "aws_s3_bucket_logging" "config_log_bucket_logging" {
  bucket        = aws_s3_bucket.config_log_bucket.id
  target_bucket = aws_s3_bucket.config_log_bucket_bclg.id
  target_prefix = "config-log-bclg"
}