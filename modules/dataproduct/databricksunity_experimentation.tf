resource "databricks_storage_credential" "experimentation_storage_credential" {
  count    = var.databricks_enabled && var.databricks_experimentation && var.unity_catalog_configurations.enabled ? 1 : 0
  provider = databricks.experimentation
  name     = local.names.databricks_storage_credential

  azure_managed_identity {
    access_connector_id = one(azurerm_databricks_access_connector.databricks_access_connector[*].id)
  }
  comment = "Managed identity credential for ${var.data_product_name} Data Product"

  depends_on = [
    var.dependencies_databricks
  ]
}

resource "databricks_external_location" "experimentation_external_location" {
  count    = var.databricks_enabled && var.databricks_experimentation && var.unity_catalog_configurations.enabled ? 1 : 0
  provider = databricks.experimentation
  name     = local.names.databricks_external_location

  comment         = "Default Storage for ${var.data_product_name} Data Product"
  credential_name = one(databricks_storage_credential.experimentation_storage_credential[*].name)
  skip_validation = false
  url             = local.databricks_catalog_storage_root

  depends_on = [
    var.dependencies_databricks,
    time_sleep.sleep_dbac
  ]
}

resource "databricks_catalog" "experimentation_catalog" {
  count        = var.databricks_enabled && var.databricks_experimentation && var.unity_catalog_configurations.enabled ? 1 : 0
  provider     = databricks.experimentation
  metastore_id = var.unity_metastore_id
  name         = local.names.databricks_catalog

  comment       = "Data Product Catalog - ${var.data_product_name}"
  force_destroy = false
  properties = {
    purpose = "Data Product Catalog - ${var.data_product_name}"
  }
  storage_root = local.databricks_catalog_storage_root

  depends_on = [
    databricks_external_location.experimentation_external_location
  ]
}
