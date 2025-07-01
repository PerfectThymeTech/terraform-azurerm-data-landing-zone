module "storage_account_provider" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/storage?ref=main"
  providers = {
    azurerm = azurerm
    time    = time
  }

  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_storage.name
  tags                = var.tags

  storage_account_name                            = replace("${local.prefix}-stg-ext", "-", "")
  storage_access_tier                             = "Hot"
  storage_account_type                            = "StorageV2"
  storage_account_tier                            = "Standard"
  storage_account_replication_type                = var.zone_redundancy_enabled ? (var.geo_redundancy_storage_enabled.provider ? "GZRS" : "ZRS") : (var.geo_redundancy_storage_enabled.provider ? "GRS" : "LRS")
  storage_blob_change_feed_enabled                = false
  storage_blob_container_delete_retention_in_days = 30
  storage_blob_delete_retention_in_days           = 30
  storage_blob_cors_rules                         = local.storage_blob_cors_rules
  storage_blob_last_access_time_enabled           = false
  storage_blob_versioning_enabled                 = false
  storage_is_hns_enabled                          = true
  storage_network_bypass                          = ["AzureServices"]
  storage_network_private_link_access             = local.storage_network_private_link_access
  storage_public_network_access_enabled           = true
  storage_nfsv3_enabled                           = false
  storage_sftp_enabled                            = false
  storage_shared_access_key_enabled               = false
  storage_container_names                         = []
  storage_static_website                          = []
  diagnostics_configurations                      = var.diagnostics_configurations
  subnet_id                                       = var.subnet_id_storage
  connectivity_delay_in_seconds                   = var.connectivity_delay_in_seconds
  private_endpoint_subresource_names              = ["blob", "dfs", "queue", ]
  private_dns_zone_id_blob                        = var.private_dns_zone_id_blob
  private_dns_zone_id_file                        = ""
  private_dns_zone_id_table                       = ""
  private_dns_zone_id_queue                       = var.private_dns_zone_id_queue
  private_dns_zone_id_web                         = ""
  private_dns_zone_id_dfs                         = var.private_dns_zone_id_dfs
  customer_managed_key                            = var.customer_managed_key
}

module "storage_account_raw" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/storage?ref=main"
  providers = {
    azurerm = azurerm
    time    = time
  }

  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_storage.name
  tags                = var.tags

  storage_account_name                            = replace("${local.prefix}-stg-raw", "-", "")
  storage_access_tier                             = "Hot"
  storage_account_type                            = "StorageV2"
  storage_account_tier                            = "Standard"
  storage_account_replication_type                = var.zone_redundancy_enabled ? (var.geo_redundancy_storage_enabled.raw ? "GZRS" : "ZRS") : (var.geo_redundancy_storage_enabled.raw ? "GRS" : "LRS")
  storage_blob_change_feed_enabled                = false
  storage_blob_container_delete_retention_in_days = 30
  storage_blob_delete_retention_in_days           = 30
  storage_blob_cors_rules                         = local.storage_blob_cors_rules
  storage_blob_last_access_time_enabled           = false
  storage_blob_versioning_enabled                 = false
  storage_is_hns_enabled                          = true
  storage_network_bypass                          = ["AzureServices"]
  storage_network_private_link_access             = local.storage_network_private_link_access
  storage_public_network_access_enabled           = true
  storage_nfsv3_enabled                           = false
  storage_sftp_enabled                            = false
  storage_shared_access_key_enabled               = false
  storage_container_names                         = []
  storage_static_website                          = []
  diagnostics_configurations                      = var.diagnostics_configurations
  subnet_id                                       = var.subnet_id_storage
  connectivity_delay_in_seconds                   = var.connectivity_delay_in_seconds
  private_endpoint_subresource_names              = ["blob", "dfs", "queue", ]
  private_dns_zone_id_blob                        = var.private_dns_zone_id_blob
  private_dns_zone_id_file                        = ""
  private_dns_zone_id_table                       = ""
  private_dns_zone_id_queue                       = var.private_dns_zone_id_queue
  private_dns_zone_id_web                         = ""
  private_dns_zone_id_dfs                         = var.private_dns_zone_id_dfs
  customer_managed_key                            = var.customer_managed_key
}

