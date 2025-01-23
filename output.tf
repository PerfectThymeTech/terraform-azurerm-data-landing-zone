output "databricks_account_id" {
  description = "Specifies the account id of Databricks."
  value       = var.databricks_account_id
  sensitive   = false
}

output "databricks_network_connectivity_config_id" {
  description = "Specifies the id of the network connectivity config."
  value       = module.databricks_core.databricks_network_connectivity_config_id
  sensitive   = false
}
