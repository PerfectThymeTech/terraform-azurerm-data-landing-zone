resource "azurerm_resource_group" "resource_group_storage" {
  name     = "${local.prefix}-storage-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "resource_group_consumption" {
  name     = "${local.prefix}-consumption-rg"
  location = var.location
  tags     = var.tags
}
