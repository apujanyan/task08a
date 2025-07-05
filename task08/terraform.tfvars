name_prefix             = "cmtr-d4qm9uvw-mod8"
location                = "northeurope"
redis_capacity          = 2
redis_sku               = "Basic"
redis_sku_family        = "C"
keyvault_sku            = "standard"
redis_primary_key       = "redis-primary-key"
redis_hostname          = "redis-hostname"
acr_sku                 = "Standard"
aci_sku                 = "Standard"
aks_node_pool_name      = "system"
aks_node_pool_count     = 1
aks_node_pool_size      = "Standard_D2ads_v5"
aks_node_pool_disk_type = "Ephemeral"
tags = {
  "Creator" = "aramazd_apujanyan@epam.com"
}