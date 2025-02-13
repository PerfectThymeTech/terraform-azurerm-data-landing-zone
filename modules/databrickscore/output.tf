output "databricks_network_connectivity_config_id" {
  description = "Specifies the id of the network connectivity config."
  value       = data.databricks_mws_network_connectivity_config.network_connectivity_config.network_connectivity_config_id
  sensitive   = false
}
