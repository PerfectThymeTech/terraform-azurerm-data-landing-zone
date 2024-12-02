resource "databricks_external_location" "external_location_external" {
  count = var.databricks_access_connector_id != "" && var.storage_container_ids.external != "" ? 1 : 0

  name = "${local.prefix}-ext"

  comment         = "Default external storage layer for '${var.app_name}' data application."
  credential_name = one(databricks_storage_credential.storage_credential[*].name)
  force_destroy   = false
  force_update    = false
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  read_only       = false
  skip_validation = false
  url             = "abfss://${local.storage_container_external.storage_container_name}@${local.storage_container_external.storage_account_name}.dfs.core.windows.net/"
}

resource "databricks_external_location" "external_location_raw" {
  count = var.databricks_access_connector_id != "" && var.storage_container_ids.raw != "" ? 1 : 0

  name = "${local.prefix}-raw"

  comment         = "Default raw storage layer for '${var.app_name}' data application."
  credential_name = one(databricks_storage_credential.storage_credential[*].name)
  force_destroy   = false
  force_update    = false
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  read_only       = false
  skip_validation = false
  url             = "abfss://${local.storage_container_raw.storage_container_name}@${local.storage_container_raw.storage_account_name}.dfs.core.windows.net/"
}

resource "databricks_external_location" "external_location_enriched" {
  count = var.databricks_access_connector_id != "" && var.storage_container_ids.enriched != "" ? 1 : 0

  name = "${local.prefix}-enr"

  comment         = "Default enriched storage layer for '${var.app_name}' data application."
  credential_name = one(databricks_storage_credential.storage_credential[*].name)
  force_destroy   = false
  force_update    = false
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  read_only       = false
  skip_validation = false
  url             = "abfss://${local.storage_container_enriched.storage_container_name}@${local.storage_container_enriched.storage_account_name}.dfs.core.windows.net/"
}

resource "databricks_external_location" "external_location_curated" {
  count = var.databricks_access_connector_id != "" && var.storage_container_ids.curated != "" ? 1 : 0

  name = "${local.prefix}-cur"

  comment         = "Default curated storage layer for '${var.app_name}' data application."
  credential_name = one(databricks_storage_credential.storage_credential[*].name)
  force_destroy   = false
  force_update    = false
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  read_only       = false
  skip_validation = false
  url             = "abfss://${local.storage_container_curated.storage_container_name}@${local.storage_container_curated.storage_account_name}.dfs.core.windows.net/"
}

resource "databricks_external_location" "external_location_workspace" {
  count = var.databricks_access_connector_id != "" && var.storage_container_ids.workspace != "" ? 1 : 0

  name = "${local.prefix}-wks"

  comment         = "Default workspace storage layer for '${var.app_name}' data application."
  credential_name = one(databricks_storage_credential.storage_credential[*].name)
  force_destroy   = false
  force_update    = false
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  read_only       = false
  skip_validation = false
  url             = "abfss://${local.storage_container_workspace.storage_container_name}@${local.storage_container_workspace.storage_account_name}.dfs.core.windows.net/"
}
