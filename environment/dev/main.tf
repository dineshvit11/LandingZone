module "management" {
  source   = "../../../modules/management"
  rg_name  = "dev-management-rg"
  location = var.location
  tags     = var.tags
}

module "identity" {
  source   = "../../../modules/identity"
  rg_name  = "dev-identity-rg"
  location = var.location
  tags     = var.tags
}

module "connectivity" {
  source   = "../../../modules/connectivity"
  rg_name  = "dev-connectivity-rg"
  location = var.location
  tags     = var.tags
}

module "security" {
  source   = "../../../modules/security"
  rg_name  = "dev-security-rg"
  location = var.location
  tags     = var.tags
}