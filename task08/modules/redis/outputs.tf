output "redis_id" {
  description = "Redis ID."
  value       = azurerm_redis_cache.this.id
}

output "redis_hostname" {
  description = "Redis hostname."
  value       = azurerm_redis_cache.this.hostname
}

output "redis_primary_key" {
  sensitive   = true
  description = "Redis primary key."
  value       = azurerm_redis_cache.this.primary_access_key
}