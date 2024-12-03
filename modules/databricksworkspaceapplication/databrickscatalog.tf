resource "databricks_catalog" "catalog" {
  # count = var.databricks_access_connector_id != "" ? 1 : 0

  name = local.prefix

  comment                        = "Data Applicaton Catalog - ${var.app_name}"
  enable_predictive_optimization = "DISABLE" # Consider enabling this property or use "INHERIT"
  force_destroy                  = false
  isolation_mode                 = "ISOLATED"
  properties = merge({
    location    = var.location
    environment = var.environment
    app_name    = var.app_name
  }, var.tags)
  storage_root = one(databricks_external_location.external_location_curated[*].url)
}

resource "databricks_workspace_binding" "workspace_binding_catalog" {
  for_each = var.databricks_workspace_binding_catalog

  binding_type   = "BINDING_TYPE_READ_ONLY"
  securable_name = databricks_catalog.catalog.name
  securable_type = "catalog"
  workspace_id   = each.value.workspace_id
}
