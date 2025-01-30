module "data_factory" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/datafactory?ref=main"
  providers = {
    azurerm = azurerm
    azapi   = azapi
    time    = time
  }

  count = var.data_factory_details.enabled ? 1 : 0

  location                                          = var.location
  resource_group_name                               = azurerm_resource_group.resource_group_app.name
  tags                                              = var.tags
  data_factory_name                                 = "${local.prefix}-adf001"
  data_factory_purview_id                           = null
  data_factory_azure_devops_repo                    = {}
  data_factory_github_repo                          = var.data_factory_details.github_repo
  data_factory_global_parameters                    = {}
  data_factory_published_content                    = {}
  data_factory_published_content_template_variables = {}
  data_factory_triggers_start                       = []
  data_factory_pipelines_run                        = []
  data_factory_managed_private_endpoints            = local.data_factory_managed_private_endpoints
  diagnostics_configurations                        = var.diagnostics_configurations
  subnet_id                                         = var.subnet_id_app
  connectivity_delay_in_seconds                     = var.connectivity_delay_in_seconds
  private_dns_zone_id_data_factory                  = var.private_dns_zone_id_data_factory
  customer_managed_key                              = var.customer_managed_key
}
