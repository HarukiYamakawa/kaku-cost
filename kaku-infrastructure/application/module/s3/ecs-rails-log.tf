resource "aws_s3_bucket" "ecs_rails_log_bucket" {
  bucket = "${var.name_prefix}-ecs-rails-log"

  tags = {
    Name = "${var.tag_name}-ecs-rails-log"
    group = "${var.tag_group}"
  }
}

resource "aws_s3_bucket_public_access_block" "ecs_rails_log_bucket_public_access_block" {
  bucket = aws_s3_bucket.ecs_rails_log_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# アクセスログの送信先を定義
resource "aws_s3_bucket_logging" "ecs_rails_log_bucket_logging" {
  bucket        = aws_s3_bucket.ecs_rails_log_bucket.id
  target_bucket = aws_s3_bucket.alb_access_log_bucket_bclg.id
  target_prefix = "ecs-rails-log"
}