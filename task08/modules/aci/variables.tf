variable "name" {
  description = "ACI name."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "resource_group_name" {
  description = "ACI resource group name."
  type        = string
}

variable "acr_login_server" {
  description = "ACR login server."
  type        = string
}

variable "docker_image_name" {
  description = "Docker image name."
  type        = string
}

variable "redis_hostname" {
  sensitive   = true
  description = "Redis hostname."
  type        = string
}

variable "redis_primary_key" {
  sensitive   = true
  description = "Redis primary key."
  type        = string
}

variable "aci_sku" {
  description = "ACI SKU."
  type        = string
}

variable "acr_admin_username" {
  description = "ACR admin username."
  type        = string
}

variable "acr_admin_password" {
  description = "ACR admin password"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}