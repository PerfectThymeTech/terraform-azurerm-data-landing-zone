# Resource group role assignments

# Key vault role assignments
resource "azurerm_role_assignment" "role_assignment_key_vault_secrets_user_search" {
  count = var.search_service_details.enabled ? 1 : 0

  description          = "Role assignment to key vault to read secrets."
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = one(module.ai_search[*].search_service_principal_id)
  principal_type       = "ServicePrincipal"
}

# Databricks role assignments

# AI service role assignments
resource "azurerm_role_assignment" "role_assignment_ai_service_search" {
  for_each = var.search_service_details.enabled ? var.ai_services : {}

  description          = "Role assignment to the ai services."
  scope                = module.ai_service[each.key].cognitive_account_id
  role_definition_name = local.ai_service_kind_role_map_write[each.value.kind]
  principal_id         = one(module.ai_search[*].search_service_principal_id)
  principal_type       = "ServicePrincipal"
}

# Storage Role Assignments
resource "azurerm_role_assignment" "role_assignment_storage_container_provider_blob_data_contributor_search" {
  for_each = var.search_service_details.enabled ? var.data_provider_details : {}

  description          = "Role assignment to external storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_provider[each.key].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.ai_search[*].search_service_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_raw_blob_data_contributor_search" {
  count = var.search_service_details.enabled ? 1 : 0

  description          = "Role assignment to raw storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_raw.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.ai_search[*].search_service_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_enriched_blob_data_contributor_search" {
  count = var.search_service_details.enabled ? 1 : 0

  description          = "Role assignment to enriched storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_enriched.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.ai_search[*].search_service_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_curated_blob_data_contributor_search" {
  count = var.search_service_details.enabled ? 1 : 0

  description          = "Role assignment to curated storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_curated.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.ai_search[*].search_service_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_workspace_blob_data_contributor_search" {
  count = var.search_service_details.enabled ? 1 : 0

  description          = "Role assignment to workspace storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_workspace.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.ai_search[*].search_service_principal_id)
  principal_type       = "ServicePrincipal"
}
