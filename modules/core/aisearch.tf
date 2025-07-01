module "ai_search" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/aisearch?ref=main"
  providers = {
    azurerm = azurerm
    time    = time
  }

  count = var.ai_foundry_account_details.enabled ? 1 : 0

  location                                    = var.location
  resource_group_name                         = azurerm_resource_group.resource_group_ai.name
  tags                                        = local.tags
  search_service_name                         = "${local.prefix}-srch001"
  search_service_sku                          = var.aifoundry_details.search_service.sku
  search_service_semantic_search_sku          = var.aifoundry_details.search_service.semantic_search_sku
  search_service_local_authentication_enabled = false
  search_service_authentication_failure_mode  = null
  search_service_hosting_mode                 = "default"
  search_service_partition_count              = var.aifoundry_details.search_service.partition_count
  search_service_replica_count                = var.aifoundry_details.search_service.replica_count
  search_service_shared_private_links         = local.search_service_shared_private_links
  diagnostics_configurations                  = var.diagnostics_configurations
  subnet_id                                   = var.subnet_id_consumption
  connectivity_delay_in_seconds               = var.connectivity_delay_in_seconds
  private_dns_zone_id_search_service          = var.private_dns_zone_id_search_service
  customer_managed_key                        = var.customer_managed_key
}
