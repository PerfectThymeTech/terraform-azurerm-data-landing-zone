resource "databricks_catalog" "catalog_engineering_default" {
  name = "${local.prefix}-engnrng-default"

  comment                        = "Default Catalog - '${local.prefix}-engnrng'"
  enable_predictive_optimization = "DISABLE" # Consider enabling this property or use "INHERIT"
  force_destroy                  = true
  isolation_mode                 = "ISOLATED"
  properties = merge({
    location = var.location
    use      = "default-${local.prefix}"
  }, var.tags)
  storage_root = databricks_external_location.external_location_engineering_default.url
}
