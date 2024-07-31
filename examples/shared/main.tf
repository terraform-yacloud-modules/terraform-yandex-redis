data "yandex_client_config" "client" {}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]

  private_subnets = [["10.4.0.0/24"], ["10.5.0.0/24"], ["10.6.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}

module "redis_sharded" {
  source = "../.."

  name        = "sharded_cluster"
  description = "Sharded zonal cluster"

  network_id = module.network.vpc_id

  sharded  = true
  password = "secretpassword"
  # default policy is NOEVICTION
  maxmemory_policy = "ALLKEYS_LRU"


  hosts = {
    host1 = {
      zone      = "ru-central1-a"
      subnet_id = module.network.private_subnets_ids[0]
    }
    host2 = {
      zone      = "ru-central1-b"
      subnet_id = module.network.private_subnets_ids[1]
    }
    host3 = {
      zone      = "ru-central1-d"
      subnet_id = module.network.private_subnets_ids[2]
    }
  }

  zone = "ru-central1-a"
}
