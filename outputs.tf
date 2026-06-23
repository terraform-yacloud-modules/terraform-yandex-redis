output "fqdn" {
  description = "FQDN for the Redis cluster"
  value       = "c-${yandex_mdb_redis_cluster_v2.this.cluster_id}.rw.mdb.yandexcloud.net"
}

output "id" {
  description = "ID of the Redis cluster"
  value       = yandex_mdb_redis_cluster_v2.this.cluster_id
}

output "name" {
  description = "Name of the Redis cluster"
  value       = yandex_mdb_redis_cluster_v2.this.name
}

output "environment" {
  description = "Deployment environment of the Redis cluster"
  value       = yandex_mdb_redis_cluster_v2.this.environment
}

output "network_id" {
  description = "ID of the network to which the Redis cluster belongs"
  value       = yandex_mdb_redis_cluster_v2.this.network_id
}

output "description" {
  description = "Description of the Redis cluster"
  value       = yandex_mdb_redis_cluster_v2.this.description
}

output "folder_id" {
  description = "ID of the folder that the resource belongs to"
  value       = yandex_mdb_redis_cluster_v2.this.folder_id
}

output "labels" {
  description = "A set of key/value label pairs to assign to the Redis cluster"
  value       = yandex_mdb_redis_cluster_v2.this.labels
}

output "sharded" {
  description = "Redis Cluster mode enabled/disabled"
  value       = yandex_mdb_redis_cluster_v2.this.sharded
}

output "tls_enabled" {
  description = "TLS support mode enabled/disabled"
  value       = yandex_mdb_redis_cluster_v2.this.tls_enabled
}

output "persistence_mode" {
  description = "Persistence mode of the Redis cluster"
  value       = yandex_mdb_redis_cluster_v2.this.persistence_mode
}

output "security_group_ids" {
  description = "A set of ids of security groups assigned to hosts of the cluster"
  value       = yandex_mdb_redis_cluster_v2.this.security_group_ids
}

output "deletion_protection" {
  description = "Inhibits deletion of the cluster"
  value       = yandex_mdb_redis_cluster_v2.this.deletion_protection
}

output "config" {
  description = "Configuration of the Redis cluster"
  value       = yandex_mdb_redis_cluster_v2.this.config
  sensitive   = true
}

output "resources" {
  description = "Resources allocated to hosts of the Redis cluster"
  value       = yandex_mdb_redis_cluster_v2.this.resources
}

output "hosts" {
  description = "A list of hosts in the Redis cluster"
  value       = yandex_mdb_redis_cluster_v2.this.hosts
}

output "maintenance_window" {
  description = "Maintenance policy of the Redis cluster"
  value       = yandex_mdb_redis_cluster_v2.this.maintenance_window
}

output "health" {
  description = "Aggregated health of the cluster. Not exposed by yandex_mdb_redis_cluster_v2."
  value       = null
}

output "created_at" {
  description = "Creation timestamp of the cluster"
  value       = yandex_mdb_redis_cluster_v2.this.created_at
}

output "modules" {
  description = "Valkey modules configuration"
  value       = yandex_mdb_redis_cluster_v2.this.modules
}

output "user_password" {
  description = "Password of the Redis user (generated if not provided)"
  value       = local.user_password
  sensitive   = true
}
