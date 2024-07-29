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


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Sets whether the host should get a public IP address or not | `bool` | `false` | no |
| <a name="input_client_output_buffer_limit_normal"></a> [client\_output\_buffer\_limit\_normal](#input\_client\_output\_buffer\_limit\_normal) | Normal clients output buffer limits (bytes) | `string` | `"1073741824 536870912 60"` | no |
| <a name="input_client_output_buffer_limit_pubsub"></a> [client\_output\_buffer\_limit\_pubsub](#input\_client\_output\_buffer\_limit\_pubsub) | Pubsub clients output buffer limits (bytes) | `string` | `"1073741824 536870912 60"` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | Number of databases (changing requires redis-server restart) | `number` | `16` | no |
| <a name="input_day"></a> [day](#input\_day) | Day of week for maintenance window if window type is weekly | `string` | `"MON"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Inhibits deletion of the cluster | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the Redis cluster | `string` | `"Redis cluster"` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Volume of the storage available to a host, in gigabytes | `number` | `20` | no |
| <a name="input_disk_type_id"></a> [disk\_type\_id](#input\_disk\_type\_id) | Type of the storage of Redis hosts - environment default is used if missing | `string` | `"network-ssd"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment of the Redis cluster. Can be either PRESTABLE or PRODUCTION | `string` | `"PRODUCTION"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The ID of the folder that the resource belongs to. If it is not provided, the default provider folder is used | `string` | `null` | no |
| <a name="input_hosts"></a> [hosts](#input\_hosts) | Redis hosts definition | `map(any)` | n/a | yes |
| <a name="input_hour"></a> [hour](#input\_hour) | Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly | `number` | `24` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the Redis cluster | `map(string)` | `{}` | no |
| <a name="input_maxmemory_policy"></a> [maxmemory\_policy](#input\_maxmemory\_policy) | Redis key eviction policy for a dataset that reaches maximum memory. See https://docs.redis.com/latest/rs/databases/memory-performance/eviction-policy/ | `string` | `"NOEVICTION"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Redis cluster | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | ID of the network, to which the Redis cluster belongs | `string` | n/a | yes |
| <a name="input_notify_keyspace_events"></a> [notify\_keyspace\_events](#input\_notify\_keyspace\_events) | Select the events that Redis will notify among a set of classes | `string` | `""` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the Redis cluster | `string` | n/a | yes |
| <a name="input_persistence_mode"></a> [persistence\_mode](#input\_persistence\_mode) | Persistence mode. Must be one of OFF or ON | `string` | `"ON"` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | Version of Redis | `string` | `"6.2"` | no |
| <a name="input_replica_priority"></a> [replica\_priority](#input\_replica\_priority) | Replica priority of a current replica (usable for non-sharded only) | `any` | `null` | no |
| <a name="input_resource_preset_id"></a> [resource\_preset\_id](#input\_resource\_preset\_id) | The ID of the preset for computational resources available to a host (CPU, memory etc.). See https://cloud.yandex.com/en/docs/managed-redis/concepts/instance-types | `string` | `"b3-c1-m4"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A set of ids of security groups assigned to hosts of the cluster | `list(string)` | `[]` | no |
| <a name="input_sharded"></a> [sharded](#input\_sharded) | Redis Cluster mode enabled/disabled | `bool` | `false` | no |
| <a name="input_slowlog_log_slower_than"></a> [slowlog\_log\_slower\_than](#input\_slowlog\_log\_slower\_than) | Log slow queries below this number in microseconds | `number` | `10000` | no |
| <a name="input_slowlog_max_len"></a> [slowlog\_max\_len](#input\_slowlog\_max\_len) | Slow queries log length | `number` | `1000` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs | `string` | `null` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Close the connection after a client is idle for N seconds | `number` | `0` | no |
| <a name="input_tls_enabled"></a> [tls\_enabled](#input\_tls\_enabled) | TLS support mode enabled/disabled | `bool` | `false` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of maintenance window. Can be either ANYTIME or WEEKLY. A day and hour of window need to be specified with weekly window | `string` | `"ANYTIME"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The availability zone where the Redis host will be created. See https://cloud.yandex.com/en/docs/overview/concepts/geo-scope | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | List of FQDNs for Redis cluster hosts |
| <a name="output_fqdn_redis"></a> [fqdn\_redis](#output\_fqdn\_redis) | FQDN for the Redis cluster |
| <a name="output_health"></a> [health](#output\_health) | Aggregated health of the cluster. Can be either ALIVE, DEGRADED, DEAD or HEALTH\_UNKNOWN |
| <a name="output_password"></a> [password](#output\_password) | The password of the host |
| <a name="output_shard_name"></a> [shard\_name](#output\_shard\_name) | The name of the shard to which the host belongs |
| <a name="output_status"></a> [status](#output\_status) | Status of the cluster. Can be either CREATING, STARTING, RUNNING, UPDATING, STOPPING, STOPPED, ERROR or STATUS\_UNKNOWN |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
