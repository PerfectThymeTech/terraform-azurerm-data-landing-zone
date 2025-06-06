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
  count = var.databricks_workspace_consumption_enabled ? 1 : 0

  name     = "${local.prefix}-cnsmptn-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "resource_group_fabric" {
  name     = "${local.prefix}-fbrc-rg"
  location = var.location
  tags     = var.tags
}
