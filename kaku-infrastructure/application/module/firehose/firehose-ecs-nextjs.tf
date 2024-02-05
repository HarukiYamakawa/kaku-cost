#firehoseのストリーミング
resource "aws_kinesis_firehose_delivery_stream" "nextjs_log_delivery_stream" {
  name        = "nextjs-log-delivery-stream"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = "${var.iam_role_firehose_nextjs_arn}"
    #保存先のS3バケット
    bucket_arn = "${var.s3_bucket_log_nextjs_arn}"
    #10MB毎にファイルを分割
    buffering_size     = 10
    #300秒毎にファイルを分割
    buffering_interval  = 300
    prefix = "nextjs-log-streaming/"
  }
}

resource "aws_cloudwatch_log_subscription_filter" "cloudwatch_to_firehose_nextjs" {
  name            = "cloudwatch-to-firehose-nextjs"
  log_group_name  = "/kaku/nodejs"
  #ロググループのログを全て取得
  filter_pattern  = ""
  destination_arn = aws_kinesis_firehose_delivery_stream.nextjs_log_delivery_stream.arn
  role_arn        = "${var.iam_role_cwl_firehose_nextjs_arn}"
}