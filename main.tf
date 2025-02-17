module "platform" {
  source = "./modules/platform"

  providers = {
    azurerm = azurerm
    azapi   = azapi
  }

  # General variables
  location    = var.location
  environment = var.environment
  prefix      = var.prefix
  tags        = var.tags

  # Service variables
  vnet_id                               = var.vnet_id
  nsg_id                                = var.nsg_id
  route_table_id                        = var.route_table_id
  subnet_cidr_range_storage             = var.subnet_cidr_ranges.storage_subnet
  subnet_cidr_range_fabric              = var.subnet_cidr_ranges.fabric_subnet
  subnet_cidr_range_engineering_private = var.subnet_cidr_ranges.databricks_engineering_private_subnet
  subnet_cidr_range_engineering_public  = var.subnet_cidr_ranges.databricks_engineering_public_subnet
  subnet_cidr_range_consumption_private = var.subnet_cidr_ranges.databricks_consumption_private_subnet
  subnet_cidr_range_consumption_public  = var.subnet_cidr_ranges.databricks_consumption_public_subnet
  subnet_cidr_range_applications = {
    for key, value in local.data_application_definitions :
    key => {
      private_endpoint_subnet = try(value.network.private_endpoint_subnet.cidr_range, "")
      # databricks_private_subnet = try(value.network.databricks_private_subnet.cidr_range, "")
      # databricks_public_subnet  = try(value.network.databricks_public_subnet.cidr_range, "")
    }
  }
}

module "core" {
  source = "./modules/core"

  providers = {
    azurerm = azurerm
    time    = time
  }

  # General variables
  location    = var.location
  environment = var.environment
  prefix      = var.prefix
  tags        = var.tags

  # Service variables
  data_platform_subscription_ids = var.data_platform_subscription_ids

  # HA/DR variables
  zone_redundancy_enabled = var.zone_redundancy_enabled

  # Logging and monitoring variables
  diagnostics_configurations = local.diagnostics_configurations

  # Network variables
  vnet_id                       = var.vnet_id
  subnet_id_storage             = module.platform.subnet_id_storage
  subnet_id_engineering_private = module.platform.subnet_id_engineering_private
  subnet_id_engineering_public  = module.platform.subnet_id_engineering_public
  subnet_id_consumption_private = module.platform.subnet_id_consumption_private
  subnet_id_consumption_public  = module.platform.subnet_id_consumption_public
  connectivity_delay_in_seconds = local.connectivity_delay_in_seconds

  # DNS variables
  private_dns_zone_id_blob       = var.private_dns_zone_id_blob
  private_dns_zone_id_dfs        = var.private_dns_zone_id_dfs
  private_dns_zone_id_databricks = var.private_dns_zone_id_databricks

  # Customer-managed key variables
  customer_managed_key = var.customer_managed_key
}

module "data_application" {
  for_each = local.data_application_definitions

  source = "./modules/dataapplication"

  providers = {
    azurerm = azurerm
    azapi   = azapi
    azuread = azuread
    time    = time
  }

  # General variables
  location    = var.location
  environment = try(each.value.environment, var.environment)
  prefix      = var.prefix
  tags        = merge(var.tags, try(each.value.tags, {}))

  # Service variables
  app_name                     = each.key
  storage_account_ids          = module.core.storage_account_ids
  databricks_workspace_details = module.core.databricks_workspace_details
  ai_services                  = try(each.value.ai_services, {})
  search_service_details       = try(each.value.search_service, {})
  data_factory_details = {
    enabled = try(each.value.data_factory.enabled, false)
    github_repo = {
      account_name    = try(each.value.repository.github.account_name, "")
      branch_name     = try(each.value.repository.github.branch_name, "")
      git_url         = try(each.value.repository.github.git_url, "")
      repository_name = try(each.value.repository.github.repository_name, "")
      root_folder     = try(each.value.repository.github.data_factory_root_folder, "")
    }
  }
  storage_dependencies = module.core.storage_dependencies

  # HA/DR variables
  zone_redundancy_enabled = var.zone_redundancy_enabled

  # Logging and monitoring variables
  diagnostics_configurations = local.diagnostics_configurations
  alerting                   = try(each.value.alerting, {})

  # Identity variables
  admin_group_name                      = try(each.value.identity.admin_group_name, "")
  developer_group_name                  = try(each.value.identity.developer_group_name, "")
  reader_group_name                     = try(each.value.identity.reader_group_name, "")
  service_principal_name                = try(each.value.identity.service_principal_name, "")
  service_principal_name_terraform_plan = var.service_principal_name_terraform_plan

  # Network variables
  vnet_id                       = var.vnet_id
  subnet_id_app                 = module.platform.subnet_ids_private_endpoint_application[each.key]
  connectivity_delay_in_seconds = local.connectivity_delay_in_seconds

  # DNS variables
  private_dns_zone_id_blob              = var.private_dns_zone_id_blob
  private_dns_zone_id_dfs               = var.private_dns_zone_id_dfs
  private_dns_zone_id_databricks        = var.private_dns_zone_id_databricks
  private_dns_zone_id_vault             = var.private_dns_zone_id_vault
  private_dns_zone_id_cognitive_account = var.private_dns_zone_id_cognitive_account
  private_dns_zone_id_data_factory      = var.private_dns_zone_id_data_factory
  private_dns_zone_id_search_service    = var.private_dns_zone_id_search_service

  # Customer-managed key variables
  customer_managed_key = var.customer_managed_key

  # Budget variables
  budget = try(each.value.budget, 100)
}
