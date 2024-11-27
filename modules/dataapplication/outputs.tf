# Databricks outputs
output "databricks_workspace_details" {
  description = "Specifies the workspace details of the Azure Databricks core workspace."
  value       = local.databricks_workspace_details
  sensitive   = false
}

output "databricks_private_endpoint_rules" {
  description = "Specifies the workspace private endpoint rules for the network connectivity configuration of Azure Databricks."
  value       = local.databricks_private_endpoint_rules
  sensitive   = false
}

# Key vault outputs
output "key_vault_details" {
  description = "Specifies the key vault details of the app."
  value       = {
    key_vault_uri = module.key_vault.key_vault_uri
    key_vault_id  = module.key_vault.key_vault_id
  }
  sensitive   = false
}

# Storage outputs
output "storage_container_ids" {
  description = "Specifies the ids of the storage accounts in the core layer."
  value = {
    external  = azurerm_storage_container.storage_container_external.id
    raw       = azurerm_storage_container.storage_container_raw.id
    enriched  = azurerm_storage_container.storage_container_enriched.id
    curated   = azurerm_storage_container.storage_container_curated.id
    workspace = azurerm_storage_container.storage_container_workspace.id
  }
  sensitive = false
}
