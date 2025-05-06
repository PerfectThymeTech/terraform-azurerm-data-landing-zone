# Subscription role assignments
resource "azurerm_role_assignment" "role_assignment_budget_cost_management_reader_admin" {
  description          = "Role assignment to budget to read consumption."
  scope                = azurerm_consumption_budget_subscription.consumption_budget_subscription.id
  role_definition_name = "Cost Management Reader"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

# Resource group role assignments
resource "azurerm_role_assignment" "role_assignment_resource_group_app_reader_admin" {
  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app.id
  role_definition_name = "Reader"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_app_monitoring_reader_admin" {
  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app_monitoring.id
  role_definition_name = "Reader"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_storage_reader_admin" {
  description          = "Role assignment to storage resource group."
  scope                = "${data.azurerm_subscription.current.id}/resourceGroups/${split("/", var.storage_account_ids.external)[4]}"
  role_definition_name = "Reader"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

# Key vault role assignments
resource "azurerm_role_assignment" "role_assignment_key_vault_secrets_officer_admin" {
  description          = "Role assignment to key vault to create secrets."
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

# Databricks role assignments
resource "azurerm_role_assignment" "role_assignment_databricks_workspace_reader_admin" {
  description          = "Role assignment to databricks workspace."
  scope                = var.databricks_workspace_details["engineering"].id
  role_definition_name = "Reader"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

# AI service role assignments
resource "azurerm_role_assignment" "role_assignment_ai_service_admin" {
  for_each = var.ai_services

  description          = "Role assignment to the ai services."
  scope                = module.ai_service[each.key].cognitive_account_id
  role_definition_name = local.ai_service_kind_role_map_write[each.value.kind]
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_cognitive_services_usages_reader_admin" {
  description          = "Cognitive Services Usages Reader to check quota for Azure Open AI models."
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Cognitive Services Usages Reader"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

# AI search service role assignment
resource "azurerm_role_assignment" "role_assignment_search_service_index_data_contributor_admin" {
  count = var.search_service_details.enabled ? 1 : 0

  description          = "Role assignment to create or manage objects in AI Search."
  scope                = one(module.ai_search[*].search_service_id)
  role_definition_name = "Search Index Data Contributor"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_search_service_contributor_admin" {
  count = var.search_service_details.enabled ? 1 : 0

  description          = "Role assignment to load documents and run indexing jobs in AI Search."
  scope                = one(module.ai_search[*].search_service_id)
  role_definition_name = "Search Service Contributor"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

# Data factory role assignments
resource "azurerm_role_assignment" "role_assignment_data_factory_data_factory_contributor_admin" {
  count = var.data_factory_details.enabled ? 1 : 0

  description          = "Role assignment to data factory."
  scope                = one(module.data_factory[*].data_factory_id)
  role_definition_name = "Data Factory Contributor"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

# Fabric role assignments
resource "fabric_workspace_role_assignment" "workspace_role_assignment_contributor_admin" {
  count = var.fabric_workspace_details.enabled && var.fabric_capacity_details.enabled ? 1 : 0

  workspace_id = one(module.fabric_workspace[*].fabric_workspace_id)

  principal = {
    id   = data.azuread_group.group_admin.object_id
    type = "Group"
  }
  role = "Contributor"
}

# Storage role assignments
resource "azurerm_role_assignment" "role_assignment_storage_container_provider_blob_data_owner_admin" {
  for_each = var.data_provider_details

  description          = "Role assignment to the provider storage container."
  scope                = azurerm_storage_container.storage_container_provider[each.key].id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_raw_blob_data_owner_admin" {
  description          = "Role assignment to the raw storage container."
  scope                = azurerm_storage_container.storage_container_raw.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_enriched_blob_data_owner_admin" {
  description          = "Role assignment to the enriched storage container."
  scope                = azurerm_storage_container.storage_container_enriched.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_curated_blob_data_owner_admin" {
  description          = "Role assignment to the curated storage container."
  scope                = azurerm_storage_container.storage_container_curated.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_workspace_blob_data_owner_admin" {
  description          = "Role assignment to the workspace storage container."
  scope                = azurerm_storage_container.storage_container_workspace.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_group.group_admin.object_id
  principal_type       = "Group"
}
