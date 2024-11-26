locals {
  # General locals
  prefix = "${lower(var.prefix)}-${var.app_name}-${var.environment}"

  # Databricks locals
  databricks_private_subnet_name = reverse(split("/", var.subnet_id_databricks_private))[0]
  databricks_public_subnet_name  = reverse(split("/", var.subnet_id_databricks_public))[0]
  databricks_workspace_details = {
    "${var.app_name}" = {
      workspace_id = module.databricks_workspace.databricks_workspace_workspace_id
    }
  }
  databricks_private_endpoint_rules = {}
}
