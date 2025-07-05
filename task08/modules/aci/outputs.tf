output "aci_fqdn" {
  description = "ACI FQDN."
  value       = azurerm_container_group.this.fqdn
}