# Databricks outputs
output "databricks_access_connector_id" {
  description = "Specifies the workspace details of the Azure Databricks core workspace."
  value       = module.databricks_access_connector.databricks_access_connector_id
  sensitive   = false
  depends_on = [
    azurerm_role_assignment.role_assignment_storage_account_external_blob_delegator_accessconnector,
    azurerm_role_assignment.role_assignment_storage_account_raw_blob_delegator_accessconnector,
    azurerm_role_assignment.role_assignment_storage_account_curated_blob_delegator_accessconnector,
    azurerm_role_assignment.role_assignment_storage_account_enriched_blob_delegator_accessconnector,
    azurerm_role_assignment.role_assignment_storage_account_workspace_blob_delegator_accessconnector,
    azurerm_role_assignment.role_assignment_storage_container_external_blob_data_contributor_accessconnector,
    azurerm_role_assignment.role_assignment_storage_container_raw_blob_data_contributor_accessconnector,
    azurerm_role_assignment.role_assignment_storage_container_curated_blob_data_contributor_accessconnector,
    azurerm_role_assignment.role_assignment_storage_container_enriched_blob_data_contributor_accessconnector,
    azurerm_role_assignment.role_assignment_storage_container_workspace_blob_data_contributor_accessconnector,
  ]
}

# Key vault outputs
output "key_vault_details" {
  description = "Specifies the key vault details of the app."
  value = {
    key_vault_name = module.key_vault.key_vault_name
    key_vault_id   = module.key_vault.key_vault_id
    key_vault_uri  = module.key_vault.key_vault_uri
  }
  sensitive = false
}

# Data factory outputs
output "data_factory_details" {
  description = "Specifies the data factory details of the app."
  value = {
    data_factory_name         = module.data_factory.data_factory_name
    data_factory_id           = module.data_factory.data_factory_id
    data_factory_principal_id = module.data_factory.data_factory_principal_id
  }
  sensitive = false
}

# Storage outputs
output "storage_container_ids" {
  description = "Specifies the storage container ids of the app."
  value = {
    external  = azurerm_storage_container.storage_container_external.id
    raw       = azurerm_storage_container.storage_container_raw.id
    enriched  = azurerm_storage_container.storage_container_enriched.id
    curated   = azurerm_storage_container.storage_container_curated.id
    workspace = azurerm_storage_container.storage_container_workspace.id
  }
  sensitive = false
}
