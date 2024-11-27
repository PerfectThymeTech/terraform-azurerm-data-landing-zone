locals {
  # General locals
  prefix = "${lower(var.prefix)}-${lower(var.app_name)}-${var.environment}"

  # Databricks locals
  databricks_enterprise_application_id = "2ff814a6-3304-4ab8-85cb-cd0e6f879c1d"
  databricks_private_subnet_name       = reverse(split("/", var.subnet_id_databricks_private))[0]
  databricks_public_subnet_name        = reverse(split("/", var.subnet_id_databricks_public))[0]
  databricks_workspace_details = {
    "${var.app_name}" = {
      workspace_id        = module.databricks_workspace.databricks_workspace_workspace_id
      access_connector_id = module.databricks_access_connector.databricks_access_connector_id
    }
  }
  databricks_private_endpoint_rules = {}
}
