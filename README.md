# Yandex Cloud Managed Redis Terraform module

Terraform module which creates Yandex Cloud [Managed Service for Redis](https://yandex.cloud/en/services/managed-redis) resources.

## Usage

See [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-redis/tree/main/examples) directory for working examples to reference:

### Redis cluster without persistence

A simple one host Redis cluster with key eviction and no key sync to disk.

```hcl
module "redis_simple" {
  source  = "terraform-yacloud-modules/redis/yandex"

  name        = "simple_cluster"
  description = "Simple in-memory cluster without sync to disk"

  network_id = data.yandex_vpc_network.private.id

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
```

### Sharded Redis cluster

A simple sharded Redis cluster with key eviction and key sync to disk in one zone.

```hcl
module "redis_sharded" {
  source  = "terraform-yacloud-modules/redis/yandex"

  name        = "sharded_cluster"
  description = "Sharded zonal cluster"

  network_id = data.yandex_vpc_network.private.id

  sharded          = true
  password         = "secretpassword"
  # default policy is NOEVICTION
  maxmemory_policy = "ALLKEYS_LRU"


  hosts = {
    host1 = {
      zone      = local.zone
      subnet_id = data.yandex_vpc_subnet.private.id
    }
    host2 = {
      zone      = local.zone
      subnet_id = data.yandex_vpc_subnet.private.id
    }
    host3 = {
      zone      = local.zone
      subnet_id = data.yandex_vpc_subnet.private.id
    }
  }

  zone = local.zone
}
```


## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-redis/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Redis cluster without persistence](https://github.com/terraform-yacloud-modules/terraform-yandex-redis/tree/main/examples/simple)
- [Sharded Redis cluster](https://github.com/terraform-yacloud-modules/terraform-yandex-redis/tree/main/examples/sharded)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.47.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.47.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_mdb_redis_cluster.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_redis_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access"></a> [access](#input\_access) | Access policy for DataLens and WebSQL | <pre>object({<br/>    data_lens = optional(bool)<br/>    web_sql   = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_allow_data_loss"></a> [allow\_data\_loss](#input\_allow\_data\_loss) | Allows some data to be lost for faster switchover/restart | `bool` | `false` | no |
| <a name="input_announce_hostnames"></a> [announce\_hostnames](#input\_announce\_hostnames) | Enable FQDN instead of IP addresses in CLUSTER SLOTS command | `bool` | `false` | no |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Sets whether the host should get a public IP address or not | `bool` | `false` | no |
| <a name="input_auth_sentinel"></a> [auth\_sentinel](#input\_auth\_sentinel) | Allow ACL based authentication in Redis Sentinel | `bool` | `false` | no |
| <a name="input_backup_window_start"></a> [backup\_window\_start](#input\_backup\_window\_start) | Time to start the daily backup, in the UTC timezone. The structure is documented below | <pre>object({<br/>    hours   = number<br/>    minutes = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_client_output_buffer_limit_normal"></a> [client\_output\_buffer\_limit\_normal](#input\_client\_output\_buffer\_limit\_normal) | Normal clients output buffer limits (bytes) | `string` | `"1073741824 536870912 60"` | no |
| <a name="input_client_output_buffer_limit_pubsub"></a> [client\_output\_buffer\_limit\_pubsub](#input\_client\_output\_buffer\_limit\_pubsub) | Pubsub clients output buffer limits (bytes) | `string` | `"1073741824 536870912 60"` | no |
| <a name="input_cluster_allow_pubsubshard_when_down"></a> [cluster\_allow\_pubsubshard\_when\_down](#input\_cluster\_allow\_pubsubshard\_when\_down) | Permits Pub/Sub shard operations when cluster is down | `bool` | `false` | no |
| <a name="input_cluster_allow_reads_when_down"></a> [cluster\_allow\_reads\_when\_down](#input\_cluster\_allow\_reads\_when\_down) | Allows read operations when cluster is down | `bool` | `false` | no |
| <a name="input_cluster_require_full_coverage"></a> [cluster\_require\_full\_coverage](#input\_cluster\_require\_full\_coverage) | Controls whether all hash slots must be covered by nodes | `bool` | `true` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | Number of databases (changing requires redis-server restart) | `number` | `16` | no |
| <a name="input_day"></a> [day](#input\_day) | Day of week for maintenance window if window type is weekly | `string` | `"MON"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Inhibits deletion of the cluster | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the Redis cluster | `string` | `"Redis cluster"` | no |
| <a name="input_disk_encryption_key_id"></a> [disk\_encryption\_key\_id](#input\_disk\_encryption\_key\_id) | ID of the KMS key used for disk encryption | `string` | `null` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Volume of the storage available to a host, in gigabytes | `number` | `20` | no |
| <a name="input_disk_size_autoscaling"></a> [disk\_size\_autoscaling](#input\_disk\_size\_autoscaling) | Disk size autoscaling configuration | <pre>object({<br/>    disk_size_limit           = number<br/>    planned_usage_threshold   = optional(number)<br/>    emergency_usage_threshold = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_disk_type_id"></a> [disk\_type\_id](#input\_disk\_type\_id) | Type of the storage of Redis hosts - environment default is used if missing | `string` | `"network-ssd"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment of the Redis cluster. Can be either PRESTABLE or PRODUCTION | `string` | `"PRODUCTION"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The ID of the folder that the resource belongs to. If it is not provided, the default provider folder is used | `string` | `null` | no |
| <a name="input_hosts"></a> [hosts](#input\_hosts) | Redis hosts definition | `map(any)` | n/a | yes |
| <a name="input_hour"></a> [hour](#input\_hour) | Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly | `number` | `24` | no |
| <a name="input_io_threads_allowed"></a> [io\_threads\_allowed](#input\_io\_threads\_allowed) | Enable IO threads for Redis (improves performance for concurrent connections) | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the Redis cluster | `map(string)` | `{}` | no |
| <a name="input_lfu_decay_time"></a> [lfu\_decay\_time](#input\_lfu\_decay\_time) | LFU (Least Frequently Used) decay time in minutes - controls how quickly access frequency counters are reduced | `number` | `1` | no |
| <a name="input_lfu_log_factor"></a> [lfu\_log\_factor](#input\_lfu\_log\_factor) | LFU logarithmic counter increment factor - higher values mean less frequent counter increments, affecting eviction sensitivity (range: 0-255) | `number` | `10` | no |
| <a name="input_lua_time_limit"></a> [lua\_time\_limit](#input\_lua\_time\_limit) | Maximum time in milliseconds for Lua scripts | `number` | `5000` | no |
| <a name="input_maxmemory_percent"></a> [maxmemory\_percent](#input\_maxmemory\_percent) | Redis maxmemory usage in percent | `number` | `75` | no |
| <a name="input_maxmemory_policy"></a> [maxmemory\_policy](#input\_maxmemory\_policy) | Redis key eviction policy for a dataset that reaches maximum memory. See https://docs.redis.com/latest/rs/databases/memory-performance/eviction-policy/ | `string` | `"NOEVICTION"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Redis cluster | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | ID of the network, to which the Redis cluster belongs | `string` | n/a | yes |
| <a name="input_notify_keyspace_events"></a> [notify\_keyspace\_events](#input\_notify\_keyspace\_events) | Select the events that Redis will notify among a set of classes | `string` | `""` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the Redis cluster | `string` | n/a | yes |
| <a name="input_persistence_mode"></a> [persistence\_mode](#input\_persistence\_mode) | Persistence mode. Must be one of OFF or ON | `string` | `"ON"` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | Version of Redis | `string` | `"7.2-valkey"` | no |
| <a name="input_repl_backlog_size_percent"></a> [repl\_backlog\_size\_percent](#input\_repl\_backlog\_size\_percent) | Replication backlog size as a percentage of flavor maxmemory | `number` | `25` | no |
| <a name="input_replica_priority"></a> [replica\_priority](#input\_replica\_priority) | Replica priority of a current replica (usable for non-sharded only) | `any` | `null` | no |
| <a name="input_resource_preset_id"></a> [resource\_preset\_id](#input\_resource\_preset\_id) | The ID of the preset for computational resources available to a host (CPU, memory etc.). See https://cloud.yandex.com/en/docs/managed-redis/concepts/instance-types | `string` | `"b3-c1-m4"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A set of ids of security groups assigned to hosts of the cluster | `list(string)` | `[]` | no |
| <a name="input_sharded"></a> [sharded](#input\_sharded) | Redis Cluster mode enabled/disabled | `bool` | `false` | no |
| <a name="input_slowlog_log_slower_than"></a> [slowlog\_log\_slower\_than](#input\_slowlog\_log\_slower\_than) | Log slow queries below this number in microseconds | `number` | `10000` | no |
| <a name="input_slowlog_max_len"></a> [slowlog\_max\_len](#input\_slowlog\_max\_len) | Slow queries log length | `number` | `1000` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Close the connection after a client is idle for N seconds | `number` | `0` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeout configuration for create, update, and delete operations | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_tls_enabled"></a> [tls\_enabled](#input\_tls\_enabled) | TLS support mode enabled/disabled | `bool` | `false` | no |
| <a name="input_turn_before_switchover"></a> [turn\_before\_switchover](#input\_turn\_before\_switchover) | Allows to turn before switchover in RDSync | `bool` | `false` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of maintenance window. Can be either ANYTIME or WEEKLY. A day and hour of window need to be specified with weekly window | `string` | `"ANYTIME"` | no |
| <a name="input_use_luajit"></a> [use\_luajit](#input\_use\_luajit) | Enable LuaJIT engine | `bool` | `false` | no |
| <a name="input_zset_max_listpack_entries"></a> [zset\_max\_listpack\_entries](#input\_zset\_max\_listpack\_entries) | Controls max number of entries in zset before conversion | `number` | `128` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config"></a> [config](#output\_config) | Configuration of the Redis cluster |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Creation timestamp of the cluster |
| <a name="output_deletion_protection"></a> [deletion\_protection](#output\_deletion\_protection) | Inhibits deletion of the cluster |
| <a name="output_description"></a> [description](#output\_description) | Description of the Redis cluster |
| <a name="output_environment"></a> [environment](#output\_environment) | Deployment environment of the Redis cluster |
| <a name="output_folder_id"></a> [folder\_id](#output\_folder\_id) | ID of the folder that the resource belongs to |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | FQDN for the Redis cluster |
| <a name="output_health"></a> [health](#output\_health) | Aggregated health of the cluster |
| <a name="output_hosts"></a> [hosts](#output\_hosts) | A list of hosts in the Redis cluster |
| <a name="output_id"></a> [id](#output\_id) | ID of the Redis cluster |
| <a name="output_labels"></a> [labels](#output\_labels) | A set of key/value label pairs to assign to the Redis cluster |
| <a name="output_maintenance_window"></a> [maintenance\_window](#output\_maintenance\_window) | Maintenance policy of the Redis cluster |
| <a name="output_name"></a> [name](#output\_name) | Name of the Redis cluster |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | ID of the network to which the Redis cluster belongs |
| <a name="output_persistence_mode"></a> [persistence\_mode](#output\_persistence\_mode) | Persistence mode of the Redis cluster |
| <a name="output_resources"></a> [resources](#output\_resources) | Resources allocated to hosts of the Redis cluster |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | A set of ids of security groups assigned to hosts of the cluster |
| <a name="output_sharded"></a> [sharded](#output\_sharded) | Redis Cluster mode enabled/disabled |
| <a name="output_tls_enabled"></a> [tls\_enabled](#output\_tls\_enabled) | TLS support mode enabled/disabled |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.47.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.164.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_mdb_redis_cluster.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_redis_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access"></a> [access](#input\_access) | Access policy for DataLens and WebSQL | <pre>object({<br/>    data_lens = optional(bool)<br/>    web_sql   = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_announce_hostnames"></a> [announce\_hostnames](#input\_announce\_hostnames) | Enable FQDN instead of IP addresses in CLUSTER SLOTS command | `bool` | `false` | no |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Sets whether the host should get a public IP address or not | `bool` | `false` | no |
| <a name="input_auth_sentinel"></a> [auth\_sentinel](#input\_auth\_sentinel) | Allow ACL based authentication in Redis Sentinel | `bool` | `false` | no |
| <a name="input_backup_window_start"></a> [backup\_window\_start](#input\_backup\_window\_start) | Time to start the daily backup, in the UTC timezone. The structure is documented below | <pre>object({<br/>    hours   = number<br/>    minutes = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_client_output_buffer_limit_normal"></a> [client\_output\_buffer\_limit\_normal](#input\_client\_output\_buffer\_limit\_normal) | Normal clients output buffer limits (bytes) | `string` | `"1073741824 536870912 60"` | no |
| <a name="input_client_output_buffer_limit_pubsub"></a> [client\_output\_buffer\_limit\_pubsub](#input\_client\_output\_buffer\_limit\_pubsub) | Pubsub clients output buffer limits (bytes) | `string` | `"1073741824 536870912 60"` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | Number of databases (changing requires redis-server restart) | `number` | `16` | no |
| <a name="input_day"></a> [day](#input\_day) | Day of week for maintenance window if window type is weekly | `string` | `"MON"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Inhibits deletion of the cluster | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the Redis cluster | `string` | `"Redis cluster"` | no |
| <a name="input_disk_encryption_key_id"></a> [disk\_encryption\_key\_id](#input\_disk\_encryption\_key\_id) | ID of the KMS key used for disk encryption | `string` | `null` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Volume of the storage available to a host, in gigabytes | `number` | `20` | no |
| <a name="input_disk_size_autoscaling"></a> [disk\_size\_autoscaling](#input\_disk\_size\_autoscaling) | Disk size autoscaling configuration | <pre>object({<br/>    disk_size_limit           = number<br/>    planned_usage_threshold   = optional(number)<br/>    emergency_usage_threshold = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_disk_type_id"></a> [disk\_type\_id](#input\_disk\_type\_id) | Type of the storage of Redis hosts - environment default is used if missing | `string` | `"network-ssd"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment of the Redis cluster. Can be either PRESTABLE or PRODUCTION | `string` | `"PRODUCTION"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The ID of the folder that the resource belongs to. If it is not provided, the default provider folder is used | `string` | `null` | no |
| <a name="input_hosts"></a> [hosts](#input\_hosts) | Redis hosts definition | `map(any)` | n/a | yes |
| <a name="input_hour"></a> [hour](#input\_hour) | Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly | `number` | `24` | no |
| <a name="input_io_threads_allowed"></a> [io\_threads\_allowed](#input\_io\_threads\_allowed) | Enable IO threads for Redis (improves performance for concurrent connections) | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the Redis cluster | `map(string)` | `{}` | no |
| <a name="input_maxmemory_policy"></a> [maxmemory\_policy](#input\_maxmemory\_policy) | Redis key eviction policy for a dataset that reaches maximum memory. See https://docs.redis.com/latest/rs/databases/memory-performance/eviction-policy/ | `string` | `"NOEVICTION"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Redis cluster | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | ID of the network, to which the Redis cluster belongs | `string` | n/a | yes |
| <a name="input_notify_keyspace_events"></a> [notify\_keyspace\_events](#input\_notify\_keyspace\_events) | Select the events that Redis will notify among a set of classes | `string` | `""` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the Redis cluster | `string` | n/a | yes |
| <a name="input_persistence_mode"></a> [persistence\_mode](#input\_persistence\_mode) | Persistence mode. Must be one of OFF or ON | `string` | `"ON"` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | Version of Redis | `string` | `"7.2"` | no |
| <a name="input_replica_priority"></a> [replica\_priority](#input\_replica\_priority) | Replica priority of a current replica (usable for non-sharded only) | `any` | `null` | no |
| <a name="input_resource_preset_id"></a> [resource\_preset\_id](#input\_resource\_preset\_id) | The ID of the preset for computational resources available to a host (CPU, memory etc.). See https://cloud.yandex.com/en/docs/managed-redis/concepts/instance-types | `string` | `"b3-c1-m4"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A set of ids of security groups assigned to hosts of the cluster | `list(string)` | `[]` | no |
| <a name="input_sharded"></a> [sharded](#input\_sharded) | Redis Cluster mode enabled/disabled | `bool` | `false` | no |
| <a name="input_slowlog_log_slower_than"></a> [slowlog\_log\_slower\_than](#input\_slowlog\_log\_slower\_than) | Log slow queries below this number in microseconds | `number` | `10000` | no |
| <a name="input_slowlog_max_len"></a> [slowlog\_max\_len](#input\_slowlog\_max\_len) | Slow queries log length | `number` | `1000` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Close the connection after a client is idle for N seconds | `number` | `0` | no |
| <a name="input_tls_enabled"></a> [tls\_enabled](#input\_tls\_enabled) | TLS support mode enabled/disabled | `bool` | `false` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of maintenance window. Can be either ANYTIME or WEEKLY. A day and hour of window need to be specified with weekly window | `string` | `"ANYTIME"` | no |
| <a name="input_use_luajit"></a> [use\_luajit](#input\_use\_luajit) | Enable LuaJIT engine | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config"></a> [config](#output\_config) | Configuration of the Redis cluster |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Creation timestamp of the cluster |
| <a name="output_deletion_protection"></a> [deletion\_protection](#output\_deletion\_protection) | Inhibits deletion of the cluster |
| <a name="output_description"></a> [description](#output\_description) | Description of the Redis cluster |
| <a name="output_environment"></a> [environment](#output\_environment) | Deployment environment of the Redis cluster |
| <a name="output_folder_id"></a> [folder\_id](#output\_folder\_id) | ID of the folder that the resource belongs to |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | FQDN for the Redis cluster |
| <a name="output_health"></a> [health](#output\_health) | Aggregated health of the cluster |
| <a name="output_hosts"></a> [hosts](#output\_hosts) | A list of hosts in the Redis cluster |
| <a name="output_id"></a> [id](#output\_id) | ID of the Redis cluster |
| <a name="output_labels"></a> [labels](#output\_labels) | A set of key/value label pairs to assign to the Redis cluster |
| <a name="output_maintenance_window"></a> [maintenance\_window](#output\_maintenance\_window) | Maintenance policy of the Redis cluster |
| <a name="output_name"></a> [name](#output\_name) | Name of the Redis cluster |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | ID of the network to which the Redis cluster belongs |
| <a name="output_persistence_mode"></a> [persistence\_mode](#output\_persistence\_mode) | Persistence mode of the Redis cluster |
| <a name="output_resources"></a> [resources](#output\_resources) | Resources allocated to hosts of the Redis cluster |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | A set of ids of security groups assigned to hosts of the cluster |
| <a name="output_sharded"></a> [sharded](#output\_sharded) | Redis Cluster mode enabled/disabled |
| <a name="output_tls_enabled"></a> [tls\_enabled](#output\_tls\_enabled) | TLS support mode enabled/disabled |
<!-- END_TF_DOCS -->
