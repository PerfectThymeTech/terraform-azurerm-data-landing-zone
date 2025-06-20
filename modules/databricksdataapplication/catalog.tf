resource "databricks_catalog" "catalog_internal" {
  name = replace("${local.prefix}-int", "-", "_")

  comment                        = "Data Applicaton Catalog - ${var.app_name} - Internal"
  enable_predictive_optimization = "DISABLE" # Consider enabling this property or use "INHERIT"
  force_destroy                  = true
  isolation_mode                 = "ISOLATED"
  properties = merge({
    location = var.location
    use      = "internal"
  }, local.tags)
  storage_root = one(databricks_external_location.external_location_curated[*].url)
}

resource "databricks_catalog" "catalog_published" {
  name = replace("${local.prefix}-pub", "-", "_")

  comment                        = "Data Applicaton Catalog - ${var.app_name} - Published"
  enable_predictive_optimization = "DISABLE" # Consider enabling this property or use "INHERIT"
  force_destroy                  = true
  isolation_mode                 = "OPEN"
  properties = merge({
    location = var.location
    use      = "published"
  }, local.tags)
  storage_root = one(databricks_external_location.external_location_curated[*].url)
}

resource "databricks_workspace_binding" "workspace_binding_catalog_internal" {
  for_each = var.databricks_workspace_binding_catalog

  binding_type   = "BINDING_TYPE_READ_WRITE"
  securable_name = databricks_catalog.catalog_internal.name
  securable_type = "catalog"
  workspace_id   = each.value.workspace_id
}
