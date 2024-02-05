#ECRとの通信のためのエンドポイント_api
resource "aws_vpc_endpoint" "vpc_endpoint_ecr_api" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.subnet_vpc_endpoint_1_id]
  security_group_ids  = [var.sg_vpc_endpoint_id]
  private_dns_enabled = true
  tags = {
      Name = "${var.tag_name}-vpc-endpoint-ecr-api"
      group = "${var.tag_group}"
  }
}

#ECRとの通信のためのエンドポイント_dkr
resource "aws_vpc_endpoint" "vpc_endpoint_ecr_dkr" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.subnet_vpc_endpoint_1_id]
  security_group_ids  = [var.sg_vpc_endpoint_id]
  private_dns_enabled = true
  tags = {
      Name = "${var.tag_name}-vpc-endpoint-ecr-dkr"
      group = "${var.tag_group}"
  }
}

# CloudWatchLogsとの通信のためのエンドポイント
resource "aws_vpc_endpoint" "vpc_endpoint_logs" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.subnet_vpc_endpoint_1_id]
  security_group_ids  = [var.sg_vpc_endpoint_id]
  private_dns_enabled = true
  tags = {
      Name = "${var.tag_name}-vpc-endpoint-logs"
      group = "${var.tag_group}"
  }
}

# SecretsManagerとの通信のためのエンドポイント
resource "aws_vpc_endpoint" "vpc_endpoint_secretsmanager" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.secretsmanager"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.subnet_vpc_endpoint_1_id]
  security_group_ids  = [var.sg_vpc_endpoint_id]
  private_dns_enabled = true
  tags = {
      Name = "${var.tag_name}-vpc-endpoint-secretsmanager"
      group = "${var.tag_group}"
  }
}

# SSM エンドポイントの設定
resource "aws_vpc_endpoint" "vpc_endpoint_ssm" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.subnet_vpc_endpoint_1_id]
  security_group_ids  = [var.sg_vpc_endpoint_id]
  private_dns_enabled = true
  tags = {
      Name = "${var.tag_name}-vpc-endpoint-ssm"
      group = "${var.tag_group}"
  }
}


# SSM Messages エンドポイントの設定
resource "aws_vpc_endpoint" "vpc_endpoint_ssm_messages" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.subnet_vpc_endpoint_1_id]
  security_group_ids  = [var.sg_vpc_endpoint_id]
  private_dns_enabled = true
  tags = {
      Name = "${var.tag_name}-vpc-endpoint-ssmmessages"
      group = "${var.tag_group}"
  }
}

# firehose エンドポイントの設定
resource "aws_vpc_endpoint" "vpc_endpoint_firehose" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.kinesis-firehose"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.subnet_vpc_endpoint_1_id]
  security_group_ids  = [var.sg_vpc_endpoint_id]
  private_dns_enabled = true
  tags = {
      Name = "${var.tag_name}-vpc-endpoint-firehose"
      group = "${var.tag_group}"
  }
}

# S3との通信のためのエンドポイント
# ECRに格納されるイメージはS3に格納されるため、S3との通信のためのエンドポイントを作成する
resource "aws_vpc_endpoint" "vpc_endpoint_s3" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type   = "Gateway"
  route_table_ids     = [var.route_nodejs_id,var.route_puma_id]
  tags = {
      Name = "${var.tag_name}-vpc-endpoint-s3"
      group = "${var.tag_group}"
  }
}