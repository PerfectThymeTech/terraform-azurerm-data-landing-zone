resource "azurerm_databricks_access_connector" "databricks_access_connector" {
  count               = var.databricks_enabled && var.unity_catalog_configurations.enabled ? 1 : 0
  name                = local.names.databricks_access_connector
  location            = var.location
  resource_group_name = azurerm_resource_group.data_product_rg.name
  tags                = var.tags
  identity {
    type = "SystemAssigned"
  }
}

resource "time_sleep" "sleep_dbac" {
  create_duration = "30s"

  depends_on = [
    azurerm_role_assignment.dbac_roleassignment_storage_raw,
    azurerm_role_assignment.dbac_roleassignment_container_raw,
    azurerm_role_assignment.dbac_roleassignment_storage_enriched,
    azurerm_role_assignment.dbac_roleassignment_container_enriched,
    azurerm_role_assignment.dbac_roleassignment_storage_curated,
    azurerm_role_assignment.dbac_roleassignment_container_curated,
    azurerm_role_assignment.dbac_roleassignment_storage_workspace,
    azurerm_role_assignment.dbac_roleassignment_container_workspace,
  ]
}
