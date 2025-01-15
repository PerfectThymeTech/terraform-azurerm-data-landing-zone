# Storage Role Assignments
resource "azurerm_role_assignment" "accessconnector_role_assignment_storage_account_external_blob_delegator" {
  scope                = var.storage_account_ids.external
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "accessconnector_role_assignment_storage_container_external_blob_data_contributor" {
  scope                = azurerm_storage_container.storage_container_external.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "accessconnector_role_assignment_storage_account_raw_blob_delegator" {
  scope                = var.storage_account_ids.raw
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "accessconnector_role_assignment_storage_container_raw_blob_data_contributor" {
  scope                = azurerm_storage_container.storage_container_raw.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "accessconnector_role_assignment_storage_account_enriched_blob_delegator" {
  scope                = var.storage_account_ids.enriched
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "accessconnector_role_assignment_storage_container_enriched_blob_data_contributor" {
  scope                = azurerm_storage_container.storage_container_enriched.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "accessconnector_role_assignment_storage_account_curated_blob_delegator" {
  scope                = var.storage_account_ids.curated
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "accessconnector_role_assignment_storage_container_curated_blob_data_contributor" {
  scope                = azurerm_storage_container.storage_container_curated.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "accessconnector_role_assignment_storage_account_workspace_blob_delegator" {
  scope                = var.storage_account_ids.workspace
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "accessconnector_role_assignment_storage_container_workspace_blob_data_contributor" {
  scope                = azurerm_storage_container.storage_container_workspace.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}
