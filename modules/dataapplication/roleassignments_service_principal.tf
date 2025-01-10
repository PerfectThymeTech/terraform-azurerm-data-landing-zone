# Resource group role assignments
resource "azurerm_role_assignment" "role_assignment_resource_group_app_reader_service_principal" {
  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app.id
  role_definition_name = "Reader"
  principal_id         = data.azuread_service_principal.service_principal.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_app_monitoring_reader_service_principal" {
  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app_monitoring.id
  role_definition_name = "Reader"
  principal_id         = data.azuread_service_principal.service_principal.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_storage_reader_service_principal" {
  description          = "Role assignment to storage resource group."
  scope                = "${data.azurerm_subscription.current.id}/resourceGroups/${split("/", var.storage_account_ids.external)[4]}"
  role_definition_name = "Reader"
  principal_id         = data.azuread_service_principal.service_principal.object_id
  principal_type       = "Group"
}

# Key vault role assignments
resource "azurerm_role_assignment" "role_assignment_key_vault_secrets_officer_service_principal" {
  description          = "Role assignment to key vault to create secrets."
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azuread_service_principal.service_principal.object_id
  principal_type       = "Group"
}

# Databricks role assignments
resource "azurerm_role_assignment" "role_assignment_databricks_workspace_reader_service_principal" {
  description          = "Role assignment to databricks workspace."
  scope                = var.databricks_workspace_details["engineering"].id
  role_definition_name = "Reader"
  principal_id         = data.azuread_service_principal.service_principal.object_id
  principal_type       = "Group"
}

# Storage role assignments
resource "azurerm_role_assignment" "role_assignment_storage_container_external_blob_data_owner_service_principal" {
  description          = "Role assignment to the external storage container."
  scope                = azurerm_storage_container.storage_container_external.resource_manager_id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_service_principal.service_principal.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_raw_blob_data_owner_service_principal" {
  description          = "Role assignment to the raw storage container."
  scope                = azurerm_storage_container.storage_container_raw.resource_manager_id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_service_principal.service_principal.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_enriched_blob_data_owner_service_principal" {
  description          = "Role assignment to the enriched storage container."
  scope                = azurerm_storage_container.storage_container_enriched.resource_manager_id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_service_principal.service_principal.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_curated_blob_data_owner_service_principal" {
  description          = "Role assignment to the curated storage container."
  scope                = azurerm_storage_container.storage_container_curated.resource_manager_id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_service_principal.service_principal.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_workspace_blob_data_owner_service_principal" {
  description          = "Role assignment to the workspace storage container."
  scope                = azurerm_storage_container.storage_container_workspace.resource_manager_id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_service_principal.service_principal.object_id
  principal_type       = "Group"
}
