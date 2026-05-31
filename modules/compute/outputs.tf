output "vm_id" {
  description = "Management VM ID when SSH key is provided."
  value       = try(azurerm_linux_virtual_machine.vm[0].id, null)
}

output "aks_cluster_id" {
  description = "AKS cluster ID when AKS is enabled."
  value       = try(azurerm_kubernetes_cluster.aks[0].id, null)
}

output "aks_user_node_pool_id" {
  description = "AKS user node pool ID when AKS is enabled."
  value       = try(azurerm_kubernetes_cluster_node_pool.user[0].id, null)
}
