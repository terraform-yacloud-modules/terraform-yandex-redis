resource "yandex_mdb_redis_cluster" "this" {
  name                = var.name
  environment         = var.environment
  network_id          = var.network_id
  folder_id           = var.folder_id
  sharded             = var.sharded
  security_group_ids  = var.security_group_ids_list


  config {
    password = var.password == null ? null : var.password
    version  = var.redis_version
    maxmemory_policy = var.maxmemory_policy
  }

  resources {
    resource_preset_id = var.resource_preset_id
    disk_type_id       = var.disk_type_id
    disk_size          = var.disk_size
  }

  dynamic "host" {
    for_each = var.sharded == false ? [for s in var.placement : {
      zone   = s.zone
      subnet = s.subnet
    }] : []
    content {
      zone      = host.value.zone
      subnet_id = host.value.subnet
    }
  }

  dynamic "host" {
    for_each = var.sharded == true ? [for s in var.placement_sharded : {
      zone   = s.zone
      subnet = s.subnet
      shard_name = s.shard_name
    }] : []
    content {
      zone      = host.value.zone
      subnet_id = host.value.subnet
      shard_name = host.value.shard_name
    }
  }

  maintenance_window {
    type = "WEEKLY"
    day  = var.day
    hour = var.hour
  }

}
