resource "azurerm_resource_group" "resource_group_app" {
  name     = "${local.prefix}-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "resource_group_app_monitoring" {
  name     = "${local.prefix}-monitoring-rg"
  location = var.location
  tags     = var.tags
}
