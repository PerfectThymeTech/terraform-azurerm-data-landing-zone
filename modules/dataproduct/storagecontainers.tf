data "azurerm_storage_account" "datalake_raw" {
  name                = local.datalake_raw.name
  resource_group_name = local.datalake_raw.resource_group_name
}

resource "azurerm_storage_container" "container_raw" {
  count                = var.containers_enabled.raw ? 1 : 0
  name                 = lower(replace(local.names.container_raw, "-", ""))
  storage_account_name = data.azurerm_storage_account.datalake_raw.name

  container_access_type = "private"

  depends_on = [
    var.dependencies_datalake
  ]
}

data "azurerm_storage_account" "datalake_enriched" {
  name                = local.datalake_enriched.name
  resource_group_name = local.datalake_enriched.resource_group_name
}

resource "azurerm_storage_container" "container_enriched" {
  count                = var.containers_enabled.enriched ? 1 : 0
  name                 = lower(replace(local.names.container_enriched, "-", ""))
  storage_account_name = data.azurerm_storage_account.datalake_enriched.name

  container_access_type = "private"

  depends_on = [
    var.dependencies_datalake
  ]
}

data "azurerm_storage_account" "datalake_curated" {
  name                = local.datalake_curated.name
  resource_group_name = local.datalake_curated.resource_group_name
}

resource "azurerm_storage_container" "container_curated" {
  count                = var.containers_enabled.curated ? 1 : 0
  name                 = lower(replace(local.names.container_curated, "-", ""))
  storage_account_name = data.azurerm_storage_account.datalake_curated.name

  container_access_type = "private"

  depends_on = [
    var.dependencies_datalake
  ]
}

data "azurerm_storage_account" "datalake_workspace" {
  name                = local.datalake_workspace.name
  resource_group_name = local.datalake_workspace.resource_group_name
}

resource "azurerm_storage_container" "container_workspace" {
  count                = var.containers_enabled.workspace ? 1 : 0
  name                 = lower(replace(local.names.container_workspace, "-", ""))
  storage_account_name = data.azurerm_storage_account.datalake_workspace.name

  container_access_type = "private"

  depends_on = [
    var.dependencies_datalake
  ]
}
