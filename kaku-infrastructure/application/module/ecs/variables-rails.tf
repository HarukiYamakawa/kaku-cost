variable subnet_puma_1_id {}
# variable subnet_puma_2_id {}
variable sg_puma_id {}
variable image_puma {}
variable image_puma_version {}

variable execution_role_arn {}
variable task_role_arn {}
variable cloudwatch_log_group_arn_puma {}

variable tg_puma_arn {}

variable primary_db_host {}
variable db_name {}
variable redis_host {}

variable db_secret_username {}
variable db_secret_password {}

variable domain_name {}

variable task_cpu_puma {}
variable task_memory_puma {}
variable task_container_memory_reservation_puma {}
variable task_container_memory_puma {}
variable task_container_cpu_puma {}
variable task_count_puma {}
variable task_health_check_grace_period_seconds_puma {}

variable service_discovery_arn {}

#firelens用の設定
variable image_puma_firelens {}
variable image_puma_firelens_version {}