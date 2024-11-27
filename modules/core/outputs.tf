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

# Storage outputs
output "storage_account_ids" {
  description = "Specifies the ids of the storage accounts in the core layer."
  value = {
    external  = module.storage_account_external.storage_account_id
    raw       = module.storage_account_raw.storage_account_id
    enriched  = module.storage_account_enriched.storage_account_id
    curated   = module.storage_account_curated.storage_account_id
    workspace = module.storage_account_workspace.storage_account_id
  }
  sensitive = false
}
