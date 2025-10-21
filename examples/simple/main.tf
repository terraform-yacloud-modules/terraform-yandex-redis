data "yandex_client_config" "client" {}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "redis-vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]

  private_subnets = [["10.10.0.0/24"], ["10.11.0.0/24"], ["10.12.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}

module "redis_simple" {
  source = "../../"

  name        = "cache"
  description = "Cache in-memory without sync to disk"
  folder_id   = data.yandex_client_config.client.folder_id
  network_id  = module.network.vpc_id

  persistence_mode = "OFF"
  password         = "secretpassword"
  # default policy is NOEVICTION
  maxmemory_policy = "ALLKEYS_LRU"

  hosts = {
    host1 = {
      zone      = "ru-central1-a"
      subnet_id = module.network.private_subnets_ids[0]
    }
  }

  type = "WEEKLY"
  hour = "03"
  day  = "MON"

  # Configure timeouts for create, update and delete operations
  timeouts = {
    create = "30m"
    update = "20m"
    delete = "15m"
  }

}
