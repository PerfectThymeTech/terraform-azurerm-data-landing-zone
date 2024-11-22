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
