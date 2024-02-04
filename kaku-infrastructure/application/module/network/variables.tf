variable name_prefix {}
variable tag_name {}
variable tag_group {}

locals {
  vpc_cidr = "10.0.0.0/16"
  az_1 = "ap-northeast-1a"
  az_2 = "ap-northeast-1c"
  ingress_subnet_1_cidr = "10.0.1.0/24"
  ingress_subnet_2_cidr = "10.0.2.0/24"
  nodejs_subnet_1_cidr = "10.0.3.0/24"
  puma_subnet_1_cidr = "10.0.5.0/24"
  mysql_subnet_1_cidr = "10.0.7.0/24"
  mysql_subnet_2_cidr = "10.0.8.0/24"
  vpc_endpoint_subnet_1_cidr = "10.0.11.0/24"
  redis_subnet_1_cidr = "10.0.9.0/24"
}