resource "databricks_catalog" "catalog" {
  count = var.databricks_access_connector_id != "" ? 1 : 0

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
