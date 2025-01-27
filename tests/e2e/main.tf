module "data_landing_zone" {
  source = "../../"
  providers = {
    azurerm = azurerm
    azapi   = azapi
    azuread = azuread
    # databricks         = databricks.account
    # databricks.account = databricks.account
    null = null
    time = time
  }

  # General variables
  location    = var.location
  environment = var.environment
  prefix      = var.prefix
  tags        = var.tags

  # Service variables
  data_platform_subscription_ids           = var.data_platform_subscription_ids
  data_application_library_path            = var.data_application_library_path
  data_application_file_variables          = var.data_application_file_variables
  databricks_cluster_policy_library_path   = var.databricks_cluster_policy_library_path
  databricks_cluster_policy_file_variables = var.databricks_cluster_policy_file_variables
  databricks_account_id                    = var.databricks_account_id

  # HA/DR variables
  zone_redundancy_enabled = false

  # Network variables
  vnet_id            = var.vnet_id
  nsg_id             = var.nsg_id
  route_table_id     = var.route_table_id
  subnet_cidr_ranges = var.subnet_cidr_ranges

  # DNS variables
  private_dns_zone_id_blob       = var.private_dns_zone_id_blob
  private_dns_zone_id_dfs        = var.private_dns_zone_id_dfs
  private_dns_zone_id_vault      = var.private_dns_zone_id_vault
  private_dns_zone_id_databricks = var.private_dns_zone_id_databricks
  private_dns_zone_id_cognitive_account = var.private_dns_zone_id_cognitive_account

  # Customer-managed key variables
  customer_managed_key = var.customer_managed_key
}
