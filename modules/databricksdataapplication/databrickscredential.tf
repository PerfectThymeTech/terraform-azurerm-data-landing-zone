resource "databricks_credential" "credential" {
  name = "${local.prefix}-cred"

  azure_managed_identity {
    access_connector_id = var.databricks_access_connector_id
  }
  comment        = "Managed identity credential for '${var.app_name}' Data Product"
  force_destroy  = true
  force_update   = true
  isolation_mode = "ISOLATION_MODE_ISOLATED"
  # owner          = data.databricks_current_user.current_user.user_name
  purpose        = "SERVICE"
  read_only      = false
}
