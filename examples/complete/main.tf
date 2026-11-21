data "yandex_client_config" "client" {}

provider "yandex" {
}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  folder_id = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)

  blank_name = "redis-complete"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a", "ru-central1-d"]

  private_subnets = [["10.20.0.0/24"], ["10.21.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}

resource "yandex_vpc_security_group" "redis" {
  name       = "redis-complete-sg"
  network_id = module.network.vpc_id

  ingress {
    description    = "Redis client connections"
    protocol       = "TCP"
    port           = 6379
    v4_cidr_blocks = ["10.20.0.0/24", "10.21.0.0/24"]
  }

  egress {
    description    = "Outbound traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

module "redis_complete" {
  source = "../.."

  name        = "complete-cluster"
  zone        = "ru-central1-a"
  description = "Redis cluster with backup retention, disk autoscaling and extended ACL users"
  folder_id   = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)
  network_id  = module.network.vpc_id

  environment         = "PRODUCTION"
  persistence_mode    = "ON"
  deletion_protection = false
  sharded             = false
  tls_enabled         = false
  announce_hostnames  = true

  security_group_ids = [yandex_vpc_security_group.redis.id]

  password = "CompleteExample-Cluster-1"

  labels = {
    environment = "test"
    managed-by  = "terraform"
  }

  redis_version = "9.1-valkey"

  timeout                           = 300
  maxmemory_policy                  = "VOLATILE_LRU"
  slowlog_log_slower_than           = 10000
  slowlog_max_len                   = 1000
  client_output_buffer_limit_normal = "1073741824 536870912 60"
  client_output_buffer_limit_pubsub = "1073741824 536870912 60"

  maxmemory_percent                   = 70
  lua_time_limit                      = 5000
  repl_backlog_size_percent           = 30
  cluster_require_full_coverage       = true
  cluster_allow_reads_when_down       = false
  cluster_allow_pubsubshard_when_down = false
  lfu_decay_time                      = 1
  lfu_log_factor                      = 10
  turn_before_switchover              = false
  allow_data_loss                     = false
  use_luajit                          = true
  io_threads_allowed                  = true
  zset_max_listpack_entries           = 128

  backup_window_start = {
    hours   = 2
    minutes = 30
  }

  backup_retain_period_days = 14

  disk_size_autoscaling = {
    disk_size_limit           = 50
    planned_usage_threshold   = 80
    emergency_usage_threshold = 95
  }

  access = {
    data_lens = true
    web_sql   = true
  }

  resource_preset_id = "b3-c1-m4"
  disk_size          = 20
  disk_type_id       = "network-ssd"

  hosts = {
    host1 = {
      zone             = "ru-central1-a"
      subnet_id        = module.network.private_subnets_ids[0]
      replica_priority = 10
    }
    host2 = {
      zone             = "ru-central1-d"
      subnet_id        = module.network.private_subnets_ids[1]
      replica_priority = 20
    }
  }

  type = "WEEKLY"
  hour = 4
  day  = "SUN"

  timeouts = {
    create = "30m"
    update = "20m"
    delete = "15m"
  }

  users = [
    {
      name                         = "app"
      password                     = "CompleteExample-App-1"
      enabled                      = true
      permissions_commands         = "+get +set +del +xadd +xread"
      permissions_patterns         = "~app:*"
      permissions_databases        = "0,1"
      permissions_pub_sub_channels = "&app:*"
    },
    {
      name                  = "reader"
      password              = "CompleteExample-Reader-1"
      enabled               = true
      permissions_commands  = "+get +mget +exists"
      permissions_patterns  = "~cache:*"
      permissions_databases = "alldbs"
    },
    {
      name                 = "disabled"
      password             = "CompleteExample-Disabled-1"
      enabled              = false
      permissions_commands = "+get"
      permissions_patterns = "~disabled:*"
    },
  ]
}
