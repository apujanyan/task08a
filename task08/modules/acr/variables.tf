variable "name" {
  description = "ACR name."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "resource_group_name" {
  description = "ACR resource group."
  type        = string
}

variable "sku" {
  description = "ACR"
  type        = string
}

variable "git_pat" {
  sensitive   = true
  description = "Git PAT."
  type        = string
}

variable "docker_image_name" {
  description = "Docker image name."
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}