module "storage_account_enriched" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/storage?ref=main"
  providers = {
    azurerm = azurerm
    time    = time
  }

  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_storage.name
  tags                = var.tags

  storage_account_name                            = replace("${local.prefix}-stg-enr", "-", "")
  storage_access_tier                             = "Hot"
  storage_account_type                            = "StorageV2"
  storage_account_tier                            = "Standard"
  storage_account_replication_type                = var.zone_redundancy_enabled ? (var.geo_redundancy_storage_enabled.enriched ? "GZRS" : "ZRS") : (var.geo_redundancy_storage_enabled.enriched ? "GRS" : "LRS")
  storage_blob_change_feed_enabled                = false
  storage_blob_container_delete_retention_in_days = 30
  storage_blob_delete_retention_in_days           = 30
  storage_blob_cors_rules                         = local.storage_blob_cors_rules
  storage_blob_last_access_time_enabled           = false
  storage_blob_versioning_enabled                 = false
  storage_is_hns_enabled                          = true
  storage_network_bypass                          = ["AzureServices"]
  storage_network_private_link_access             = local.storage_network_private_link_access
  storage_public_network_access_enabled           = true
  storage_nfsv3_enabled                           = false
  storage_sftp_enabled                            = false
  storage_shared_access_key_enabled               = false
  storage_container_names                         = []
  storage_static_website                          = []
  diagnostics_configurations                      = var.diagnostics_configurations
  subnet_id                                       = var.subnet_id_storage
  connectivity_delay_in_seconds                   = var.connectivity_delay_in_seconds
  private_endpoint_subresource_names              = ["blob", "dfs", "queue", ]
  private_dns_zone_id_blob                        = var.private_dns_zone_id_blob
  private_dns_zone_id_file                        = ""
  private_dns_zone_id_table                       = ""
  private_dns_zone_id_queue                       = var.private_dns_zone_id_queue
  private_dns_zone_id_web                         = ""
  private_dns_zone_id_dfs                         = var.private_dns_zone_id_dfs
  customer_managed_key                            = var.customer_managed_key
}

module "storage_account_curated" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/storage?ref=main"
  providers = {
    azurerm = azurerm
    time    = time
  }

  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_storage.name
  tags                = var.tags

  storage_account_name                            = replace("${local.prefix}-stg-cur", "-", "")
  storage_access_tier                             = "Hot"
  storage_account_type                            = "StorageV2"
  storage_account_tier                            = "Standard"
  storage_account_replication_type                = var.zone_redundancy_enabled ? (var.geo_redundancy_storage_enabled.curated ? "GZRS" : "ZRS") : (var.geo_redundancy_storage_enabled.curated ? "GRS" : "LRS")
  storage_blob_change_feed_enabled                = false
  storage_blob_container_delete_retention_in_days = 30
  storage_blob_delete_retention_in_days           = 30
  storage_blob_cors_rules                         = local.storage_blob_cors_rules
  storage_blob_last_access_time_enabled           = false
  storage_blob_versioning_enabled                 = false
  storage_is_hns_enabled                          = true
  storage_network_bypass                          = ["AzureServices"]
  storage_network_private_link_access             = local.storage_network_private_link_access
  storage_public_network_access_enabled           = true
  storage_nfsv3_enabled                           = false
  storage_sftp_enabled                            = false
  storage_shared_access_key_enabled               = false
  storage_container_names                         = []
  storage_static_website                          = []
  diagnostics_configurations                      = var.diagnostics_configurations
  subnet_id                                       = var.subnet_id_storage
  connectivity_delay_in_seconds                   = var.connectivity_delay_in_seconds
  private_endpoint_subresource_names              = ["blob", "dfs", "queue", ]
  private_dns_zone_id_blob                        = var.private_dns_zone_id_blob
  private_dns_zone_id_file                        = ""
  private_dns_zone_id_table                       = ""
  private_dns_zone_id_queue                       = var.private_dns_zone_id_queue
  private_dns_zone_id_web                         = ""
  private_dns_zone_id_dfs                         = var.private_dns_zone_id_dfs
  customer_managed_key                            = var.customer_managed_key
}

