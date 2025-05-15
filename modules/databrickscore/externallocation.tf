resource "databricks_external_location" "external_location_engineering_default" {
  name = "${local.prefix}-engnrng-default"

  comment         = "Default storage layer for default catalog '${local.prefix}'."
  credential_name = databricks_storage_credential.storage_credential_engineering_default.name
  fallback        = false
  force_destroy   = true
  force_update    = true
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  read_only       = false
  skip_validation = false
  url             = "abfss://${azurerm_storage_container.storage_container_default_container.name}@${azurerm_storage_container.storage_container_default_container.storage_account_name}.dfs.core.windows.net/"
}
