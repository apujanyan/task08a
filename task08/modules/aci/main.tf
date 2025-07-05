resource "azurerm_container_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  ip_address_type     = "Public"
  dns_name_label      = var.name
  sku                 = var.aci_sku

  container {
    name   = "redis-flask-app"
    image  = "${var.acr_login_server}/${var.docker_image_name}:latest"
    cpu    = 0.5
    memory = 1.5

    ports {
      port     = 8080
      protocol = "TCP"
    }

    ports {
      port     = 80
      protocol = "TCP"
    }

    ports {
      port     = 6380
      protocol = "TCP"
    }

    environment_variables = {
      CREATOR        = "ACI"
      REDIS_PORT     = "6380"
      REDIS_SSL_MODE = "true"
    }

    secure_environment_variables = {
      REDIS_URL = var.redis_hostname
      REDIS_PWD = var.redis_primary_key
    }
  }

  image_registry_credential {
    server   = var.acr_login_server
    username = var.acr_admin_username
    password = var.acr_admin_password

  }

  tags = var.tags
}