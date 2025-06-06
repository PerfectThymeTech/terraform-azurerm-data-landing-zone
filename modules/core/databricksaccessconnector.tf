module "databricks_access_connector_engineering" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/databricksaccessconnector?ref=main"
  providers = {
    azurerm = azurerm
  }

  location                         = var.location
  resource_group_name              = azurerm_resource_group.resource_group_engineering.name
  tags                             = var.tags
  databricks_access_connector_name = "${local.prefix}-eng-dbac001"
}

module "databricks_access_connector_consumption" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/databricksaccessconnector?ref=main"
  providers = {
    azurerm = azurerm
  }

  count = var.databricks_workspace_consumption_enabled ? 1 : 0

  location                         = var.location
  resource_group_name              = one(azurerm_resource_group.resource_group_consumption[*].name)
  tags                             = var.tags
  databricks_access_connector_name = "${local.prefix}-cnsmptn-dbac001"
}
