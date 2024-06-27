output "status" {
  description = "Status of the cluster"
  value       = module.redis_simple.status
}

output "fqdn" {
  description = "The fully qualified domain name of the cluster"
  value       = module.redis_simple.fqdn
}
