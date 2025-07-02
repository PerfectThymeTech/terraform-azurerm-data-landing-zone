# Capability Host Role Assignments
resource "azurerm_role_assignment" "role_assignment_storage_account_aifoundry_blob_data_contributor_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  description          = "Role assignment for storage write operations."
  scope                = var.ai_foundry_account_details.storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_account_aifoundry_blob_data_owner_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  description          = "Role assignment for storage write operations."
  scope                = var.ai_foundry_account_details.storage_account.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  principal_type       = "ServicePrincipal"
  condition_version    = "2.0"
  condition            = <<-EOT
  (
    (
      !(ActionMatches{'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/tags/read'})
      AND
      !(ActionMatches{'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/filter/action'})
      AND
      !(ActionMatches{'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/tags/write'})
    )
    OR
    (
      @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:name] StringStartsWithIgnoreCase '${local.ai_foundry_project_workspace_id}'
      AND
      @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:name] StringLikeIgnoreCase '*-azureml-agent'
    )
  )
  EOT
}

resource "azurerm_role_assignment" "role_assignment_cosmosdb_account_operator_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  description          = "Role assignment for cosmos write operations."
  scope                = var.ai_foundry_account_details.cosmos_db.id
  role_definition_name = "Cosmos DB Operator"
  principal_id         = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_cosmosdb_sql_role_assignment" "cosmosdb_sql_role_assignment_thread_message_store_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  resource_group_name = split("/", var.ai_foundry_account_details.cosmos_db.id)[4]
  account_name        = reverse(split("/", var.ai_foundry_account_details.cosmos_db.id))[0]
  role_definition_id  = one(data.azurerm_cosmosdb_sql_role_definition.cosmosdb_sql_role_definition[*].id)
  principal_id        = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  scope               = "${var.ai_foundry_account_details.cosmos_db.id}/dbs/${local.cosmosdb_account_database_name}/colls/${local.ai_foundry_project_workspace_id}-${local.cosmosdb_account_database_container_thread_message_name}"

  depends_on = [
    azapi_resource.ai_foundry_project_capability_hosts,
  ]
}

resource "azurerm_cosmosdb_sql_role_assignment" "cosmosdb_sql_role_assignment_system_thread_message_store_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  resource_group_name = split("/", var.ai_foundry_account_details.cosmos_db.id)[4]
  account_name        = reverse(split("/", var.ai_foundry_account_details.cosmos_db.id))[0]
  role_definition_id  = one(data.azurerm_cosmosdb_sql_role_definition.cosmosdb_sql_role_definition[*].id)
  principal_id        = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  scope               = "${var.ai_foundry_account_details.cosmos_db.id}/dbs/${local.cosmosdb_account_database_name}/colls/${local.ai_foundry_project_workspace_id}-${local.cosmosdb_account_database_container_system_thread_message_name}"

  depends_on = [
    azapi_resource.ai_foundry_project_capability_hosts,
  ]
}

resource "azurerm_cosmosdb_sql_role_assignment" "cosmosdb_sql_role_assignment_agent_entity_store_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  resource_group_name = split("/", var.ai_foundry_account_details.cosmos_db.id)[4]
  account_name        = reverse(split("/", var.ai_foundry_account_details.cosmos_db.id))[0]
  role_definition_id  = one(data.azurerm_cosmosdb_sql_role_definition.cosmosdb_sql_role_definition[*].id)
  principal_id        = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  scope               = "${var.ai_foundry_account_details.cosmos_db.id}/dbs/${local.cosmosdb_account_database_name}/colls/${local.ai_foundry_project_workspace_id}-${local.cosmosdb_account_database_container_agent_entity_store_name}"

  depends_on = [
    azapi_resource.ai_foundry_project_capability_hosts,
  ]
}

resource "azurerm_role_assignment" "role_assignment_search_service_account_search_index_data_contributor_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  description          = "Role assignment for ai search write operations."
  scope                = var.ai_foundry_account_details.search_service.id
  role_definition_name = "Search Index Data Contributor"
  principal_id         = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_search_service_account_search_service_contributor_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  description          = "Role assignment for ai search write operations."
  scope                = var.ai_foundry_account_details.search_service.id
  role_definition_name = "Search Service Contributor"
  principal_id         = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  principal_type       = "ServicePrincipal"
}

# Resource group role assignments

# Key vault role assignments

# Databricks role assignments

# AI service role assignments
resource "azurerm_role_assignment" "role_assignment_ai_service_ai_foundry_project" {
  for_each = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? var.ai_services : {}

  description          = "Role assignment to the ai services."
  scope                = module.ai_service[each.key].cognitive_account_id
  role_definition_name = local.ai_service_kind_role_map_write[each.value.kind]
  principal_id         = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  principal_type       = "ServicePrincipal"
}

# AI search service role assignment
resource "azurerm_role_assignment" "role_assignment_search_service_index_data_contributor_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled && var.search_service_details.enabled ? 1 : 0

  description          = "Role assignment to create or manage objects in AI Search."
  scope                = one(module.ai_search[*].search_service_id)
  role_definition_name = "Search Index Data Contributor"
  principal_id         = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_search_service_contributor_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled && var.search_service_details.enabled ? 1 : 0

  description          = "Role assignment to load documents and run indexing jobs in AI Search."
  scope                = one(module.ai_search[*].search_service_id)
  role_definition_name = "Search Service Contributor"
  principal_id         = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  principal_type       = "ServicePrincipal"
}

# Storage Role Assignments
resource "azurerm_role_assignment" "role_assignment_storage_container_provider_blob_data_contributor_ai_foundry_project" {
  for_each = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? var.data_provider_details : {}

  description          = "Role assignment to provider storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_provider[each.key].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_raw_blob_data_contributor_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  description          = "Role assignment to raw storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_raw.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_enriched_blob_data_contributor_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  description          = "Role assignment to enriched storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_enriched.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_curated_blob_data_contributor_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  description          = "Role assignment to curated storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_curated.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_workspace_blob_data_contributor_ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  description          = "Role assignment to workspace storage account container to read and write data."
  scope                = azurerm_storage_container.storage_container_workspace.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azapi_resource.ai_foundry_project[*].project_principal_id)
  principal_type       = "ServicePrincipal"
}
