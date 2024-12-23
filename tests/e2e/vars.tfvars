# General variables
location    = "northeurope"
environment = "int"
prefix      = "mydlz01"
tags        = {}

# Service
data_platform_subscription_ids           = []
data_application_library_path            = "./data-applications"
data_application_file_variables          = {}
databricks_cluster_policy_library_path   = "./databricks-cluster-policies"
databricks_cluster_policy_file_variables = {}
databricks_account_id                    = "515f13c1-53bb-48fb-a2c9-75e3f5d943f5"

# HA/DR variables
zone_redundancy_enabled = false

# Network variables
vnet_id        = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/virtualNetworks/spoke-ptt-dev-vnet001"
nsg_id         = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/networkSecurityGroups/ptt-dev-default-nsg001"
route_table_id = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/routeTables/ptt-dev-default-rt001"
subnet_cidr_ranges = {
  storage_subnet                        = "10.2.0.0/27"
  fabric_subnet                         = "10.2.0.32/27"
  databricks_engineering_private_subnet = "10.2.0.64/26"
  databricks_engineering_public_subnet  = "10.2.0.128/26"
  databricks_consumption_private_subnet = "10.2.0.192/26"
  databricks_consumption_public_subnet  = "10.2.1.0/26"
}

# DNS variables
private_dns_zone_id_blob       = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
private_dns_zone_id_dfs        = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.dfs.core.windows.net"
private_dns_zone_id_vault      = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
private_dns_zone_id_databricks = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.azuredatabricks.net"

# Customer-managed key variables
customer_managed_key = null
