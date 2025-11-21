variable "name" {
  description = "Name of the Redis cluster"
  type        = string
}

variable "network_id" {
  description = "ID of the network, to which the Redis cluster belongs"
  type        = string
}

variable "environment" {
  description = "Deployment environment of the Redis cluster. Can be either PRESTABLE or PRODUCTION"
  type        = string
  default     = "PRODUCTION"

  validation {
    condition     = contains(["PRODUCTION", "PRESTABLE"], var.environment)
    error_message = "Environment should be one of `PRODUCTION` or `PRESTABLE`."
  }
}

variable "description" {
  description = "Description of the Redis cluster"
  type        = string
  default     = "Redis cluster"
}

variable "folder_id" {
  description = "The ID of the folder that the resource belongs to. If it is not provided, the default provider folder is used"
  type        = string
  default     = null
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the Redis cluster"
  type        = map(string)
  default     = {}
}

variable "sharded" {
  description = "Redis Cluster mode enabled/disabled"
  type        = bool
  default     = false
}

variable "tls_enabled" {
  description = "TLS support mode enabled/disabled"
  type        = bool
  default     = false
}

variable "persistence_mode" {
  description = "Persistence mode. Must be one of OFF or ON"
  type        = string
  default     = "ON"

  validation {
    condition     = contains(["ON", "OFF"], var.persistence_mode)
    error_message = "Persistence_mode should be one of `ON` or `OFF`."
  }
}

variable "security_group_ids" {
  description = "A set of ids of security groups assigned to hosts of the cluster"
  type        = list(string)
  default     = []
}

variable "deletion_protection" {
  description = "Inhibits deletion of the cluster"
  type        = bool
  default     = false
}

variable "password" {
  description = "Password for the Redis cluster"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.password) >= 8
    error_message = "Password must be at least 8 characters long."
  }
}

variable "timeout" {
  description = "Close the connection after a client is idle for N seconds"
  type        = number
  default     = 0

  validation {
    condition     = var.timeout >= 0
    error_message = "Timeout must be a non-negative number."
  }
}

variable "maxmemory_policy" {
  description = "Redis key eviction policy for a dataset that reaches maximum memory. See https://docs.redis.com/latest/rs/databases/memory-performance/eviction-policy/"
  type        = string
  default     = "NOEVICTION"

  validation {
    condition = contains([
      "VOLATILE_LRU",
      "ALLKEYS_LRU",
      "VOLATILE_LFU",
      "VOLATILE_RANDOM",
      "NOEVICTION",
      "MAXMEMORY_POLICY_UNSPECIFIED",
      "ALLKEYS_LFU",
      "ALLKEYS_RANDOM",
      "VOLATILE_TTL"
    ], var.maxmemory_policy)
    error_message = "Maxmemory_policy should be one of `VOLATILE_LRU`, `ALLKEYS_LRU`, `VOLATILE_LFU`, `VOLATILE_RANDOM`, `NOEVICTION`, `MAXMEMORY_POLICY_UNSPECIFIED`, `ALLKEYS_LFU`, `ALLKEYS_RANDOM`, `VOLATILE_TTL`."
  }
}

variable "notify_keyspace_events" {
  description = "Select the events that Redis will notify among a set of classes"
  type        = string
  default     = ""
}

variable "slowlog_log_slower_than" {
  description = "Log slow queries below this number in microseconds"
  type        = number
  default     = 10000
}

variable "slowlog_max_len" {
  description = "Slow queries log length"
  type        = number
  default     = 1000
}

variable "databases" {
  description = "Number of databases (changing requires redis-server restart)"
  type        = number
  default     = 16

  validation {
    condition     = var.databases > 0
    error_message = "Number of databases must be greater than 0."
  }
}

variable "redis_version" {
  description = "Version of Redis"
  type        = string
  default     = "7.2-valkey"
}

variable "client_output_buffer_limit_normal" {
  description = "Normal clients output buffer limits (bytes)"
  type        = string
  default     = "1073741824 536870912 60"
}

variable "client_output_buffer_limit_pubsub" {
  description = "Pubsub clients output buffer limits (bytes)"
  type        = string
  default     = "1073741824 536870912 60"
}

variable "resource_preset_id" {
  description = "The ID of the preset for computational resources available to a host (CPU, memory etc.). See https://cloud.yandex.com/en/docs/managed-redis/concepts/instance-types"
  type        = string
  default     = "b3-c1-m4"
}

variable "disk_size" {
  description = "Volume of the storage available to a host, in gigabytes"
  type        = number
  default     = 20
}

variable "disk_type_id" {
  description = "Type of the storage of Redis hosts - environment default is used if missing"
  type        = string
  default     = "network-ssd"

  validation {
    condition     = contains(["network-ssd", "local-ssd", "network-ssd-nonreplicated", "network-ssd-io-m3"], var.disk_type_id)
    error_message = "Disk_type_id must be one of `network-ssd`, `local-ssd`, `network-ssd-nonreplicated` or `network-ssd-io-m3`."
  }
}

variable "replica_priority" {
  description = "Replica priority of a current replica (usable for non-sharded only)"
  type        = any
  default     = null
}

variable "assign_public_ip" {
  description = "Sets whether the host should get a public IP address or not"
  type        = bool
  default     = false
}

variable "type" {
  description = "Type of maintenance window. Can be either ANYTIME or WEEKLY. A day and hour of window need to be specified with weekly window"
  type        = string
  default     = "ANYTIME"

  validation {
    condition     = contains(["ANYTIME", "WEEKLY"], var.type)
    error_message = "Type must be one of `ANYTIME`, `WEEKLY`."
  }
}

