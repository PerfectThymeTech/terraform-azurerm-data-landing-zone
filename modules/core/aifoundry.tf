module "ai_foundry_account" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/aifoundry?ref=marvinbuss/ai_foundry"
  providers = {
    azurerm = azurerm
    time    = time
  }

  count = var.aifoundry_details.enabled ? 1 : 0

  location                                          = var.location
  resource_group_name                               = azurerm_resource_group.resource_group_ai.name
  tags                                              = local.tags
  ai_services_name                                  = "${local.prefix}-aif001"
  ai_services_sku                                   = "S0"
  ai_services_firewall_bypass_azure_services        = true
  ai_services_outbound_network_access_restricted    = true
  ai_services_outbound_network_access_allowed_fqdns = []
  ai_services_local_auth_enabled                    = false
  ai_services_projects                              = {}
  ai_services_cosmosdb_accounts                     = {}
  ai_services_storage_accounts                      = {}
  ai_services_aisearch_accounts                     = {}
  ai_services_openai_accounts                       = {}
  ai_services_connections_account                   = {}
  ai_services_deployments                           = {}
  diagnostics_configurations                        = []
  subnet_id                                         = var.subnet_id_consumption
  subnet_id_capability_hosts                        = var.subnet_id_aifoundry
  connectivity_delay_in_seconds                     = var.connectivity_delay_in_seconds
  private_dns_zone_id_ai_services                   = var.private_dns_zone_id_ai_services
  private_dns_zone_id_cognitive_account             = var.private_dns_zone_id_cognitive_account
  private_dns_zone_id_open_ai                       = var.private_dns_zone_id_open_ai
  customer_managed_key                              = null
}