module "storage_account_workspace" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/storage?ref=main"
  providers = {
    azurerm = azurerm
    time    = time
  }

  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_storage.name
  tags                = var.tags

  storage_account_name                            = replace("${local.prefix}-stg-wks", "-", "")
  storage_access_tier                             = "Hot"
  storage_account_type                            = "StorageV2"
  storage_account_tier                            = "Standard"
  storage_account_replication_type                = var.zone_redundancy_enabled ? (var.geo_redundancy_storage_enabled.workspace ? "GZRS" : "ZRS") : (var.geo_redundancy_storage_enabled.workspace ? "GRS" : "LRS")
  storage_blob_change_feed_enabled                = false
  storage_blob_container_delete_retention_in_days = 30
  storage_blob_delete_retention_in_days           = 30
  storage_blob_cors_rules                         = local.storage_blob_cors_rules
  storage_blob_last_access_time_enabled           = false
  storage_blob_versioning_enabled                 = false
  storage_is_hns_enabled                          = true
  storage_network_bypass                          = ["AzureServices"]
  storage_network_private_link_access             = local.storage_network_private_link_access
  storage_public_network_access_enabled           = true
  storage_nfsv3_enabled                           = false
  storage_sftp_enabled                            = false
  storage_shared_access_key_enabled               = false
  storage_container_names                         = []
  storage_static_website                          = []
  diagnostics_configurations                      = var.diagnostics_configurations
  subnet_id                                       = var.subnet_id_storage
  connectivity_delay_in_seconds                   = var.connectivity_delay_in_seconds
  private_endpoint_subresource_names              = ["blob", "dfs", "queue", ]
  private_dns_zone_id_blob                        = var.private_dns_zone_id_blob
  private_dns_zone_id_file                        = ""
  private_dns_zone_id_table                       = ""
  private_dns_zone_id_queue                       = var.private_dns_zone_id_queue
  private_dns_zone_id_web                         = ""
  private_dns_zone_id_dfs                         = var.private_dns_zone_id_dfs
  customer_managed_key                            = var.customer_managed_key
}

module "storage_account_aifoundry" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/storage?ref=main"
  providers = {
    azurerm = azurerm
    time    = time
  }

  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_ai.name
  tags                = var.tags

  storage_account_name                            = replace("${local.prefix}-stg-aif", "-", "")
  storage_access_tier                             = "Hot"
  storage_account_type                            = "StorageV2"
  storage_account_tier                            = "Standard"
  storage_account_replication_type                = var.zone_redundancy_enabled ? "ZRS" : "LRS"
  storage_blob_change_feed_enabled                = false
  storage_blob_container_delete_retention_in_days = 30
  storage_blob_delete_retention_in_days           = 30
  storage_blob_cors_rules                         = {}
  storage_blob_last_access_time_enabled           = false
  storage_blob_versioning_enabled                 = false
  storage_is_hns_enabled                          = false
  storage_network_bypass                          = ["AzureServices"]
  storage_network_private_link_access             = local.storage_network_private_link_access
  storage_public_network_access_enabled           = true
  storage_nfsv3_enabled                           = false
  storage_sftp_enabled                            = false
  storage_shared_access_key_enabled               = false
  storage_container_names                         = []
  storage_static_website                          = []
  diagnostics_configurations                      = var.diagnostics_configurations
  subnet_id                                       = var.subnet_id_storage
  connectivity_delay_in_seconds                   = var.connectivity_delay_in_seconds
  private_endpoint_subresource_names              = ["blob", ]
  private_dns_zone_id_blob                        = var.private_dns_zone_id_blob
  private_dns_zone_id_file                        = ""
  private_dns_zone_id_table                       = ""
  private_dns_zone_id_queue                       = ""
  private_dns_zone_id_web                         = ""
  private_dns_zone_id_dfs                         = ""
  customer_managed_key                            = var.customer_managed_key
}
