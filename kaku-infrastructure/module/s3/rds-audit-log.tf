resource "aws_s3_bucket" "rds_audit_log_bucket" {
  bucket = "${var.name_prefix}-rds-audit-log"

  tags = {
    Name = "${var.tag_name}-rds-audit-log"
    group = "${var.tag_group}"
  }
}

resource "aws_s3_bucket_public_access_block" "rds_audit_log_bucket_public_access_block" {
  bucket = aws_s3_bucket.rds_audit_log_bucket.id

  #外部からの読み込みを許可しない
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

#CloudWatch LogsからS3へのログ出力を許可する
data "aws_iam_policy_document" "rds_audit_log_bucket_policy_document" {
  statement {
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.rds_audit_log_bucket.arn}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["logs.ap-northeast-1.amazonaws.com"]
    }
  }
  statement {
    actions = [
      "s3:GetBucketAcl"
    ]

    resources = [
      aws_s3_bucket.rds_audit_log_bucket.arn
    ]

    principals {
      type        = "Service"
      identifiers = ["logs.ap-northeast-1.amazonaws.com"]
    }
  }
}

resource "aws_s3_bucket_policy" "rds_audit_log_bucket_policy" {
  bucket = aws_s3_bucket.rds_audit_log_bucket.id
  policy = data.aws_iam_policy_document.rds_audit_log_bucket_policy_document.json
}

resource "aws_s3_bucket_lifecycle_configuration" "rds_audit_log_bucket_lifecycle_configuration" {
  bucket = aws_s3_bucket.rds_audit_log_bucket.id

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
resource "aws_s3_bucket_logging" "rds_audit_log_bucket_logging" {
  bucket        = aws_s3_bucket.rds_audit_log_bucket.id
  target_bucket = aws_s3_bucket.rds_audit_log_bucket_bclg.id
  target_prefix = "rds-audit-log-bclg"
}