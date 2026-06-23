resource "yandex_mdb_redis_cluster_v2" "this" {
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

  config = {
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

    backup_window_start = var.backup_window_start == null ? null : {
      hours   = var.backup_window_start.hours
      minutes = coalesce(var.backup_window_start.minutes, 0)
    }
  }

  resources = {
    resource_preset_id = var.resource_preset_id
    disk_size          = var.disk_size
    disk_type_id       = var.disk_type_id
  }

  hosts = {
    for host_key, host in var.hosts : host_key => {
      zone      = lookup(host, "zone", try(var.zone, null))
      subnet_id = host.subnet_id

      shard_name = var.sharded ? lookup(host, "shard_name", "shard-${host_key}") : null

      replica_priority = var.sharded ? null : lookup(host, "replica_priority", var.replica_priority)
      assign_public_ip = var.tls_enabled ? lookup(host, "assign_public_ip", var.assign_public_ip) : false
    }
  }

  security_group_ids = var.security_group_ids

  labels = var.labels

  access = var.access

  disk_size_autoscaling = var.disk_size_autoscaling

  maintenance_window = {
    type = var.type

    hour = var.type == "ANYTIME" ? null : var.hour
    day  = var.type == "ANYTIME" ? null : var.day
  }

  modules = var.modules

  timeouts = var.timeouts
}

moved {
  from = yandex_mdb_redis_user.this
  to   = yandex_mdb_redis_user.this[0]
}

resource "random_password" "user" {
  count = var.user_name != null ? 1 : 0

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

locals {
  user_password = var.user_password != null ? var.user_password : one(random_password.user[*].result)
}

resource "yandex_mdb_redis_user" "this" {
  count = var.user_name != null ? 1 : 0

  cluster_id = yandex_mdb_redis_cluster_v2.this.cluster_id
  name       = var.user_name
  passwords  = [local.user_password]
  permissions = {
    commands   = var.user_permissions_commands
    categories = var.user_permissions_categories
    patterns   = var.user_permissions_patterns != "*" ? var.user_permissions_patterns : "~*"
  }
}
