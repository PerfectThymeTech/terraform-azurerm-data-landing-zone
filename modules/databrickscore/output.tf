output "databricks_network_connectivity_config_id" {
  description = "Specifies the id of the network connectivity config."
  value       = data.databricks_mws_network_connectivity_config.network_connectivity_config.network_connectivity_config_id
  sensitive   = false
}

output "databricks_service_principal_terraform_plan_details" {
  description = "Specifies the details of the service principal used for Terraform Plan."
  value       = {
    application_id = var.service_principal_name_terraform_plan == "" ? "" : one(databricks_service_principal.service_principal_terraform_plan[*].application_id)
    acl_principal_id = var.service_principal_name_terraform_plan == "" ? "" : one(databricks_service_principal.service_principal_terraform_plan[*].acl_principal_id)
  }
  sensitive   = false
}
