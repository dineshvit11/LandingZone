terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-prod"
    storage_account_name = "stlandingzonetf"
    container_name       = "tfstate"
    key                  = "dev/terraform.tfstate"
  }
}