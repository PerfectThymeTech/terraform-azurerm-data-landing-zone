module "databricks_access_connector" {
  # count = var.subnet_id_databricks_private != "" && var.subnet_id_databricks_public != "" ? 1 : 0

  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/databricksaccessconnector?ref=main"
  providers = {
    azurerm = azurerm
  }

  location                         = var.location
  resource_group_name              = azurerm_resource_group.resource_group_app.name
  tags                             = var.tags
  databricks_access_connector_name = "${local.prefix}-dbac001"
}
