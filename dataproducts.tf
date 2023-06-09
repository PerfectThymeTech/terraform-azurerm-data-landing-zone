module "data_products" {
  source   = "./modules/dataproduct"
  for_each = local.data_product_definitions
  providers = {
    databricks                 = databricks.experimentation
    databricks.experimentation = databricks.experimentation
    databricks.automation      = databricks.automation
  }

  location                       = var.location
  data_product_name              = try("${each.value.id}-${each.value.environment}", "")
  tags                           = try(each.value.tags, {})
  network_enabled                = try(each.value.network.enabled, false)
  vnet_id                        = data.azurerm_virtual_network.virtual_network.id
  nsg_id                         = data.azurerm_network_security_group.network_security_group.id
  route_table_id                 = data.azurerm_route_table.route_table.id
  subnets                        = try(each.value.network.subnets, [])
  private_dns_zone_id_key_vault  = var.private_dns_zone_id_key_vault
  identity_enabled               = try(each.value.identity.enabled, false)
  security_group_display_name    = try(each.value.identity.security_group_display_name, "")
  user_assigned_identity_enabled = try(each.value.identity.user_assigned_identity_enabled, false)
  service_principal_enabled      = try(each.value.identity.service_principal_enabled, false)
  containers_enabled = {
    raw       = try(each.value.storage_container.raw, false)
    enriched  = try(each.value.storage_container.enriched, false)
    curated   = try(each.value.storage_container.curated, false)
    workspace = try(each.value.storage_container.workspace, false)
  }
  datalake_raw_id            = module.datalake_raw.datalake_id
  datalake_enriched_id       = module.datalake_enriched.datalake_id
  datalake_curated_id        = module.datalake_curated.datalake_id
  datalake_workspace_id      = module.datalake_workspace.datalake_id
  databricks_enabled         = try(each.value.databricks.enabled, false)
  databricks_experimentation = try(each.value.databricks.experimentation, true)
  unity_metastore_id         = var.unity_metastore_id
  unity_catalog_configurations = {
    enabled      = try(each.value.databricks.unity_catalog.enabled, false)
    group_name   = try(each.value.databricks.unity_catalog.group_name, "")
    storage_root = try(each.value.databricks.unity_catalog.storage_root, "")
  }
  dependencies_network = [
    azapi_resource.databricks_public_subnet_002.id != "",
  ]
  dependencies_databricks = [
    module.databricks_experimentation_configuration.databricks_configuration_setup_completed,
    module.databricks_automation_configuration.databricks_configuration_setup_completed,
  ]
  dependencies_datalake = [
    module.datalake_raw.datalake_setup_completed,
    module.datalake_enriched.datalake_setup_completed,
    module.datalake_curated.datalake_setup_completed,
    module.datalake_workspace.datalake_setup_completed,
  ]
}
