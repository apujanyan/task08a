variable "name_prefix" {
  description = "Name prefix for resources."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "keyvault_sku" {
  description = "Key Vault SKU."
  type        = string
}

variable "redis_capacity" {
  description = "Redis capacity."
  type        = number
}

variable "redis_sku" {
  description = "Redis SKU."
  type        = string
}
variable "redis_sku_family" {
  description = "Redis SKU family."
  type        = string
}

variable "redis_primary_key" {
  description = "Redis primary key secret name."
  type        = string
}
variable "redis_hostname" {
  description = "Redis hostname secret name."
  type        = string
}

variable "acr_sku" {
  description = "ACR SKU."
  type        = string
}

variable "aci_sku" {
  description = "ACI SKU."
  type        = string
}

variable "aks_node_pool_name" {
  description = "AKS node pool name."
  type        = string
}
variable "aks_node_pool_count" {
  description = "AKS node pool count."
  type        = number
}
variable "aks_node_pool_size" {
  description = "AKS node pool size."
  type        = string
}
variable "aks_node_pool_disk_type" {
  description = "AKS node pool disk type."
  type        = string
}

variable "git_pat" {
  sensitive   = true
  description = "Git PAT."
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}