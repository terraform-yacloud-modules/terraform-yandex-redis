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

  # Basic cluster settings
  name        = "cache"
  description = "Cache in-memory without sync to disk"
  folder_id   = data.yandex_client_config.client.folder_id
  network_id  = module.network.vpc_id
  environment = "PRODUCTION" # PRODUCTION or PRESTABLE

  labels = {
    environment = "dev"
    project     = "example"
    managed_by  = "terraform"
  }

  # Redis cluster mode
  sharded     = false # Simple non-sharded Redis
  tls_enabled = false

  # Security
  security_group_ids  = [] # Add security group IDs if needed
  deletion_protection = false

  # Redis configuration
  password           = "secretpassword"
  redis_version      = "7.2"
  persistence_mode   = "OFF"         # OFF for in-memory cache
  maxmemory_policy   = "ALLKEYS_LRU" # Eviction policy for cache
  databases          = 16            # Number of databases
  timeout            = 300           # Client idle timeout in seconds
  use_luajit         = true          # Enable LuaJIT engine
  io_threads_allowed = false         # Enable IO threads for better concurrency

  # Logging and monitoring
  notify_keyspace_events  = ""    # Redis keyspace notifications
  slowlog_log_slower_than = 10000 # Log queries slower than 10ms
  slowlog_max_len         = 1000  # Maximum slow log entries

  # Client output buffer limits
  client_output_buffer_limit_normal = "1073741824 536870912 60"
  client_output_buffer_limit_pubsub = "1073741824 536870912 60"

  # Resources
  resource_preset_id = "b3-c1-m4" # 1 vCPU, 4GB RAM
  disk_size          = 20         # GB
  disk_type_id       = "network-ssd"

  # Disk autoscaling (optional)
  # disk_size_autoscaling = {
  #   disk_size_limit           = 50
  #   planned_usage_threshold   = 80
  #   emergency_usage_threshold = 95
  # }

  # Disk encryption (optional)
  # disk_encryption_key_id = "your-kms-key-id"

  # Backup configuration (optional)
  # backup_window_start = {
  #   hours   = 3
  #   minutes = 0
  # }

  # Hosts configuration
  replica_priority = null # Not used in simple mode, but can be set per host
  assign_public_ip = false

  hosts = {
    host1 = {
      zone      = "ru-central1-a"
      subnet_id = module.network.private_subnets_ids[0]
    }
    # Add more hosts for replication
    # host2 = {
    #   zone      = "ru-central1-b"
    #   subnet_id = module.network.private_subnets_ids[1]
    # }
  }

  # Maintenance window
  type = "WEEKLY"
  day  = "MON"
  hour = 3

  # Access policy (optional)
  # access = {
  #   data_lens = false
  #   web_sql   = false
  # }

  # Sentinel and cluster configuration
  announce_hostnames = false
  auth_sentinel      = false
}
