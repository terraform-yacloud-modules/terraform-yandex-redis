variable "name" {
  description = "Managed Service for Redis name"
  type        = string
}

variable "environment" {
  type    = string
  default = "PRODUCTION"
}

variable "redis_version" {
  type    = string
  default = 7.2
}

variable "resource_preset_id" {
  description = "Redis resource preset"
  type        = string
  default     = "hm3-c2-m8" # https://cloud.yandex.ru/docs/managed-redis/concepts/instance-types
}

variable "disk_type_id" {
  description = "Redis disk type: network-ssd, local-ssd or network-ssd-nonreplicated"
  default     = "network-ssd"
}

variable "disk_size" {
  description = "Redis disk size GB"
  default     = 35
}

variable "day" {
  description = "Maintenance start day"
  type        = string
  default     = "MON"
}

variable "hour" {
  description = "Maintenance start hour"
  type        = number
  default     = 1
}

variable "subnet_id" {
  type = string
}

variable "network_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "placement" {
  description = "Set zone and network"
  type = list(object({
    zone   = string
    subnet = string
  }))
  default = [
    {
      zone   = "ru-central1-a"
      subnet = null
    },
  ]
}

variable "password_length" {
  type        = number
  default     = 24
  description = "Length of users password"
}

variable "sharded" {
  type        = bool
  default     = false
  description = "Enable sharding"
}

variable "placement_sharded" {
  description = "Set zone and network"
  type = list(object({
    zone   = string
    subnet = string
    shard_name = string
  }))
  default = [
    {
      zone   = "ru-central1-a"
      subnet = null
      shard_name = "shard1"
    },
  ]
}
variable "security_group_ids_list" {
  description = "Security group ids, to which the Redis cluster belongs"
  type        = list(string)
  default     = []
}

variable "maxmemory_policy" {
  description = "Redis maxmemory policy"
  type        = string
  default     = "ALLKEYS_RANDOM"
}

variable "password" {
  description = "Redis password"
  default     = null
}
