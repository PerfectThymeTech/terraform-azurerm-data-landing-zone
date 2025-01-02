# Databricks outputs
output "databricks_access_connector_id" {
  description = "Specifies the workspace details of the Azure Databricks core workspace."
  value       = module.databricks_access_connector.databricks_access_connector_id
  sensitive   = false
}

# Key vault outputs
output "key_vault_details" {
  description = "Specifies the key vault details of the app."
  value = {
    key_vault_uri = module.key_vault.key_vault_uri
    key_vault_id  = module.key_vault.key_vault_id
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
