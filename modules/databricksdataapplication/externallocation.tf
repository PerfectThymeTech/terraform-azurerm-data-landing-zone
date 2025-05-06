resource "databricks_external_location" "external_location_provider" {
  for_each = var.data_provider_details

  name = "${local.prefix}-${each.key}-pro"

  comment         = "Default provider storage layer for '${var.app_name}-${each.key}' data application data provider."
  credential_name = one(databricks_storage_credential.storage_credential[*].name)
  fallback        = false
  force_destroy   = true
  force_update    = true
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  read_only       = false
  skip_validation = false
  url             = "abfss://${local.storage_container_provider[each.key].storage_container_name}@${local.storage_container_provider[each.key].storage_account_name}.dfs.core.windows.net/"
}

resource "databricks_external_location" "external_location_raw" {
  name = "${local.prefix}-raw"

  comment         = "Default raw storage layer for '${var.app_name}' data application."
  credential_name = one(databricks_storage_credential.storage_credential[*].name)
  fallback        = false
  force_destroy   = true
  force_update    = true
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  read_only       = false
  skip_validation = false
  url             = "abfss://${local.storage_container_raw.storage_container_name}@${local.storage_container_raw.storage_account_name}.dfs.core.windows.net/"
}

resource "databricks_external_location" "external_location_enriched" {
  name = "${local.prefix}-enr"

  comment         = "Default enriched storage layer for '${var.app_name}' data application."
  credential_name = one(databricks_storage_credential.storage_credential[*].name)
  fallback        = false
  force_destroy   = true
  force_update    = true
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  read_only       = false
  skip_validation = false
  url             = "abfss://${local.storage_container_enriched.storage_container_name}@${local.storage_container_enriched.storage_account_name}.dfs.core.windows.net/"
}

resource "databricks_external_location" "external_location_curated" {
  name = "${local.prefix}-cur"

  comment         = "Default curated storage layer for '${var.app_name}' data application."
  credential_name = one(databricks_storage_credential.storage_credential[*].name)
  fallback        = false
  force_destroy   = true
  force_update    = true
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  read_only       = false
  skip_validation = false
  url             = "abfss://${local.storage_container_curated.storage_container_name}@${local.storage_container_curated.storage_account_name}.dfs.core.windows.net/"
}

resource "databricks_external_location" "external_location_workspace" {
  name = "${local.prefix}-wks"

  comment         = "Default workspace storage layer for '${var.app_name}' data application."
  credential_name = one(databricks_storage_credential.storage_credential[*].name)
  fallback        = false
  force_destroy   = true
  force_update    = true
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  read_only       = false
  skip_validation = false
  url             = "abfss://${local.storage_container_workspace.storage_container_name}@${local.storage_container_workspace.storage_account_name}.dfs.core.windows.net/"
}
