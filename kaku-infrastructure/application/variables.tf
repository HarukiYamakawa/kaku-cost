variable name_prefix {
  default = "kaku"
}

variable tag_name {
  default = "kaku"
}

variable tag_group {
  default = "kaku"
}

variable service_discovery_sub_domain_name {
  default = "puma"
}
variable service_discovery_domain_name {
  default = "kaku.local"
}

# pumaのタスク定義用
variable image_puma_version {
  default = "v2"
}
variable task_cpu_puma {
  default = 256
}
variable task_memory_puma {
  default = 512
}
variable task_container_memory_reservation_puma {
  default = 512
}
variable task_container_memory_puma {
  default = 512
}
variable task_container_cpu_puma {
  default = 256
}
variable task_count_puma {
  default = 1
}
variable task_health_check_grace_period_seconds_puma {
  default = 60
}

