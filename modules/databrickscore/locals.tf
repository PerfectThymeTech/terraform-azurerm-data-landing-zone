locals {
  # General locals
  prefix = "${lower(var.prefix)}-${var.environment}-core"
  system_schema_names = [
    # "access", # access system schema is automatically enabled by Databricks
    # "billing", # billing system schema is automatically enabled by Databricks
    # "compute", # compute system schema is automatically enabled by Databricks
    # "lakeflow", # lakeflow system schema is automatically enabled by Databricks
    # "lineage", # lineage system schema can only be enabled by Databricks
    # "marketplace", # marketplace system schema can only be enabled by Databricks
    # "query", # query system schema can only be enabled by Databricks
    # "serving", # serving system schema is automatically enabled by Databricks
    # "storage", # storage system schema is automatically enabled by Databricks
  ]

  # Databricks locals
  databricks_access_connector_engineering = {
    resource_group_name = try(split("/", var.databricks_workspace_details.engineering.access_connector_id)[4], "")
    name                = try(split("/", var.databricks_workspace_details.engineering.access_connector_id)[8], "")
  }
}
