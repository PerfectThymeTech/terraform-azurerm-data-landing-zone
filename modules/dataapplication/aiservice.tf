module "ai_service" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/aiservice?ref=main"
  providers = {
    azurerm = azurerm
    azapi   = azapi
    time    = time
  }

  for_each = var.ai_services

  location                                                = var.location
  resource_group_name                                     = azurerm_resource_group.resource_group_app.name
  tags                                                    = var.tags
  cognitive_account_name                                  = "${local.prefix}-${each.key}-kv001"
  cognitive_account_kind                                  = each.value.kind
  cognitive_account_sku                                   = each.value.sku
  cognitive_account_firewall_bypass_azure_services        = contains(local.ai_service_kind_firewall_bypass_azure_services_list, each.value.kind) ? true : false
  cognitive_account_outbound_network_access_restricted    = true
  cognitive_account_outbound_network_access_allowed_fqdns = []
  cognitive_account_local_auth_enabled                    = false
  cognitive_account_deployments                           = {}
  diagnostics_configurations                              = var.diagnostics_configurations
  subnet_id                                               = var.subnet_id_app
  connectivity_delay_in_seconds                           = var.connectivity_delay_in_seconds
  private_dns_zone_id_cognitive_account                   = var.private_dns_zone_id_cognitive_account
  customer_managed_key                                    = var.customer_managed_key
}
