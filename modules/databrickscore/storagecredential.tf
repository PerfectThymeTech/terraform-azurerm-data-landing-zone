resource "databricks_storage_credential" "storage_credential_engineering_default" {
  name = "${local.prefix}-engnrng-default"

  azure_managed_identity {
    access_connector_id = var.databricks_workspace_details.engineering.access_connector_id
  }
  comment         = "Managed identity storage credential for default engineering catalog '${local.prefix}'"
  force_destroy   = true
  force_update    = true
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  read_only       = false
  skip_validation = false

  depends_on = [
    azurerm_role_assignment.role_assignment_storage_account_raw_blob_delegator_accessconnector,
    azurerm_role_assignment.role_assignment_storage_container_raw_blob_data_contributor_accessconnector,
  ]
}
