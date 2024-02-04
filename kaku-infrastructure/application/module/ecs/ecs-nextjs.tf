resource "aws_ecs_task_definition" "task_nodejs" {
  family                = "${var.name_prefix}-nodejs"
  requires_compatibilities = ["FARGATE"]
  network_mode          = "awsvpc"
  cpu    = "${var.task_cpu_nodejs}"
  memory = "${var.task_memory_nodejs}"
  execution_role_arn    = "${var.execution_role_arn}"

  container_definitions = jsonencode([{
    name  = "kaku_nodejs",
    image = "${var.image_nodejs}:${var.image_nodejs_version}",
    essential: true,
    memoryReservation = "${var.task_container_memory_reservation_nodejs}",
    memory = "${var.task_container_memory_nodejs}",
    cpu = "${var.task_container_cpu_nodejs}",
    portMappings: [
      {
        protocol: "tcp",
        containerPort: 80
      }
    ],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-group"         = "${var.cloudwatch_log_group_arn_nodejs}",
        "awslogs-region"        = "ap-northeast-1",
        "awslogs-stream-prefix" = "${var.name_prefix}-nodejs-task"
      }
    }
    environment = [
      {
        name  = "NEXT_PUBLIC_RAILS_API_URL",
        value = "${var.public_rails_api_url}"
      },
      {
        name  = "NEXT_PRIVATE_RAILS_API_URL",
        value = "${var.private_rails_api_url}"
      }
    ]
  }])

}

resource "aws_ecs_cluster" "cluster_nodejs" {
  name = "${var.name_prefix}-nodejs"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "service_nodejs" {
	name = "${var.name_prefix}-nodejs"
	launch_type = "FARGATE"
  platform_version = "1.4.0"

	task_definition = aws_ecs_task_definition.task_nodejs.arn
	desired_count = "${var.task_count_nodejs}"

  health_check_grace_period_seconds = "${var.task_health_check_grace_period_seconds_nodejs}"

	cluster = aws_ecs_cluster.cluster_nodejs.id

	network_configuration {
		# subnets         = [var.subnet_node_1_id, var.subnet_node_2_id]
    subnets         = [var.subnet_node_1_id]
		security_groups = [var.sg_nodejs_id]
    assign_public_ip = false
	}

	load_balancer {
			target_group_arn = var.tg_nodejs_arn
			container_name   = "kaku_nodejs"
			container_port   = "80"
		}
}