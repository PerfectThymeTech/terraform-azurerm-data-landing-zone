data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "storage_rg" {
  name     = "${local.prefix}-storage-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "runtimes_rg" {
  name     = "${local.prefix}-runtimes-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "shared_app_aut_rg" {
  name     = "${local.prefix}-shared-app-aut-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "shared_app_exp_rg" {
  name     = "${local.prefix}-shared-app-exp-rg"
  location = var.location
  tags     = var.tags
}
