module "cosmos_db" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/cosmosdb?ref=main"
  providers = {
    azurerm = azurerm
    time    = time
  }

  count = var.ai_foundry_account_details.enabled ? 1 : 0

  location                                            = var.location
  resource_group_name                                 = azurerm_resource_group.resource_group_ai.name
  tags                                                = local.tags
  cosmosdb_account_name                               = "${local.prefix}-csms001"
  cosmosdb_account_access_key_metadata_writes_enabled = false
  cosmosdb_account_analytical_storage_enabled         = false
  cosmosdb_account_automatic_failover_enabled         = false
  cosmosdb_account_backup = {
    type                = "Continuous"
    tier                = "Continuous7Days"
    storage_redundancy  = null
    retention_in_hours  = null
    interval_in_minutes = null
  }
  cosmosdb_account_capabilities                    = []
  cosmosdb_account_capacity_total_throughput_limit = -1
  cosmosdb_account_consistency_policy = {
    consistency_level       = var.aifoundry_details.cosmos_db.consistency_level
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }
  cosmosdb_account_cors_rules            = {}
  cosmosdb_account_default_identity_type = null
  cosmosdb_account_geo_location = [
    {
      location          = var.location
      failover_priority = 0
      zone_redundant    = false
    }
  ]
  cosmosdb_account_kind                          = "GlobalDocumentDB"
  cosmosdb_account_mongo_server_version          = null
  cosmosdb_account_local_authentication_disabled = true
  cosmosdb_account_partition_merge_enabled       = false
  diagnostics_configurations                     = var.diagnostics_configurations
  subnet_id                                      = var.subnet_id_consumption
  connectivity_delay_in_seconds                  = var.connectivity_delay_in_seconds
  private_endpoint_subresource_names             = ["Sql"]
  private_dns_zone_id_cosmos_sql                 = var.private_dns_zone_id_cosmos_sql
  private_dns_zone_id_cosmos_mongodb             = ""
  private_dns_zone_id_cosmos_cassandra           = ""
  private_dns_zone_id_cosmos_gremlin             = ""
  private_dns_zone_id_cosmos_table               = ""
  private_dns_zone_id_cosmos_analytical          = ""
  private_dns_zone_id_cosmos_coordinator         = ""
  customer_managed_key                           = var.customer_managed_key
}
