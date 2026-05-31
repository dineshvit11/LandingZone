variable "resource_group_name" {
  description = "Resource group where compute resources are created."
  type        = string
}

variable "location" {
  description = "Azure region for compute resources."
  type        = string
}

variable "resource_prefix" {
  description = "Prefix used for compute resource names."
  type        = string
}

variable "tags" {
  description = "Tags applied to compute resources."
  type        = map(string)
}

variable "vm_subnet_id" {
  description = "Subnet ID for the management VM."
  type        = string
}

variable "aks_subnet_id" {
  description = "Subnet ID for AKS node pools."
  type        = string
}

variable "vm_admin_ssh_public_key" {
  description = "SSH public key used to enable the optional management VM."
  type        = string
  default     = null
}

variable "aks_enabled" {
  description = "Deploy AKS cluster."
  type        = bool
}

variable "aks_admin_group_object_ids" {
  description = "Azure AD group object IDs that receive AKS admin access."
  type        = list(string)
  default     = []
}
