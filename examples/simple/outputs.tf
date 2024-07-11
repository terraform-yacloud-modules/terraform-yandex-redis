output "fqdn" {
  description = "The fully qualified domain name of the cluster"
  value       = module.redis_simple.fqdn
}

output "password" {
  description = "The password of the host"
  value       = module.redis_simple.password
  sensitive   = true
}
