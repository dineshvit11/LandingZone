variable "resource_group_name" {
  description = "Resource group where network resources are created."
  type        = string
}

variable "location" {
  description = "Azure region for network resources."
  type        = string
}

variable "resource_prefix" {
  description = "Prefix used for network resource names."
  type        = string
}

variable "tags" {
  description = "Tags applied to network resources."
  type        = map(string)
}

variable "hub_address_space" {
  description = "Hub VNet address space."
  type        = list(string)
}

variable "workload_address_space" {
  description = "Workload spoke VNet address space."
  type        = list(string)
}

variable "hub_subnets" {
  description = "Hub subnet address prefixes."
  type = object({
    firewall = list(string)
    bastion  = list(string)
    shared   = list(string)
  })
}

variable "workload_subnets" {
  description = "Workload spoke subnet address prefixes."
  type = object({
    aks               = list(string)
    vm                = list(string)
    private_endpoints = list(string)
  })
}
