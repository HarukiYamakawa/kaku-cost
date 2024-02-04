resource "aws_s3_bucket" "alb_access_log_bucket" {
  bucket = "${var.name_prefix}-alb-access-log"

  tags = {
    Name = "${var.tag_name}-alb-access-log"
    group = "${var.tag_group}"
  }
}

resource "aws_s3_bucket_public_access_block" "alb_access_log_bucket_public_access_block" {
  bucket = aws_s3_bucket.alb_access_log_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "alb_access_log_bucket_policy_document" {
  statement {
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.alb_access_log_bucket.arn}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::582318560864:root"]
    }
  }
}

resource "aws_s3_bucket_policy" "alb_access_log_bucket_policy" {
  bucket = aws_s3_bucket.alb_access_log_bucket.id
  policy = data.aws_iam_policy_document.alb_access_log_bucket_policy_document.json
}

resource "aws_s3_bucket_lifecycle_configuration" "alb_access_log_bucket_lifecycle_configuration" {
  bucket = aws_s3_bucket.alb_access_log_bucket.id

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
resource "aws_s3_bucket_logging" "alb_access_log_bucket_logging" {
  bucket        = aws_s3_bucket.alb_access_log_bucket.id
  target_bucket = aws_s3_bucket.alb_access_log_bucket_bclg.id
  target_prefix = "alb-access-log-bclg"
}