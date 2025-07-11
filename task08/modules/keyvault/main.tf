resource "azurerm_key_vault" "this" {
  name                     = var.name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = var.sku
  purge_protection_enabled = false

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "current_user" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Restore", "Purge", "Recover", "Backup"
  ]
}

data "azurerm_client_config" "current" {}