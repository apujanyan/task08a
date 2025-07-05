resource "azurerm_container_registry" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  admin_enabled       = true

  tags = var.tags
}

resource "azurerm_container_registry_task" "docker_build_task" {
  name                  = "build-task"
  container_registry_id = azurerm_container_registry.this.id

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = "https://github.com/apujanyan/task08a.git#main:task08/application"
    context_access_token = var.git_pat
    image_names          = ["${var.docker_image_name}:latest"]
  }

  depends_on = [azurerm_container_registry.this]

  tags = var.tags
}

resource "azurerm_container_registry_task_schedule_run_now" "build_now" {
  container_registry_task_id = azurerm_container_registry_task.docker_build_task.id

  depends_on = [azurerm_container_registry.this]
}