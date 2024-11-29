module "databricks_account_configuration" {
  source = "./modules/databricksaccountconfiguration"

  providers = {
    databricks = databricks.account
    null       = null
  }

  # General variables
  location    = var.location
  environment = var.environment
  prefix      = var.prefix
  tags        = var.tags

  # Service variables
  databricks_workspace_details      = local.databricks_workspace_details
  databricks_private_endpoint_rules = local.databricks_private_endpoint_rules
}

module "databricks_workspace_configuration" {
  for_each = local.databricks_workspace_details

  source = "./modules/databricksworkspaceconfiguration"

  providers = {
    databricks         = databricks.application[each.key]
    databricks.account = databricks.account
  }

  # General variables
  location    = var.location
  environment = var.environment
  prefix      = var.prefix
  tags        = var.tags

  # Service variables
  app_name                                 = each.key
  databricks_workspace_workspace_id        = each.value.workspace_id
  databricks_access_connector_id           = each.value.access_connector_id # module.data_application[key].databricks_workspace_details.access_connector_id
  databricks_cluster_policies              = local.databricks_cluster_policy_definitions
  databricks_keyvault_secret_scope_details = try(module.data_application[each.key].key_vault_details, {})
  storage_container_ids                    = try(module.data_application[each.key].storage_container_ids, {})

  # Budget variables
  budget = try(local.data_application_definitions[each.key].budget, null)
}
