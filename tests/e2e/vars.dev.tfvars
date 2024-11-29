# General variables
location    = "northeurope"
environment = "int"
prefix      = "mydlz01"
tags        = {}

# Service
data_platform_subscription_ids           = []
data_application_library_path            = ""
data_application_file_variables          = {}
databricks_cluster_policy_library_path   = ""
databricks_cluster_policy_file_variables = {}

# HA/DR variables
zone_redundancy_enabled = false

# Network variables
vnet_id        = "/subscriptions/1fdab118-1638-419a-8b12-06c9543714a0/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/virtualNetworks/spoke-ptt-dev-vnet001"
nsg_id         = "/subscriptions/1fdab118-1638-419a-8b12-06c9543714a0/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/networkSecurityGroups/ptt-dev-default-nsg001"
route_table_id = "/subscriptions/1fdab118-1638-419a-8b12-06c9543714a0/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/routeTables/ptt-dev-default-rt001"
subnet_cidr_ranges = {
  storage_subnet                        = "10.2.0.0/27"
  fabric_subnet                         = "10.2.0.32/27"
  databricks_consumption_private_subnet = "10.2.0.64/26"
  databricks_consumption_public_subnet  = "10.2.0.128/26"
}

# DNS variables
private_dns_zone_id_blob       = "/subscriptions/8f171ff9-2b5b-4f0f-aed5-7fa360a1d094/resourceGroups/mycrp-prd-global-dns/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
private_dns_zone_id_dfs        = "/subscriptions/8f171ff9-2b5b-4f0f-aed5-7fa360a1d094/resourceGroups/mycrp-prd-global-dns/providers/Microsoft.Network/privateDnsZones/privatelink.dfs.core.windows.net"
private_dns_zone_id_vault      = "/subscriptions/8f171ff9-2b5b-4f0f-aed5-7fa360a1d094/resourceGroups/mycrp-prd-global-dns/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
private_dns_zone_id_databricks = "/subscriptions/8f171ff9-2b5b-4f0f-aed5-7fa360a1d094/resourceGroups/mycrp-prd-global-dns/providers/Microsoft.Network/privateDnsZones/privatelink.azuredatabricks.net"

# Customer-managed key variables
customer_managed_key = null
