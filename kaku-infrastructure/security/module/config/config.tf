#レコーダーの有効化
resource "aws_config_configuration_recorder_status" "default" {
  name       = "default"
  is_enabled = true
  depends_on = [aws_config_delivery_channel.default]
}

#「記録方法」の設定
resource "aws_config_configuration_recorder" "default" {
  role_arn = "${var.config_role_arn}"

  #全てのリソースを記録する
  recording_group {
    all_supported                 = true
    include_global_resource_types = true
    resource_types                = []
  }
}

#「配信方法」の設定
resource "aws_config_delivery_channel" "default" {
  name           = "default"
  s3_bucket_name = "${var.config_log_bucket_name}"
}