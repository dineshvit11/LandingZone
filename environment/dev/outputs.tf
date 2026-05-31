output "resource_group" {
  description = "Landing zone resource group."
  value = {
    name = azurerm_resource_group.landing_zone.name
    id   = azurerm_resource_group.landing_zone.id
  }
}

output "network" {
  description = "Landing zone hub-spoke network resources."
  value = {
    hub_vnet_id                = module.network.hub_vnet_id
    workload_vnet_id           = module.network.workload_vnet_id
    aks_subnet_id              = module.network.aks_subnet_id
    vm_subnet_id               = module.network.vm_subnet_id
    private_endpoint_subnet_id = module.network.private_endpoint_subnet_id
    aks_nsg_id                 = module.network.aks_nsg_id
    vm_nsg_id                  = module.network.vm_nsg_id
  }
}

output "vm_id" {
  description = "VM ID when vm_admin_ssh_public_key is provided."
  value       = module.compute.vm_id
}

output "aks_cluster_id" {
  description = "AKS cluster ID when AKS deployment is enabled."
  value       = module.compute.aks_cluster_id
}
