# General variables
location    = "northeurope"
environment = "int"
prefix      = "mydlz01"
tags        = {}

# Service
trusted_subscription_ids                    = ["1fdab118-1638-419a-8b12-06c9543714a0"]
trusted_fabric_workspace_ids                = ["898a945c-dff2-4f92-923b-626d7be08c32"]
data_application_library_path               = "./data-applications"
data_application_file_variables             = {}
databricks_cluster_policy_library_path      = "./databricks-cluster-policies"
databricks_cluster_policy_file_variables    = {}
databricks_account_id                       = "515f13c1-53bb-48fb-a2c9-75e3f5d943f5"
databricks_network_connectivity_config_name = "ncc-northeurope-test"
databricks_network_policy_details = {
  allowed_internet_destinations = [
    {
      destination               = "microsoft.com"
      internet_destination_type = "DNS_NAME"
    }
  ]
  allowed_storage_destinations = [
    {
      azure_storage_account    = "mbprj004intstg001"
      storage_destination_type = "blob"
    }
  ]
}
databricks_workspace_consumption_enabled         = false
databricks_compliance_security_profile_standards = ["PCI_DSS"]
databricks_workspace_binding_catalog             = {}
fabric_capacity_details = {
  enabled      = false
  admin_emails = []
  sku          = "F2"
}

# HA/DR variables
zone_redundancy_enabled = false

# Logging variables
log_analytics_workspace_id = ""

# Identity variables
service_principal_name_terraform_plan = "ptt-dev-uai001-dlz-tfplan"

# Network variables
vnet_id        = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/virtualNetworks/spoke-ptt-dev-vnet001"
nsg_id         = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/networkSecurityGroups/ptt-dev-default-nsg001"
route_table_id = "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/routeTables/ptt-dev-default-rt001"
subnet_cidr_ranges = {
  storage_subnet                        = "10.2.0.0/27"
  consumption_subnet                    = "10.2.0.32/28"
  fabric_subnet                         = "10.2.0.48/28"
  databricks_engineering_private_subnet = "10.2.0.64/26"
  databricks_engineering_public_subnet  = "10.2.0.128/26"
  # databricks_consumption_private_subnet = "10.2.0.192/26"
  # databricks_consumption_public_subnet  = "10.2.1.0/26"
}

# DNS variables
private_dns_zone_id_blob              = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
private_dns_zone_id_dfs               = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.dfs.core.windows.net"
private_dns_zone_id_queue             = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.queue.core.windows.net"
private_dns_zone_id_vault             = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
private_dns_zone_id_databricks        = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.azuredatabricks.net"
private_dns_zone_id_cognitive_account = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.cognitiveservices.azure.com"
private_dns_zone_id_open_ai           = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.openai.azure.com"
private_dns_zone_id_data_factory      = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.datafactory.azure.net"
private_dns_zone_id_search_service    = "/subscriptions/e82c5267-9dc4-4f45-ac13-abdd5e130d27/resourceGroups/ptt-dev-privatedns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.search.windows.net"

# Customer-managed key variables
customer_managed_key = null
