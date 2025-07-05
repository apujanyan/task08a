resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.location

  tags = var.tags
}

module "acr" {
  source              = "./modules/acr"
  name                = local.acr_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = var.acr_sku
  docker_image_name   = local.docker_image_name
  git_pat             = var.git_pat

  tags = var.tags
}

module "keyvault" {
  source              = "./modules/keyvault"
  name                = local.keyvault_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = var.keyvault_sku

  depends_on = [module.acr]

  tags = var.tags
}

module "redis" {
  source                        = "./modules/redis"
  name                          = local.redis_name
  location                      = var.location
  resource_group_name           = azurerm_resource_group.main.name
  sku                           = var.redis_sku
  family                        = var.redis_sku_family
  capacity                      = var.redis_capacity
  keyvault_id                   = module.keyvault.keyvault_id
  redis_hostname_secret_name    = var.redis_hostname
  redis_primary_key_secret_name = var.redis_primary_key

  depends_on = [module.keyvault]

  tags = var.tags
}

module "aci" {
  source              = "./modules/aci"
  name                = local.aci_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  acr_login_server    = module.acr.acr_login_server
  docker_image_name   = local.docker_image_name
  redis_hostname      = module.redis.redis_hostname
  redis_primary_key   = module.redis.redis_primary_key
  aci_sku             = var.aci_sku
  acr_admin_username  = module.acr.acr_admin_username
  acr_admin_password  = module.acr.acr_admin_password

  depends_on = [module.acr, module.redis]

  tags = var.tags
}

module "aks" {
  source                      = "./modules/aks"
  name                        = local.aks_name
  location                    = var.location
  resource_group_name         = azurerm_resource_group.main.name
  default_node_pool_name      = var.aks_node_pool_name
  default_node_pool_count     = var.aks_node_pool_count
  default_node_pool_size      = var.aks_node_pool_size
  default_node_pool_disk_type = var.aks_node_pool_disk_type
  acr_id                      = module.acr.acr_id
  keyvault_id                 = module.keyvault.keyvault_id

  depends_on = [module.acr, module.redis]

  tags = var.tags
}

resource "kubectl_manifest" "secret_provider" {
  provider = kubectl

  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.aks_managed_identity_id
    kv_name                    = module.keyvault.keyvault_name
    redis_url_secret_name      = var.redis_hostname
    redis_password_secret_name = var.redis_primary_key
    tenant_id                  = data.azurerm_client_config.current.tenant_id
  })

  depends_on = [module.aks]
}

resource "kubectl_manifest" "deployment" {
  provider = kubectl

  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = local.docker_image_name
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider]
}

resource "kubectl_manifest" "service" {
  provider = kubectl

  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [kubectl_manifest.deployment]
}

data "kubernetes_service" "app_service" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }

  depends_on = [kubectl_manifest.service]
}

data "azurerm_client_config" "current" {}