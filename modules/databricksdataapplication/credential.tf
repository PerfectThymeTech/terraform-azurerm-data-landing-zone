resource "databricks_credential" "credential" {
  name = replace("${local.prefix}-cred", "-", "_")

  azure_managed_identity {
    access_connector_id = var.databricks_access_connector_id
  }
  comment        = "Managed identity credential for '${var.app_name}' Data Product"
  force_destroy  = true
  force_update   = true
  isolation_mode = "ISOLATION_MODE_ISOLATED"
  purpose        = "SERVICE"
  read_only      = false
  # owner          = data.databricks_current_user.current_user.user_name
}
