#firehoseのストリーミング
resource "aws_kinesis_firehose_delivery_stream" "rails_log_delivery_stream" {
  name        = "rails-log-delivery-stream"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = "${var.iam_role_firehose_arn}"
    #保存先のS3バケット
    bucket_arn = "${var.s3_bucket_log_rails_arn}"
    #10MB毎にファイルを分割
    buffering_size     = 10
    #300秒毎にファイルを分割
    buffering_interval  = 300
    prefix = "rails-log-streaming/"
  }
}
