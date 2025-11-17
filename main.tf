resource "yandex_mdb_redis_cluster" "this" {
  name        = var.name
  description = var.description

  environment = var.environment
  network_id  = var.network_id
  folder_id   = var.folder_id

  persistence_mode       = var.persistence_mode
  deletion_protection    = var.deletion_protection
  sharded                = var.sharded
  tls_enabled            = var.tls_enabled
  announce_hostnames     = var.announce_hostnames
  auth_sentinel          = var.auth_sentinel
  disk_encryption_key_id = var.disk_encryption_key_id

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

    maxmemory_percent                   = var.maxmemory_percent
    lua_time_limit                      = var.lua_time_limit
    repl_backlog_size_percent           = var.repl_backlog_size_percent
    cluster_require_full_coverage       = var.cluster_require_full_coverage
    cluster_allow_reads_when_down       = var.cluster_allow_reads_when_down
    cluster_allow_pubsubshard_when_down = var.cluster_allow_pubsubshard_when_down
    lfu_decay_time                      = var.lfu_decay_time
    lfu_log_factor                      = var.lfu_log_factor
    turn_before_switchover              = var.turn_before_switchover
    allow_data_loss                     = var.allow_data_loss
    use_luajit                          = var.use_luajit
    io_threads_allowed                  = var.io_threads_allowed
    zset_max_listpack_entries           = var.zset_max_listpack_entries

    dynamic "backup_window_start" {
      for_each = var.backup_window_start != null ? [var.backup_window_start] : []
      content {
        hours   = backup_window_start.value.hours
        minutes = lookup(backup_window_start.value, "minutes", null)
      }
    }
  }

  resources {
    resource_preset_id = var.resource_preset_id
    disk_size          = var.disk_size
    disk_type_id       = var.disk_type_id
  }

  dynamic "host" {
    for_each = var.hosts
    content {
      zone      = host.value.zone
      subnet_id = host.value.subnet_id

      shard_name = var.sharded ? lookup(host.value, "shard_name", "shard-${host.key}") : null

      replica_priority = var.sharded ? null : lookup(host.value, "replica_priority", var.replica_priority)
      assign_public_ip = var.tls_enabled ? lookup(host.value, "assign_public_ip", var.assign_public_ip) : false
    }
  }

  security_group_ids = var.security_group_ids

  labels = var.labels

  dynamic "access" {
    for_each = var.access != null ? [var.access] : []
    content {
      data_lens = lookup(access.value, "data_lens", null)
      web_sql   = lookup(access.value, "web_sql", null)
    }
  }

  dynamic "disk_size_autoscaling" {
    for_each = var.disk_size_autoscaling != null ? [var.disk_size_autoscaling] : []
    content {
      disk_size_limit           = disk_size_autoscaling.value.disk_size_limit
      planned_usage_threshold   = lookup(disk_size_autoscaling.value, "planned_usage_threshold", null)
      emergency_usage_threshold = lookup(disk_size_autoscaling.value, "emergency_usage_threshold", null)
    }
  }

  maintenance_window {
    type = var.type

    hour = var.type == "ANYTIME" ? null : var.hour
    day  = var.type == "ANYTIME" ? null : var.day
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []
    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}

resource "yandex_mdb_redis_user" "this" {
  cluster_id = yandex_mdb_redis_cluster.this.id
  name       = var.user_name
  passwords  = [var.user_password]
  permissions = {
    commands   = var.user_permissions_commands
    categories = var.user_permissions_categories
    patterns   = var.user_permissions_patterns != "*" ? var.user_permissions_patterns : "~*"
  }
}
