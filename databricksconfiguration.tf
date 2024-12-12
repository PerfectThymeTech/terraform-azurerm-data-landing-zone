module "databricks_account_configuration" {
  source = "./modules/databricksaccountconfiguration"

  providers = {
    databricks = databricks
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
  source = "./modules/databricksworkspaceconfiguration"

  providers = {
    databricks = databricks.engineering
  }

  # General variables
  location    = var.location
  environment = var.environment
  prefix      = var.prefix
  tags        = var.tags

  # Service variables
}

module "databricksworkspaceapplication" {
  for_each = local.data_application_definitions

  source = "./modules/databricksworkspaceapplication"

  providers = {
    databricks         = databricks.engineering
    databricks.account = databricks
  }

  # General variables
  location    = var.location
  environment = var.environment
  prefix      = var.prefix
  tags        = merge(var.tags, try(each.value.tags, {}))

  # Service variables
  app_name                                 = each.key
  databricks_workspace_workspace_id        = module.core.databricks_workspace_details.engineering.id # each.value.workspace_id
  databricks_access_connector_id           = module.data_application[each.key].databricks_access_connector_id
  databricks_cluster_policies              = local.databricks_cluster_policy_definitions
  databricks_cluster_policy_file_variables = var.databricks_cluster_policy_file_variables
  databricks_keyvault_secret_scope_details = try(module.data_application[each.key].key_vault_details, {})
  storage_container_ids                    = try(module.data_application[each.key].storage_container_ids, {})

  # Budget variables
  budget = try(local.data_application_definitions[each.key].budget, null)
}
