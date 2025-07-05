locals {
  rg_name           = join("-", [var.name_prefix, "rg"])
  keyvault_name     = join("-", [var.name_prefix, "kv"])
  redis_name        = join("-", [var.name_prefix, "redis"])
  aci_name          = join("-", [var.name_prefix, "ci"])
  aks_name          = join("-", [var.name_prefix, "aks"])
  docker_image_name = join("-", [var.name_prefix, "app"])
  acr_name          = replace("${var.name_prefix}cr", "-", "")
}
