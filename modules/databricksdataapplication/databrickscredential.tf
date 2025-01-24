resource "databricks_credential" "credential" {
  name = "${local.prefix}-cred"

  azure_managed_identity {
    access_connector_id = var.databricks_access_connector_id
  }
  comment = "Managed identity credential for '${var.app_name}' Data Product"
  purpose = "SERVICE"
}
