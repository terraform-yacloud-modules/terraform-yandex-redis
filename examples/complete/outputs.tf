output "fqdn" {
  description = "The fully qualified domain name of the cluster"
  value       = module.redis_complete.fqdn
}

output "id" {
  description = "ID of the Redis cluster"
  value       = module.redis_complete.id
}

output "name" {
  description = "Name of the Redis cluster"
  value       = module.redis_complete.name
}

output "environment" {
  description = "Deployment environment of the Redis cluster"
  value       = module.redis_complete.environment
}

output "network_id" {
  description = "ID of the network to which the Redis cluster belongs"
  value       = module.redis_complete.network_id
}

output "description" {
  description = "Description of the Redis cluster"
  value       = module.redis_complete.description
}

output "folder_id" {
  description = "ID of the folder that the resource belongs to"
  value       = module.redis_complete.folder_id
}

output "labels" {
  description = "A set of key/value label pairs to assign to the Redis cluster"
  value       = module.redis_complete.labels
}

output "sharded" {
  description = "Redis Cluster mode enabled/disabled"
  value       = module.redis_complete.sharded
}

output "tls_enabled" {
  description = "TLS support mode enabled/disabled"
  value       = module.redis_complete.tls_enabled
}

output "persistence_mode" {
  description = "Persistence mode of the Redis cluster"
  value       = module.redis_complete.persistence_mode
}

output "security_group_ids" {
  description = "A set of ids of security groups assigned to hosts of the cluster"
  value       = module.redis_complete.security_group_ids
}

output "deletion_protection" {
  description = "Inhibits deletion of the cluster"
  value       = module.redis_complete.deletion_protection
}

output "config" {
  description = "Configuration of the Redis cluster"
  value       = module.redis_complete.config
  sensitive   = true
}

output "resources" {
  description = "Resources allocated to hosts of the Redis cluster"
  value       = module.redis_complete.resources
}

output "hosts" {
  description = "A list of hosts in the Redis cluster"
  value       = module.redis_complete.hosts
}

output "maintenance_window" {
  description = "Maintenance policy of the Redis cluster"
  value       = module.redis_complete.maintenance_window
}

output "created_at" {
  description = "Creation timestamp of the cluster"
  value       = module.redis_complete.created_at
}

output "modules" {
  description = "Valkey modules configuration"
  value       = module.redis_complete.modules
}

output "users" {
  description = "Map of Redis users with their passwords and permissions"
  value       = module.redis_complete.users
  sensitive   = true
}
