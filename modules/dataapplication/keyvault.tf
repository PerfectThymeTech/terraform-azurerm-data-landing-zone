module "key_vault" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/keyvault?ref=main"
  providers = {
    azurerm = azurerm
    time    = time
  }

  location                             = var.location
  resource_group_name                  = azurerm_resource_group.resource_group_app.name
  tags                                 = local.tags
  key_vault_name                       = "${local.prefix}-kv001"
  key_vault_sku_name                   = "standard"
  key_vault_soft_delete_retention_days = 7
  diagnostics_configurations           = var.diagnostics_configurations
  subnet_id                            = var.subnet_id_app
  connectivity_delay_in_seconds        = var.connectivity_delay_in_seconds
  private_dns_zone_id_vault            = var.private_dns_zone_id_vault
}
