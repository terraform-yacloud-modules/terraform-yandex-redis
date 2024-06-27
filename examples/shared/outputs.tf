output "status" {
  description = "Status of the cluster. Can be either CREATING, STARTING, RUNNING, UPDATING, STOPPING, STOPPED, ERROR or STATUS_UNKNOWN"
  value       = module.redis_sharded.status
}

output "shard_name" {
  description = "The name of the shard to which the host belongs"
  value       = module.redis_sharded.shard_name
}

output "fqdn" {
  description = "The fully qualified domain name of the host"
  value       = module.redis_sharded.fqdn
}
