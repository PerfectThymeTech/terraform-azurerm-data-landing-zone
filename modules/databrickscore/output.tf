output "databricks_network_connectivity_config_id" {
  description = "Specifies the id of the network connectivity config."
  value       = data.databricks_mws_network_connectivity_config.network_connectivity_config.network_connectivity_config_id
  sensitive   = false
}

output "databricks_service_principal_terraform_plan_application_id" {
  description = "Specifies the application id of the service principal used for Terraform Plan."
  value       = one(databricks_service_principal.service_principal_terraform_plan[*].application_id)
  sensitive   = false
}
