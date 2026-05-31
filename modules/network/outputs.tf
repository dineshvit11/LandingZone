output "hub_vnet_id" {
  description = "Hub VNet ID."
  value       = azurerm_virtual_network.hub.id
}

output "workload_vnet_id" {
  description = "Workload spoke VNet ID."
  value       = azurerm_virtual_network.workload.id
}

output "aks_subnet_id" {
  description = "AKS subnet ID."
  value       = azurerm_subnet.aks.id
}

output "vm_subnet_id" {
  description = "VM subnet ID."
  value       = azurerm_subnet.vm.id
}

output "private_endpoint_subnet_id" {
  description = "Private endpoint subnet ID."
  value       = azurerm_subnet.private_endpoints.id
}

output "aks_nsg_id" {
  description = "AKS NSG ID."
  value       = azurerm_network_security_group.aks.id
}

output "vm_nsg_id" {
  description = "VM NSG ID."
  value       = azurerm_network_security_group.vm.id
}
