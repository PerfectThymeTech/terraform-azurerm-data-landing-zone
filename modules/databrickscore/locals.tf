locals {
  # General locals
  prefix = "${lower(var.prefix)}-${var.environment}-core"
  system_schema_names = [
    "access",
    # "billing", # billing system schema can only be enabled by Databricks
    "compute",
    "lakeflow",
    "lineage",
    "marketplace",
    "query",
    "serving",
    "storage",
  ]

  # Databricks locals
  databricks_access_connector_engineering = {
    resource_group_name = try(split("/", var.databricks_workspace_details.engineering.access_connector_id)[4], "")
    name                = try(split("/", var.databricks_workspace_details.engineering.access_connector_id)[8], "")
  }
}
