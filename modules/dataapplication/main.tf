resource "azurerm_resource_group" "resource_group_app" {
  name     = "${local.prefix}-rg"
  location = var.location
  tags     = local.tags
}

resource "azurerm_resource_group" "resource_group_app_monitoring" {
  name     = "${local.prefix}-mntrng-rg"
  location = var.location
  tags     = local.tags
}