variable "hour" {
  description = "Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly"
  type        = number
  default     = 24

  validation {
    condition     = var.hour >= 1 && var.hour <= 24
    error_message = "Hour must be between 1 and 24 inclusive."
  }
}

variable "day" {
  description = "Day of week for maintenance window if window type is weekly"
  type        = string
  default     = "MON"

  validation {
    condition     = contains(["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"], var.day)
    error_message = "Day must be one of `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`."
  }
}

variable "hosts" {
  description = "Redis hosts definition"
  type        = map(any)

  validation {
    condition     = length(keys(var.hosts)) > 0
    error_message = "At least one host should be defined"
  }
}

variable "use_luajit" {
  description = "Enable LuaJIT engine"
  type        = bool
  default     = false
}

variable "io_threads_allowed" {
  description = "Enable IO threads for Redis (improves performance for concurrent connections)"
  type        = bool
  default     = false
}

variable "maxmemory_percent" {
  description = "Redis maxmemory usage in percent"
  type        = number
  default     = 75

  validation {
    condition     = var.maxmemory_percent >= 0 && var.maxmemory_percent <= 100
    error_message = "Maxmemory percent must be between 0 and 100 inclusive."
  }
}

variable "lua_time_limit" {
  description = "Maximum time in milliseconds for Lua scripts"
  type        = number
  default     = 5000
}

variable "repl_backlog_size_percent" {
  description = "Replication backlog size as a percentage of flavor maxmemory"
  type        = number
  default     = 25

  validation {
    condition     = var.repl_backlog_size_percent >= 0 && var.repl_backlog_size_percent <= 100
    error_message = "Replication backlog size percent must be between 0 and 100 inclusive."
  }
}

variable "cluster_require_full_coverage" {
  description = "Controls whether all hash slots must be covered by nodes"
  type        = bool
  default     = true
}

variable "cluster_allow_reads_when_down" {
  description = "Allows read operations when cluster is down"
  type        = bool
  default     = false
}

variable "cluster_allow_pubsubshard_when_down" {
  description = "Permits Pub/Sub shard operations when cluster is down"
  type        = bool
  default     = false
}

variable "lfu_decay_time" {
  description = "LFU (Least Frequently Used) decay time in minutes - controls how quickly access frequency counters are reduced"
  type        = number
  default     = 1
}

variable "lfu_log_factor" {
  description = "LFU logarithmic counter increment factor - higher values mean less frequent counter increments, affecting eviction sensitivity (range: 0-255)"
  type        = number
  default     = 10

  validation {
    condition     = var.lfu_log_factor >= 0 && var.lfu_log_factor <= 255
    error_message = "LFU log factor must be between 0 and 255 inclusive."
  }
}

variable "turn_before_switchover" {
  description = "Allows to turn before switchover in RDSync"
  type        = bool
  default     = false
}

variable "allow_data_loss" {
  description = "Allows some data to be lost for faster switchover/restart"
  type        = bool
  default     = false
}

variable "zset_max_listpack_entries" {
  description = "Controls max number of entries in zset before conversion"
  type        = number
  default     = 128
}

variable "timeouts" {
  description = "Timeout configuration for create, update, and delete operations"
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "backup_window_start" {
  description = "Time to start the daily backup, in the UTC timezone. The structure is documented below"
  type = object({
    hours   = number
    minutes = optional(number)
  })
  default = null

  validation {
    condition = var.backup_window_start == null ? true : (
      var.backup_window_start.hours >= 0 && var.backup_window_start.hours <= 23 &&
      (var.backup_window_start.minutes == null || (
        var.backup_window_start.minutes >= 0 && var.backup_window_start.minutes <= 59
      ))
    )
    error_message = "Backup window start hours must be between 0-23 and minutes must be between 0-59 if specified."
  }
}

variable "announce_hostnames" {
  description = "Enable FQDN instead of IP addresses in CLUSTER SLOTS command"
  type        = bool
  default     = false
}

variable "auth_sentinel" {
  description = "Allow ACL based authentication in Redis Sentinel"
  type        = bool
  default     = false
}

variable "disk_encryption_key_id" {
  description = "ID of the KMS key used for disk encryption"
  type        = string
  default     = null
}

variable "disk_size_autoscaling" {
  description = "Disk size autoscaling configuration"
  type = object({
    disk_size_limit           = number
    planned_usage_threshold   = optional(number)
    emergency_usage_threshold = optional(number)
  })
  default = null
}

variable "access" {
  description = "Access policy for DataLens and WebSQL"
  type = object({
    data_lens = optional(bool)
    web_sql   = optional(bool)
  })
  default = null
}

variable "user_name" {
  description = "Name of the Redis user"
  type        = string
  default     = null
}

variable "user_password" {
  description = "Password for the Redis user"
  type        = string
  sensitive   = true
  default     = null
}

variable "user_permissions_commands" {
  description = "Redis commands allowed for the user (e.g. '+get +set')"
  type        = string
  default     = "+get +set"
}

variable "user_permissions_categories" {
  description = "Redis command categories allowed for the user. Leave empty unless needed"
  type        = string
  default     = ""
}

variable "user_permissions_patterns" {
  description = "Key patterns allowed for the user. Must start with ~, %R~, %W~ or %RW~ (e.g. '~*' for all keys)"
  type        = string
  default     = "~*"
}
