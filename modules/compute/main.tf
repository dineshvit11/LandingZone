resource "azurerm_network_interface" "vm" {
  count = var.vm_admin_ssh_public_key == null ? 0 : 1

  name                = "${var.resource_prefix}-mgmt-vm-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.vm_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count = var.vm_admin_ssh_public_key == null ? 0 : 1

  name                            = "${var.resource_prefix}-mgmt-vm01"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = "Standard_B2s"
  admin_username                  = "azureadmin"
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.vm[0].id]
  tags                            = var.tags

  admin_ssh_key {
    username   = "azureadmin"
    public_key = var.vm_admin_ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  count = var.aks_enabled ? 1 : 0

  name                              = "${var.resource_prefix}-aks"
  location                          = var.location
  resource_group_name               = var.resource_group_name
  dns_prefix                        = replace(var.resource_prefix, "-", "")
  role_based_access_control_enabled = true
  local_account_disabled            = length(var.aks_admin_group_object_ids) > 0
  tags                              = var.tags

  default_node_pool {
    name           = "system"
    node_count     = 2
    vm_size        = "Standard_D2s_v5"
    vnet_subnet_id = var.aks_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    admin_group_object_ids = var.aks_admin_group_object_ids
    azure_rbac_enabled     = true
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
    service_cidr      = "10.41.0.0/16"
    dns_service_ip    = "10.41.0.10"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  count = var.aks_enabled ? 1 : 0

  name                  = "user01"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks[0].id
  vm_size               = "Standard_D4s_v5"
  node_count            = 2
  mode                  = "User"
  vnet_subnet_id        = var.aks_subnet_id
  tags                  = var.tags
}
