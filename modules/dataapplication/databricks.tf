module "databricks_workspace" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/databricksworkspace?ref=main"
  providers = {
    azurerm = azurerm
    time    = time
  }

  location                                                                  = var.location
  location_private_endpoint                                                 = var.location
  resource_group_name                                                       = azurerm_resource_group.resource_group_app.name
  tags                                                                      = var.tags
  databricks_workspace_name                                                 = "${local.prefix}-dbw001"
  databricks_workspace_access_connector_id                                  = module.databricks_access_connector.databricks_access_connector_id
  databricks_workspace_machine_learning_workspace_id                        = null
  databricks_workspace_virtual_network_id                                   = var.vnet_id
  databricks_workspace_private_subnet_name                                  = local.databricks_private_subnet_name
  databricks_workspace_private_subnet_network_security_group_association_id = var.subnet_id_databricks_private
  databricks_workspace_public_subnet_name                                   = local.databricks_public_subnet_name
  databricks_workspace_public_subnet_network_security_group_association_id  = var.subnet_id_databricks_public
  databricks_workspace_storage_account_sku_name                             = var.zone_redundancy_enabled ? "Standard_ZRS" : "Standard_LRS"
  databricks_workspace_browser_authentication_private_endpoint_enabled      = true
  diagnostics_configurations                                                = var.diagnostics_configurations
  subnet_id                                                                 = var.subnet_id_app
  connectivity_delay_in_seconds                                             = var.connectivity_delay_in_seconds
  private_dns_zone_id_databricks                                            = var.private_dns_zone_id_databricks
  customer_managed_key                                                      = var.customer_managed_key
}
