# Resource group role assignments
resource "azurerm_role_assignment" "role_assignment_resource_group_app_reader_accessconnector" {
  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app.id
  role_definition_name = "Reader"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_app_monitoring_reader_accessconnector" {
  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app_monitoring.id
  role_definition_name = "Reader"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_storage_reader_accessconnector" {
  description          = "Role assignment to storage resource group."
  scope                = "${data.azurerm_subscription.current.id}/resourceGroups/${split("/", var.storage_account_ids.provider)[4]}"
  role_definition_name = "Reader"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

# Key vault role assignments
resource "azurerm_role_assignment" "role_assignment_key_vault_secrets_officer_accessconnector" {
  description          = "Role assignment to key vault to create secrets."
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

# Databricks role assignments
resource "azurerm_role_assignment" "role_assignment_databricks_workspace_reader_accessconnector" {
  description          = "Role assignment to databricks workspace."
  scope                = var.databricks_workspace_details["engineering"].id
  role_definition_name = "Reader"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

# AI service role assignments
resource "azurerm_role_assignment" "role_assignment_ai_service_accessconnector" {
  for_each = var.ai_services

  description          = "Role assignment to the ai services."
  scope                = module.ai_service[each.key].cognitive_account_id
  role_definition_name = local.ai_service_kind_role_map_write[each.value.kind]
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_cognitive_services_usages_reader_accessconnector" {
  description          = "Cognitive Services Usages Reader to check quota for Azure Open AI models."
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Cognitive Services Usages Reader"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

# AI search service role assignment
resource "azurerm_role_assignment" "role_assignment_search_service_index_data_contributor_accessconnector" {
  count = var.search_service_details.enabled ? 1 : 0

  description          = "Role assignment to create or manage objects in AI Search."
  scope                = one(module.ai_search[*].search_service_id)
  role_definition_name = "Search Index Data Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_search_service_contributor_accessconnector" {
  count = var.search_service_details.enabled ? 1 : 0

  description          = "Role assignment to load documents and run indexing jobs in AI Search."
  scope                = one(module.ai_search[*].search_service_id)
  role_definition_name = "Search Service Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

# Storage Role Assignments
resource "azurerm_role_assignment" "role_assignment_storage_account_provider_event_subscription_contributor_accessconnector" {
  description          = "Role assignment to provider storage account to create event triggers."
  scope                = var.storage_account_ids.provider
  role_definition_name = "EventGrid EventSubscription Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_provider_blob_delegator_accessconnector" {
  description          = "Role assignment to provider storage account to create SAS keys."
  scope                = var.storage_account_ids.provider
  role_definition_name = "Storage Blob Delegator"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_provider_blob_data_contributor_accessconnector" {
  for_each = var.data_provider_details

  description          = "Role assignment to provider storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_provider[each.key].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_queue_provider_queue_data_contributor_accessconnector" {
  for_each = var.data_provider_details

  description          = "Role assignment to provider storage account queue to read and write data for file events."
  scope                = azurerm_storage_queue.storage_queue_provider[each.key].resource_manager_id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_raw_event_subscription_contributor_accessconnector" {
  description          = "Role assignment to raw storage account to create event triggers."
  scope                = var.storage_account_ids.raw
  role_definition_name = "EventGrid EventSubscription Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_raw_blob_delegator_accessconnector" {
  description          = "Role assignment to raw storage account to create SAS keys."
  scope                = var.storage_account_ids.raw
  role_definition_name = "Storage Blob Delegator"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_raw_blob_data_contributor_accessconnector" {
  description          = "Role assignment to raw storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_raw.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_queue_raw_queue_data_contributor_accessconnector" {
  description          = "Role assignment to raw storage account queue to read and write data for file events."
  scope                = azurerm_storage_queue.storage_queue_raw.resource_manager_id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_enriched_event_subscription_contributor_accessconnector" {
  description          = "Role assignment to enriched storage account to create event triggers."
  scope                = var.storage_account_ids.enriched
  role_definition_name = "EventGrid EventSubscription Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_enriched_blob_delegator_accessconnector" {
  description          = "Role assignment to enriched storage account to create SAS keys."
  scope                = var.storage_account_ids.enriched
  role_definition_name = "Storage Blob Delegator"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_enriched_blob_data_contributor_accessconnector" {
  description          = "Role assignment to enriched storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_enriched.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_queue_enriched_queue_data_contributor_accessconnector" {
  description          = "Role assignment to enriched storage account queue to read and write data for file events."
  scope                = azurerm_storage_queue.storage_queue_enriched.resource_manager_id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_curated_event_subscription_contributor_accessconnector" {
  description          = "Role assignment to curated storage account to create event triggers."
  scope                = var.storage_account_ids.curated
  role_definition_name = "EventGrid EventSubscription Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_curated_blob_delegator_accessconnector" {
  description          = "Role assignment to curated storage account to create SAS keys."
  scope                = var.storage_account_ids.curated
  role_definition_name = "Storage Blob Delegator"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_curated_blob_data_contributor_accessconnector" {
  description          = "Role assignment to curated storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_curated.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_queue_curated_queue_data_contributor_accessconnector" {
  description          = "Role assignment to curated storage account queue to read and write data for file events."
  scope                = azurerm_storage_queue.storage_queue_curated.resource_manager_id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_workspace_event_subscription_contributor_accessconnector" {
  description          = "Role assignment to workspace storage account to create event triggers."
  scope                = var.storage_account_ids.workspace
  role_definition_name = "EventGrid EventSubscription Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_workspace_blob_delegator_accessconnector" {
  description          = "Role assignment to workspace storage account to create SAS keys."
  scope                = var.storage_account_ids.workspace
  role_definition_name = "Storage Blob Delegator"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_workspace_blob_data_contributor_accessconnector" {
  description          = "Role assignment to workspace storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_workspace.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_queue_workspace_queue_data_contributor_accessconnector" {
  description          = "Role assignment to workspace storage account queue to read and write data for file events."
  scope                = azurerm_storage_queue.storage_queue_workspace.resource_manager_id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = module.databricks_access_connector.databricks_access_connector_principal_id
  principal_type       = "ServicePrincipal"
}
