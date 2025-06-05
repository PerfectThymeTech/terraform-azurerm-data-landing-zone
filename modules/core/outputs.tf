# Databricks outputs
output "databricks_workspace_details" {
  description = "Specifies the workspace details of the Azure Databricks core workspace."
  value       = local.databricks_workspace_details
  sensitive   = false
  depends_on = [
    module.databricks_workspace_engineering.databricks_workspace_completed,
    # one(module.databricks_workspace_consumption[*].databricks_workspace_completed),
  ]
}

output "databricks_private_endpoint_rules" {
  description = "Specifies the workspace private endpoint rules for the network connectivity configuration of Azure Databricks."
  value       = local.databricks_private_endpoint_rules
  sensitive   = false
}

output "databricks_dependencies" {
  description = "Specifies the dependencies for Databricks."
  value = [
    module.databricks_workspace_engineering.databricks_workspace_completed,
    var.databricks_workspace_consumption_enabled ? one(module.databricks_workspace_consumption[*].databricks_workspace_completed) : true,
  ]
}

# Storage outputs
output "storage_account_ids" {
  description = "Specifies the ids of the storage accounts in the core layer."
  value = {
    provider  = module.storage_account_provider.storage_account_id
    raw       = module.storage_account_raw.storage_account_id
    enriched  = module.storage_account_enriched.storage_account_id
    curated   = module.storage_account_curated.storage_account_id
    workspace = module.storage_account_workspace.storage_account_id
  }
  sensitive = false
}

output "storage_dependencies" {
  description = "Specifies the dependencies for Databricks."
  value = [
    module.storage_account_provider.storage_setup_completed,
    module.storage_account_raw.storage_setup_completed,
    module.storage_account_enriched.storage_setup_completed,
    module.storage_account_curated.storage_setup_completed,
    module.storage_account_workspace.storage_setup_completed,
  ]
}

# Fabric outputs
output "fabric_capacity_name" {
  description = "Specifies the name of the Fabric capacity."
  value       = reverse(split("/", one(module.fabric_capacity[*].fabric_capacity_id)))[0]
}
