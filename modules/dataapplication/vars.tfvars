location    = "northeurope"
environment = "dev"
prefix      = "ptt"
tags        = {}

app_name = "tst001"
storage_account_ids = {
  curated   = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-core-dev-storage-rg/providers/Microsoft.Storage/storageAccounts/pttcoredevstgcur"
  enriched  = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-core-dev-storage-rg/providers/Microsoft.Storage/storageAccounts/pttcoredevstgenr"
  external  = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-core-dev-storage-rg/providers/Microsoft.Storage/storageAccounts/pttcoredevstgext"
  raw       = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-core-dev-storage-rg/providers/Microsoft.Storage/storageAccounts/pttcoredevstgraw"
  workspace = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-core-dev-storage-rg/providers/Microsoft.Storage/storageAccounts/pttcoredevstgwks"
}

zone_redundancy_enabled = true

diagnostics_configurations = []
alerting = {
  categories = {
    service_health = {
      incident_level = 3
      severity       = "Critical"
    }
  }
}

vnet_id                       = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/virtualNetworks/spoke-ptt-dev-vnet001"
subnet_id_app                 = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/virtualNetworks/spoke-ptt-dev-vnet001/subnets/PrivateEndpointSubnet-app001"
subnet_id_databricks_private  = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/virtualNetworks/spoke-ptt-dev-vnet001/subnets/DatabricksPrivateSubnet-app001"
subnet_id_databricks_public   = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/virtualNetworks/spoke-ptt-dev-vnet001/subnets/DatabricksPublicSubnet-app001"
connectivity_delay_in_seconds = 20

private_dns_zone_id_blob       = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
private_dns_zone_id_dfs        = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.dfs.core.windows.net"
private_dns_zone_id_databricks = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.azuredatabricks.net"
private_dns_zone_id_vault      = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"

customer_managed_key = null
