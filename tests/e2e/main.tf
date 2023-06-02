module "data_landing_zone" {
  source = "../../"
  providers = {
    azurerm            = azurerm
    azapi              = azapi
    azuread            = azuread
    databricks.account = databricks.account
  }

  location                                = var.location
  environment                             = var.environment
  prefix                                  = var.prefix
  tags                                    = var.tags
  admin_username                          = var.admin_username
  vnet_id                                 = var.vnet_id
  nsg_id                                  = var.nsg_id
  route_table_id                          = var.route_table_id
  subnet_cidr_ranges                      = var.subnet_cidr_ranges
  enable_databricks_auth_private_endpoint = var.enable_databricks_auth_private_endpoint
  purview_id                              = var.purview_id
  unity_metastore_name                    = var.unity_metastore_name
  unity_metastore_id                      = var.unity_metastore_id
  databricks_admin_groupname              = var.databricks_admin_groupname
  databricks_cluster_policies             = local.databricks_cluster_policies
  data_platform_subscription_ids          = var.data_platform_subscription_ids
  data_product_library_path               = local.data_product_library_path
  data_product_template_file_variables    = var.data_product_template_file_variables
  private_dns_zone_id_blob                = var.private_dns_zone_id_blob
  private_dns_zone_id_dfs                 = var.private_dns_zone_id_dfs
  private_dns_zone_id_queue               = var.private_dns_zone_id_queue
  private_dns_zone_id_table               = var.private_dns_zone_id_table
  private_dns_zone_id_key_vault           = var.private_dns_zone_id_key_vault
  private_dns_zone_id_data_factory        = var.private_dns_zone_id_data_factory
  private_dns_zone_id_data_factory_portal = var.private_dns_zone_id_data_factory_portal
  private_dns_zone_id_databricks          = var.private_dns_zone_id_databricks
}
