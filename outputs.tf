output "fqdn" {
  description = "FQDN for the Redis cluster"
  value       = "c-${yandex_mdb_redis_cluster.this.id}.rw.mdb.yandexcloud.net"
}

output "id" {
  description = "ID of the Redis cluster"
  value       = yandex_mdb_redis_cluster.this.id
}

output "name" {
  description = "Name of the Redis cluster"
  value       = yandex_mdb_redis_cluster.this.name
}

output "environment" {
  description = "Deployment environment of the Redis cluster"
  value       = yandex_mdb_redis_cluster.this.environment
}

output "network_id" {
  description = "ID of the network to which the Redis cluster belongs"
  value       = yandex_mdb_redis_cluster.this.network_id
}

output "description" {
  description = "Description of the Redis cluster"
  value       = yandex_mdb_redis_cluster.this.description
}

output "folder_id" {
  description = "ID of the folder that the resource belongs to"
  value       = yandex_mdb_redis_cluster.this.folder_id
}

output "labels" {
  description = "A set of key/value label pairs to assign to the Redis cluster"
  value       = yandex_mdb_redis_cluster.this.labels
}

output "sharded" {
  description = "Redis Cluster mode enabled/disabled"
  value       = yandex_mdb_redis_cluster.this.sharded
}

output "tls_enabled" {
  description = "TLS support mode enabled/disabled"
  value       = yandex_mdb_redis_cluster.this.tls_enabled
}

output "persistence_mode" {
  description = "Persistence mode of the Redis cluster"
  value       = yandex_mdb_redis_cluster.this.persistence_mode
}

output "security_group_ids" {
  description = "A set of ids of security groups assigned to hosts of the cluster"
  value       = yandex_mdb_redis_cluster.this.security_group_ids
}

output "deletion_protection" {
  description = "Inhibits deletion of the cluster"
  value       = yandex_mdb_redis_cluster.this.deletion_protection
}

output "config" {
  description = "Configuration of the Redis cluster"
  value       = yandex_mdb_redis_cluster.this.config
  sensitive   = false
}

output "resources" {
  description = "Resources allocated to hosts of the Redis cluster"
  value       = yandex_mdb_redis_cluster.this.resources
}

output "hosts" {
  description = "A list of hosts in the Redis cluster"
  value       = yandex_mdb_redis_cluster.this.host
}

output "maintenance_window" {
  description = "Maintenance policy of the Redis cluster"
  value       = yandex_mdb_redis_cluster.this.maintenance_window
}

output "health" {
  description = "Aggregated health of the cluster"
  value       = yandex_mdb_redis_cluster.this.health
}

output "created_at" {
  description = "Creation timestamp of the cluster"
  value       = yandex_mdb_redis_cluster.this.created_at
}
