output "fqdn" {
  description = "List of FQDNs for Redis cluster hosts"
  value       = yandex_mdb_redis_cluster.this.host[*].fqdn
}

output "fqdn_redis" {
  description = "FQDN for the Redis cluster"
  value       = "c-${yandex_mdb_redis_cluster.this.id}.rw.mdb.yandexcloud.net"
}

output "password" {
  description = "The password of the host"
  value       = var.password
  sensitive   = true
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
