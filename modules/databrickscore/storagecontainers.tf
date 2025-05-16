resource "azurerm_storage_container" "storage_container_engineering_default" {
  storage_account_id = var.storage_account_ids.raw
  name               = "${local.prefix}-engnrng-default"

  container_access_type             = "private"
  default_encryption_scope          = null
  encryption_scope_override_enabled = null
  metadata                          = var.tags

  depends_on = [
    var.storage_dependencies,
  ]
}
