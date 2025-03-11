resource "azurerm_resource_group" "resource_group_storage" {
  name     = "${local.prefix}-strg-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "resource_group_engineering" {
  name     = "${local.prefix}-engnrng-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "resource_group_consumption" {
  name     = "${local.prefix}-cnsmptn-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "resource_group_fabric" {
  name     = "${local.prefix}-fbrc-rg"
  location = var.location
  tags     = var.tags
}
