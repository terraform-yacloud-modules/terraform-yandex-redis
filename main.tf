resource "yandex_mdb_redis_cluster" "this" {
  name        = var.name
  description = var.description

  environment = var.environment
  network_id  = var.network_id
  folder_id   = var.folder_id

  persistence_mode    = var.persistence_mode
  deletion_protection = var.deletion_protection
  sharded             = var.sharded
  tls_enabled         = var.tls_enabled

  config {
    password = var.password

    version   = var.redis_version
    databases = var.databases
    timeout   = var.timeout

    maxmemory_policy                  = var.maxmemory_policy
    notify_keyspace_events            = var.notify_keyspace_events
    slowlog_log_slower_than           = var.slowlog_log_slower_than
    slowlog_max_len                   = var.slowlog_max_len
    client_output_buffer_limit_normal = var.client_output_buffer_limit_normal
    client_output_buffer_limit_pubsub = var.client_output_buffer_limit_pubsub
  }

  resources {
    resource_preset_id = var.resource_preset_id
    disk_size          = var.disk_size
    disk_type_id       = var.disk_type_id
  }

  lifecycle {
    precondition {
      condition = length([
        for host in var.hosts : host.zone
        if !contains(["ru-central1-a", "ru-central1-b", "ru-central1-c", "ru-central1-d"], host.zone)
      ]) == 0
      error_message = join(", ", [
        for host in var.hosts : "Host ${host.key} has invalid zone '${host.zone}'"
        if !contains(["ru-central1-a", "ru-central1-b", "ru-central1-c", "ru-central1-d"], host.zone)
      ])
    }
  }

  dynamic "host" {
    for_each = var.hosts
    content {
      zone      = host.value.zone
      subnet_id = host.value.subnet_id

      shard_name = var.sharded ? lookup(host.value, "shard_name", "shard-${host.key}") : null

      replica_priority = var.sharded ? null : var.replica_priority
      assign_public_ip = var.tls_enabled ? lookup(host.value, "assign_public_ip", var.assign_public_ip) : false
    }
  }

  security_group_ids = var.security_group_ids

  labels = var.labels

  maintenance_window {
    type = var.type

    hour = var.type == "ANYTIME" ? null : var.hour
    day  = var.type == "ANYTIME" ? null : var.day
  }
}
