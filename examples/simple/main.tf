locals {
  zone      = "ru-central1-a"
  folder_id = "folder_id"

  network_name = "default"
  subnet_name  = "default-ru-central1-a"
}

data "yandex_vpc_network" "private" {
  folder_id = local.folder_id
  name      = local.network_name
}

data "yandex_vpc_subnet" "private" {
  folder_id = local.folder_id
  name      = local.subnet_name
}

module "redis_simple" {
  source = "../../"

  name        = "cache"
  description = "Cache in-memory without sync to disk"
  folder_id   = local.folder_id
  network_id  = data.yandex_vpc_network.private.id

  persistence_mode = "OFF"
  password         = "secretpassword"
  # default policy is NOEVICTION
  maxmemory_policy = "ALLKEYS_LRU"

  hosts = {
    host1 = {
      zone      = local.zone
      subnet_id = data.yandex_vpc_subnet.private.id
    }
  }

  zone = local.zone
}
