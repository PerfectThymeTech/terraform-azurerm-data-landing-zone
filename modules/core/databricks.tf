module "databricks_workspace_engineering" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/databricksworkspace?ref=main"
  providers = {
    azurerm = azurerm
    time    = time
  }

  location                                                                  = var.location
  location_private_endpoint                                                 = var.location
  resource_group_name                                                       = azurerm_resource_group.resource_group_engineering.name
  tags                                                                      = var.tags
  databricks_workspace_name                                                 = "${local.prefix}-engnrng-dbw001"
  databricks_workspace_access_connector_id                                  = module.databricks_access_connector_engineering.databricks_access_connector_id
  databricks_workspace_machine_learning_workspace_id                        = null
  databricks_workspace_virtual_network_id                                   = var.vnet_id
  databricks_workspace_private_subnet_name                                  = local.databricks_engineering_private_subnet_name
  databricks_workspace_private_subnet_network_security_group_association_id = var.subnet_id_engineering_private
  databricks_workspace_public_subnet_name                                   = local.databricks_engineering_public_subnet_name
  databricks_workspace_public_subnet_network_security_group_association_id  = var.subnet_id_engineering_public
  databricks_workspace_storage_account_sku_name                             = var.zone_redundancy_enabled ? "Standard_ZRS" : "Standard_LRS"
  databricks_workspace_browser_authentication_private_endpoint_enabled      = false
  databricks_workspace_compliance_security_profile_standards                = var.databricks_compliance_security_profile_standards
  diagnostics_configurations                                                = var.diagnostics_configurations
  subnet_id                                                                 = var.subnet_id_storage
  connectivity_delay_in_seconds                                             = var.connectivity_delay_in_seconds + 30
  private_dns_zone_id_databricks                                            = var.private_dns_zone_id_databricks
  private_dns_zone_id_blob                                                  = var.private_dns_zone_id_blob
  private_dns_zone_id_dfs                                                   = var.private_dns_zone_id_dfs
  customer_managed_key                                                      = var.customer_managed_key
}

module "databricks_workspace_consumption" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/databricksworkspace?ref=main"
  providers = {
    azurerm = azurerm
    time    = time
  }

  location                                                                  = var.location
  location_private_endpoint                                                 = var.location
  resource_group_name                                                       = azurerm_resource_group.resource_group_consumption.name
  tags                                                                      = var.tags
  databricks_workspace_name                                                 = "${local.prefix}-cnsmptn-dbw001"
  databricks_workspace_access_connector_id                                  = module.databricks_access_connector_consumption.databricks_access_connector_id
  databricks_workspace_machine_learning_workspace_id                        = null
  databricks_workspace_virtual_network_id                                   = var.vnet_id
  databricks_workspace_private_subnet_name                                  = local.databricks_consumption_private_subnet_name
  databricks_workspace_private_subnet_network_security_group_association_id = var.subnet_id_consumption_private
  databricks_workspace_public_subnet_name                                   = local.databricks_consumption_public_subnet_name
  databricks_workspace_public_subnet_network_security_group_association_id  = var.subnet_id_consumption_public
  databricks_workspace_storage_account_sku_name                             = var.zone_redundancy_enabled ? "Standard_ZRS" : "Standard_LRS"
  databricks_workspace_browser_authentication_private_endpoint_enabled      = false
  databricks_workspace_compliance_security_profile_standards                = var.databricks_compliance_security_profile_standards
  diagnostics_configurations                                                = var.diagnostics_configurations
  subnet_id                                                                 = var.subnet_id_storage
  connectivity_delay_in_seconds                                             = var.connectivity_delay_in_seconds + 30
  private_dns_zone_id_databricks                                            = var.private_dns_zone_id_databricks
  private_dns_zone_id_blob                                                  = var.private_dns_zone_id_blob
  private_dns_zone_id_dfs                                                   = var.private_dns_zone_id_dfs
  customer_managed_key                                                      = var.customer_managed_key
}
