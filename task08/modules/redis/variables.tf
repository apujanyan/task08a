variable "name" {
  description = "Redis name."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "resource_group_name" {
  description = "Redis resource group."
  type        = string
}

variable "sku" {
  description = "Redis SKU."
  type        = string
}

variable "family" {
  description = "Redis SKU family."
  type        = string
}

variable "capacity" {
  description = "Redis capacity."
  type        = number
}

variable "keyvault_id" {
  description = "Key Vault ID."
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Redis hostname secret name."
  type        = string
}

variable "redis_primary_key_secret_name" {
  description = "Redis primary key secret name."
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}