resource "azurerm_storage_queue" "storage_queue_provider" {
  for_each = var.data_provider_details

  storage_account_name = reverse(split("/", var.storage_account_ids.provider))[0]
  name                 = "${local.prefix}-pro-${lower(each.key)}"
  metadata             = local.tags

  depends_on = [
    var.storage_dependencies,
  ]
}

resource "azurerm_storage_queue" "storage_queue_raw" {
  storage_account_name = reverse(split("/", var.storage_account_ids.raw))[0]
  name                 = "${local.prefix}-raw"
  metadata             = local.tags

  depends_on = [
    var.storage_dependencies,
  ]
}

resource "azurerm_storage_queue" "storage_queue_enriched" {
  storage_account_name = reverse(split("/", var.storage_account_ids.enriched))[0]
  name                 = "${local.prefix}-enriched"
  metadata             = local.tags

  depends_on = [
    var.storage_dependencies,
  ]
}

resource "azurerm_storage_queue" "storage_queue_curated" {
  storage_account_name = reverse(split("/", var.storage_account_ids.curated))[0]
  name                 = "${local.prefix}-curated"
  metadata             = local.tags

  depends_on = [
    var.storage_dependencies,
  ]
}

resource "azurerm_storage_queue" "storage_queue_workspace" {
  storage_account_name = reverse(split("/", var.storage_account_ids.workspace))[0]
  name                 = "${local.prefix}-workspace"
  metadata             = local.tags

  depends_on = [
    var.storage_dependencies,
  ]
}
