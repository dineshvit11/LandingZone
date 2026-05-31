resource "azurerm_resource_group" "landing_zone" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source = "../../modules/network"

  resource_group_name = azurerm_resource_group.landing_zone.name
  location            = azurerm_resource_group.landing_zone.location
  resource_prefix     = var.resource_prefix
  tags                = var.tags

  hub_address_space      = var.hub_address_space
  workload_address_space = var.workload_address_space
  hub_subnets            = var.hub_subnets
  workload_subnets       = var.workload_subnets
}

module "compute" {
  source = "../../modules/compute"

  resource_group_name        = azurerm_resource_group.landing_zone.name
  location                   = azurerm_resource_group.landing_zone.location
  resource_prefix            = var.resource_prefix
  tags                       = var.tags
  vm_subnet_id               = module.network.vm_subnet_id
  aks_subnet_id              = module.network.aks_subnet_id
  vm_admin_ssh_public_key    = var.vm_admin_ssh_public_key
  aks_enabled                = var.aks_enabled
  aks_admin_group_object_ids = var.aks_admin_group_object_ids

  depends_on = [module.network]
}
