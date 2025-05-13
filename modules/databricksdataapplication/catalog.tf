resource "databricks_catalog" "catalog_provider" {
  for_each = {
    for key, value in var.data_provider_details :
    key => value if value.databricks_catalog.enabled
  }

  name = "${local.prefix}-${each.key}-pro"

  comment                        = "Data Applicaton Catalog - ${var.app_name}-${each.key} - Data Provider"
  enable_predictive_optimization = "DISABLE" # Consider enabling this property or use "INHERIT"
  force_destroy                  = true
  isolation_mode                 = "ISOLATED"
  properties = merge({
    location = var.location
    use      = "data-provider-${each.key}"
  }, local.tags)
  storage_root = databricks_external_location.external_location_provider[each.key].url
}

resource "databricks_catalog" "catalog_internal" {
  name = "${local.prefix}-int"

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
  name = "${local.prefix}-pub"

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

resource "databricks_workspace_binding" "workspace_binding_catalog_provider" {
  for_each = merge([
    for key, value in var.data_provider_details : {
      for item in value.databricks_catalog.workspace_binding_catalog :
      "${key}-${item}" => {
        key                                    = key
        workspace_binding_catalog_workspace_id = item
      } if value.databricks_catalog.enabled
    }
  ]...)

  binding_type   = "BINDING_TYPE_READ_WRITE"
  securable_name = databricks_catalog.catalog_provider[each.value.key].name
  securable_type = "catalog"
  workspace_id   = each.value.workspace_binding_catalog_workspace_id
}
