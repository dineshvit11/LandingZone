variable "subscription_id" {
  description = "Azure subscription ID. If null, the AzureRM provider uses ARM_SUBSCRIPTION_ID or Azure CLI context."
  type        = string
  default     = null
  nullable    = true
}

variable "location" {
  description = "Azure region where landing zone resources are created."
  type        = string
  default     = "eastus"

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "location must not be empty."
  }
}

variable "tags" {
  description = "Common tags applied to all landing zone resources."
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "platform"
    Workload    = "landing-zone"
  }

  validation {
    condition     = alltrue([for key in ["Environment", "Owner"] : contains(keys(var.tags), key)])
    error_message = "tags must include Environment and Owner."
  }
}

variable "resource_prefix" {
  description = "Prefix used for dev landing zone resource names."
  type        = string
  default     = "lz-dev"
}

variable "resource_group_name" {
  description = "Name of the dev landing zone resource group."
  type        = string
  default     = "LandingZoneTravel"
}

variable "aks_enabled" {
  description = "Deploy the dev AKS cluster."
  type        = bool
  default     = true
}

variable "aks_admin_group_object_ids" {
  description = "Azure AD group object IDs that receive AKS cluster admin access."
  type        = list(string)
  default     = []
}

variable "vm_admin_ssh_public_key" {
  description = "SSH public key used to enable the optional dev jump VM. Leave null to skip VM deployment."
  type        = string
  default     = null
}

variable "hub_address_space" {
  description = "Hub VNet address space."
  type        = list(string)
  default     = ["10.40.0.0/20"]
}

variable "workload_address_space" {
  description = "Workload spoke VNet address space."
  type        = list(string)
  default     = ["10.40.16.0/20"]
}

variable "hub_subnets" {
  description = "Hub subnet prefixes."
  type = object({
    firewall = list(string)
    bastion  = list(string)
    shared   = list(string)
  })
  default = {
    firewall = ["10.40.0.0/26"]
    bastion  = ["10.40.0.64/26"]
    shared   = ["10.40.1.0/24"]
  }
}

variable "workload_subnets" {
  description = "Workload spoke subnet prefixes."
  type = object({
    aks               = list(string)
    vm                = list(string)
    private_endpoints = list(string)
  })
  default = {
    aks               = ["10.40.16.0/24"]
    vm                = ["10.40.17.0/24"]
    private_endpoints = ["10.40.18.0/24"]
  }
}
