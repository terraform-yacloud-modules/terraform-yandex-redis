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

  # Basic cluster settings
  name        = "sharded_cluster"
  description = "Sharded Redis Cluster for distributed data"
  folder_id   = data.yandex_client_config.client.folder_id
  network_id  = module.network.vpc_id
  environment = "PRODUCTION" # PRODUCTION or PRESTABLE

  labels = {
    environment  = "production"
    project      = "sharded-example"
    managed_by   = "terraform"
    cluster_type = "sharded"
  }

  # Redis cluster mode - SHARDED
  sharded     = true  # Enable sharding for distributed data
  tls_enabled = false # Set to true for TLS encryption

  # Security
  security_group_ids  = [] # Add security group IDs if needed
  deletion_protection = false

  # Redis configuration
  password           = "secretpassword"
  redis_version      = "7.2"
  persistence_mode   = "ON"          # ON for data persistence
  maxmemory_policy   = "ALLKEYS_LRU" # Eviction policy
  databases          = 16            # Number of databases
  timeout            = 0             # Client idle timeout (0 = disabled)
  use_luajit         = true          # Enable LuaJIT engine
  io_threads_allowed = true          # Enable IO threads for better performance

  # Logging and monitoring
  notify_keyspace_events  = "KEA" # Enable all keyspace notifications
  slowlog_log_slower_than = 10000 # Log queries slower than 10ms
  slowlog_max_len         = 1000  # Maximum slow log entries

  # Client output buffer limits
  client_output_buffer_limit_normal = "1073741824 536870912 60"
  client_output_buffer_limit_pubsub = "1073741824 536870912 60"

  # Resources
  resource_preset_id = "b3-c1-m4" # 1 vCPU, 4GB RAM
  disk_size          = 32         # GB
  disk_type_id       = "network-ssd"

  # Disk autoscaling
  disk_size_autoscaling = {
    disk_size_limit           = 100
    planned_usage_threshold   = 80
    emergency_usage_threshold = 95
  }

  # Disk encryption (optional)
  # disk_encryption_key_id = "your-kms-key-id"

  # Backup configuration
  backup_window_start = {
    hours   = 2
    minutes = 30
  }

  # Hosts configuration
  replica_priority = null  # Not used in sharded mode
  assign_public_ip = false # Set to true if you need public access (requires TLS)

  hosts = {
    # Shard 1
    host1 = {
      zone       = "ru-central1-a"
      subnet_id  = module.network.private_subnets_ids[0]
      shard_name = "shard-1" # Optional: explicit shard name
    }
    # Shard 2
    host2 = {
      zone       = "ru-central1-b"
      subnet_id  = module.network.private_subnets_ids[1]
      shard_name = "shard-2" # Optional: explicit shard name
    }
    # Shard 3
    host3 = {
      zone       = "ru-central1-d"
      subnet_id  = module.network.private_subnets_ids[2]
      shard_name = "shard-3" # Optional: explicit shard name
    }
    # Add more hosts for additional shards or replicas
    # host4 = {
    #   zone       = "ru-central1-a"
    #   subnet_id  = module.network.private_subnets_ids[0]
    #   shard_name = "shard-1" # Replica for shard-1
    # }
  }

  # Maintenance window
  type = "WEEKLY"
  day  = "SUN"
  hour = 4

  # Access policy
  access = {
    data_lens = false # Enable DataLens access
    web_sql   = false # Enable WebSQL access
  }

  # Sentinel and cluster configuration
  announce_hostnames = true  # Use FQDNs in CLUSTER SLOTS
  auth_sentinel      = false # ACL authentication for Sentinel
}
