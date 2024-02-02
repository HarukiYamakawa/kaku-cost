#サブネットグループを作成
resource "aws_db_subnet_group" "default" {
  name = "${var.name_prefix}_rds_subnet_group"

  subnet_ids = [
    var.subnet_mysql_1_id,
    var.subnet_mysql_2_id
  ]

  tags = {
    Name = "${var.tag_name}-rds-subnet-group"
  }
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "${var.name_prefix}-rds-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.04.1"

  database_name           = "${var.name_prefix}_db"
  master_username         = "admin"
  manage_master_user_password = true

  db_subnet_group_name    = aws_db_subnet_group.default.name

  vpc_security_group_ids  = [var.sg_mysql_id]

  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  preferred_maintenance_window = "sun:04:00-sun:06:00"

   #監査ログをCloudWatch Logsに出力
   enabled_cloudwatch_logs_exports = ["audit"]

  skip_final_snapshot = true
  network_type = "IPV4"
  port = 3306
}

#RDS Aurora プライマリインスタンスの定義
resource "aws_rds_cluster_instance" "primary_instances" {
  identifier         = "${var.name_prefix}-rds-cluster-primary"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
  publicly_accessible = false
}