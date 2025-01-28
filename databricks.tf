module "databricks_core" {
  source = "./modules/databrickscore"

  providers = {
    databricks         = databricks.engineering
    databricks.account = databricks
    null               = null
  }

  # General variables
  location    = var.location
  environment = var.environment
  prefix      = var.prefix
  tags        = var.tags

  # Service variables
  databricks_workspace_details      = local.databricks_workspace_details
  databricks_private_endpoint_rules = local.databricks_private_endpoint_rules
  databricks_ip_access_list_allow   = []
  databricks_ip_access_list_deny    = []

  depends_on = [
    module.core.databricks_dependencies,
  ]
}

module "databricks_data_application" {
  for_each = local.data_application_definitions

  source = "./modules/databricksdataapplication"

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
  databricks_workspace_workspace_id        = module.core.databricks_workspace_details.engineering.workspace_id # each.value.workspace_id
  databricks_access_connector_id           = module.data_application[each.key].databricks_access_connector_id
  databricks_cluster_policy_library_path   = var.databricks_cluster_policy_library_path
  databricks_cluster_policy_file_variables = var.databricks_cluster_policy_file_variables
  databricks_keyvault_secret_scope_details = try(module.data_application[each.key].key_vault_details, {})
  storage_container_ids                    = try(module.data_application[each.key].storage_container_ids, {})

  # Identity variables
  admin_group_name       = try(each.value.identity.admin_group_name, "")
  developer_group_name   = try(each.value.identity.developer_group_name, "")
  reader_group_name      = try(each.value.identity.reader_group_name, "")
  service_principal_name = try(each.value.identity.service_principal_name, "")

  # Budget variables
  budget = try(each.value.budget, 100)

  depends_on = [
    module.core.databricks_dependencies,
  ]
}
