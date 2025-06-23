# Resource group role assignments

# Key vault role assignments

# Databricks role assignments

# AI service role assignments

# AI search service role assignment
resource "azurerm_role_assignment" "role_assignment_search_service_index_data_reader_aiservice" {
  for_each = var.search_service_details.enabled ? var.ai_services : {}

  description          = "Role assignment to create or manage objects in AI Search."
  scope                = one(module.ai_search[*].search_service_id)
  role_definition_name = "Search Index Data Reader"
  principal_id         = module.ai_service[each.key].cognitive_account_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_search_service_contributor_aiservice" {
  for_each = var.search_service_details.enabled ? var.ai_services : {}

  description          = "Role assignment to create or manage objects in AI Search."
  scope                = one(module.ai_search[*].search_service_id)
  role_definition_name = "Search Service Contributor"
  principal_id         = module.ai_service[each.key].cognitive_account_principal_id
  principal_type       = "ServicePrincipal"
}

# Storage Role Assignments
resource "azurerm_role_assignment" "role_assignment_storage_container_provider_blob_data_contributor_aiservice" {
  for_each = merge([
    for data_provider_key, data_provider_value in var.data_provider_details : {
      for ai_service_key, ai_service_value in var.ai_services :
      "${data_provider_key}-${ai_service_key}" => {
        ai_service_key      = ai_service_key
        ai_service_value    = ai_service_value
        data_provider_key   = data_provider_key
        data_provider_value = data_provider_value
      }
    }
  ]...)

  description          = "Role assignment to provider storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_provider[each.value.data_provider_key].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.ai_service[each.value.ai_service_key].cognitive_account_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_raw_blob_data_contributor_aiservice" {
  for_each = var.ai_services

  description          = "Role assignment to raw storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_raw.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.ai_service[each.key].cognitive_account_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_enriched_blob_data_contributor_aiservice" {
  for_each = var.ai_services

  description          = "Role assignment to enriched storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_enriched.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.ai_service[each.key].cognitive_account_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_curated_blob_data_contributor_aiservice" {
  for_each = var.ai_services

  description          = "Role assignment to curated storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_curated.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.ai_service[each.key].cognitive_account_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_workspace_blob_data_contributor_aiservice" {
  for_each = var.ai_services

  description          = "Role assignment to workspace storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_workspace.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.ai_service[each.key].cognitive_account_principal_id
  principal_type       = "ServicePrincipal"
}
