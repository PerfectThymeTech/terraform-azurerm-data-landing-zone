resource "databricks_storage_credential" "storage_credential" {
  name = "${local.prefix}-cred"

  azure_managed_identity {
    access_connector_id = var.databricks_access_connector_id
  }
  comment         = "Managed identity credential for '${var.app_name}' Data Product"
  force_destroy   = false
  force_update    = false
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  read_only       = false
  skip_validation = false
}
