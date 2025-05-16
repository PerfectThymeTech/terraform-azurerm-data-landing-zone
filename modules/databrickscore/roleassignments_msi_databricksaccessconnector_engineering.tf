# Storage Role Assignments
resource "azurerm_role_assignment" "role_assignment_storage_account_raw_blob_delegator_accessconnector" {
  description          = "Role assignment to raw storage account to create SAS keys."
  scope                = var.storage_account_ids.raw
  role_definition_name = "Storage Blob Delegator"
  principal_id         = var.databricks_workspace_details.engineering.access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_raw_blob_data_contributor_accessconnector" {
  description          = "Role assignment to raw storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_engineering_default.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.databricks_workspace_details.engineering.access_connector_principal_id
  principal_type       = "ServicePrincipal"
}
