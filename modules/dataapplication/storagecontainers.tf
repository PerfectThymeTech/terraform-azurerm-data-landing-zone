resource "azurerm_storage_container" "storage_container_external" {
  storage_account_id = var.storage_account_ids.external
  name               = "${local.prefix}-ext"

  container_access_type             = "private"
  default_encryption_scope          = null
  encryption_scope_override_enabled = null
  metadata = {
    app_name    = var.app_name
    environment = var.environment
  }
}

resource "azurerm_storage_container" "storage_container_raw" {
  storage_account_id = var.storage_account_ids.raw
  name               = "${local.prefix}-raw"

  container_access_type             = "private"
  default_encryption_scope          = null
  encryption_scope_override_enabled = null
  metadata = {
    app_name    = var.app_name
    environment = var.environment
  }
}

resource "azurerm_storage_container" "storage_container_enriched" {
  storage_account_id = var.storage_account_ids.enriched
  name               = "${local.prefix}-enr"

  container_access_type             = "private"
  default_encryption_scope          = null
  encryption_scope_override_enabled = null
  metadata = {
    app_name    = var.app_name
    environment = var.environment
  }
}

resource "azurerm_storage_container" "storage_container_curated" {
  storage_account_id = var.storage_account_ids.curated
  name               = "${local.prefix}-cur"

  container_access_type             = "private"
  default_encryption_scope          = null
  encryption_scope_override_enabled = null
  metadata = {
    app_name    = var.app_name
    environment = var.environment
  }
}

resource "azurerm_storage_container" "storage_container_workspace" {
  storage_account_id = var.storage_account_ids.workspace
  name               = "${local.prefix}-wks"

  container_access_type             = "private"
  default_encryption_scope          = null
  encryption_scope_override_enabled = null
  metadata = {
    app_name    = var.app_name
    environment = var.environment
  }
}
