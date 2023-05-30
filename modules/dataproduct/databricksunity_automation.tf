resource "databricks_storage_credential" "automation_storage_credential" {
  count    = var.databricks_enabled && !var.databricks_experimentation && var.unity_catalog_configurations.enabled ? 1 : 0
  provider = databricks.automation
  name     = local.names.databricks_storage_credential

  azure_managed_identity {
    access_connector_id = one(azurerm_databricks_access_connector.databricks_access_connector[*].id)
  }
  comment = "Managed identity credential for ${var.data_product_name} Data Product"
}

resource "time_sleep" "sleep_dbac" {
  create_duration = "15s"

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

resource "databricks_external_location" "automation_external_location" {
  count    = var.databricks_enabled && !var.databricks_experimentation && var.unity_catalog_configurations.enabled ? 1 : 0
  provider = databricks.automation
  name     = local.names.databricks_external_location

  comment         = "Default Storage for ${var.data_product_name} Data Product"
  credential_name = one(databricks_storage_credential.automation_storage_credential[*].name)
  skip_validation = false
  url             = local.databricks_catalog_storage_root

  depends_on = [
    time_sleep.sleep_dbac
  ]
}

resource "databricks_catalog" "automation_catalog" {
  count        = var.databricks_enabled && !var.databricks_experimentation && var.unity_catalog_configurations.enabled ? 1 : 0
  provider     = databricks.automation
  metastore_id = var.unity_metastore_id
  name         = local.names.databricks_catalog

  comment       = "Data Product Catalog - ${var.data_product_name}"
  force_destroy = false
  properties = {
    purpose = "Data Product Catalog - ${var.data_product_name}"
  }
  storage_root = local.databricks_catalog_storage_root

  depends_on = [
    databricks_external_location.automation_external_location
  ]
}
