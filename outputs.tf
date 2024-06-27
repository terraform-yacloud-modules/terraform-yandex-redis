output "fqdn" {
  description = "The fully qualified domain name of the host"
  value       = yandex_mdb_redis_cluster.this.host[*].fqdn
}

output "shard_name" {
  description = "The name of the shard to which the host belongs"
  value       = yandex_mdb_redis_cluster.this.host[*].shard_name
}

output "health" {
  description = "Aggregated health of the cluster. Can be either ALIVE, DEGRADED, DEAD or HEALTH_UNKNOWN"
  value       = yandex_mdb_redis_cluster.this.health
}

output "status" {
  description = "Status of the cluster. Can be either CREATING, STARTING, RUNNING, UPDATING, STOPPING, STOPPED, ERROR or STATUS_UNKNOWN"
  value       = yandex_mdb_redis_cluster.this.status
}
