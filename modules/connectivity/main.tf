resource "azurerm_resource_group" "connectivity" {
  name     = var.rg_name
  location = var.location

  tags = var.tags
}