#バックエンドコンテナ用のタスク定義
resource "aws_ecs_task_definition" "task_puma" {
  family                = "${var.name_prefix}-puma"
  requires_compatibilities = ["FARGATE"]
  network_mode          = "awsvpc"
  cpu    = "${var.task_cpu_puma}"
  memory = "${var.task_memory_puma}"
  execution_role_arn    = "${var.execution_role_arn}"
  task_role_arn         = "${var.task_role_arn}"

  container_definitions = jsonencode([{
    name  = "kaku_puma",
    image = "${var.image_puma}:${var.image_puma_version}",
    essential: true,
    memoryReservation = "${var.task_container_memory_reservation_puma}"
    memory = "${var.task_container_memory_puma}",
    cpu = "${var.task_container_cpu_puma}",
    portMappings: [
      {
        protocol: "tcp",
        containerPort: 80
      }
    ],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-group"         = "${var.cloudwatch_log_group_arn_puma}",
        "awslogs-region"        = "ap-northeast-1",
        "awslogs-stream-prefix" = "${var.name_prefix}-puma-task"
      }
    },
    secrets     = [
      {
        name= "DATABASE_USERNAME",
        valueFrom = "${var.db_secret_username}"
      },
      {
        name= "DATABASE_PASSWORD",
        valueFrom= "${var.db_secret_password}"
      }
    ],
    environment = [
      {
        name  = "DATABASE_HOST",
        value = "${var.primary_db_host}"
      },
      {
        name  = "DATABASE_NAME",
        value = "${var.db_name}"
      },
      {
        name      = "FRONT_DOMAIN",
        value = "https://${var.domain_name}"
      }
    ]
  }])

}

#バックエンドのecrクラスターを定義
resource "aws_ecs_cluster" "cluster_puma" {
  name = "${var.name_prefix}-puma"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "service_puma" {
	name = "${var.name_prefix}-puma"
	launch_type = "FARGATE"
  platform_version = "1.4.0"

	task_definition = aws_ecs_task_definition.task_puma.arn
	desired_count = "${var.task_count_puma}"

  health_check_grace_period_seconds = "${var.task_health_check_grace_period_seconds_puma}"

	cluster = aws_ecs_cluster.cluster_puma.id

  enable_execute_command = true

	network_configuration {
		# subnets         = [var.subnet_puma_1_id, var.subnet_puma_2_id]
    subnets         = [var.subnet_puma_1_id]
		security_groups = [var.sg_puma_id]
    assign_public_ip = false
	}

	load_balancer {
			target_group_arn = var.tg_puma_arn
			container_name   = "kaku_puma"
			container_port   = "80"
		}
  service_registries {
    registry_arn = var.service_discovery_arn
  }
}