# Resource group role assignments
resource "azurerm_role_assignment" "role_assignment_resource_group_app_reader_accessconnector" {
  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app.id
  role_definition_name = "Reader"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_app_monitoring_reader_accessconnector" {
  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app_monitoring.id
  role_definition_name = "Reader"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_storage_reader_accessconnector" {
  description          = "Role assignment to storage resource group."
  scope                = "${data.azurerm_subscription.current.id}/resourceGroups/${split("/", var.storage_account_ids.external)[4]}"
  role_definition_name = "Reader"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

# Key vault role assignments
resource "azurerm_role_assignment" "role_assignment_key_vault_secrets_officer_accessconnector" {
  description          = "Role assignment to key vault to create secrets."
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

# Databricks role assignments
resource "azurerm_role_assignment" "role_assignment_databricks_workspace_reader_accessconnector" {
  description          = "Role assignment to databricks workspace."
  scope                = var.databricks_workspace_details["engineering"].id
  role_definition_name = "Reader"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

# AI service role assignments
resource "azurerm_role_assignment" "role_assignment_ai_service_accessconnector" {
  for_each = var.ai_services

  description          = "Role assignment to the ai services."
  scope                = module.ai_service[each.key].cognitive_account_id
  role_definition_name = local.ai_service_kind_role_map_write[each.value.kind]
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_cognitive_services_usages_reader_accessconnector" {
  description          = "Cognitive Services Usages Reader to check quota for Azure Open AI models."
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Cognitive Services Usages Reader"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

# Storage Role Assignments
resource "azurerm_role_assignment" "role_assignment_storage_account_external_blob_delegator_accessconnector" {
  description          = "Role assignment to external storage account to create SAS keys."
  scope                = var.storage_account_ids.external
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_external_blob_data_contributor_accessconnector" {
  description          = "Role assignment to external storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_external.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_raw_blob_delegator_accessconnector" {
  description          = "Role assignment to raw storage account to create SAS keys."
  scope                = var.storage_account_ids.raw
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_raw_blob_data_contributor_accessconnector" {
  description          = "Role assignment to raw storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_raw.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_enriched_blob_delegator_accessconnector" {
  description          = "Role assignment to enriched storage account to create SAS keys."
  scope                = var.storage_account_ids.enriched
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_enriched_blob_data_contributor_accessconnector" {
  description          = "Role assignment to enriched storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_enriched.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_curated_blob_delegator_accessconnector" {
  description          = "Role assignment to curated storage account to create SAS keys."
  scope                = var.storage_account_ids.curated
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_curated_blob_data_contributor_accessconnector" {
  description          = "Role assignment to curated storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_curated.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_workspace_blob_delegator_accessconnector" {
  description          = "Role assignment to workspace storage account to create SAS keys."
  scope                = var.storage_account_ids.workspace
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_workspace_blob_data_contributor_accessconnector" {
  description          = "Role assignment to workspace storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_workspace.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(module.databricks_access_connector[*].databricks_access_connector_principal_id)
  principal_type       = "ServicePrincipal"
}
