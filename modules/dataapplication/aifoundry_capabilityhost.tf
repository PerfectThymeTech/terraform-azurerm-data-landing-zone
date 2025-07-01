resource "azapi_resource" "ai_foundry_project_capability_hosts" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.ai_foundry_account.id != "" ? 1 : 0

  type      = "Microsoft.CognitiveServices/accounts/projects/capabilityHosts@2025-04-01-preview"
  name      = "default-project-${each.key}"
  parent_id = one(azapi_resource.ai_foundry_project[*].id)

  body = {
    properties = {
      aiServicesConnections    = slice(local.ai_foundry_project_connection_openai_names, 0, 1)
      capabilityHostKind       = "Agents"
      storageConnections       = [azapi_resource.ai_foundry_project_connection_storage_account.name]
      threadStorageConnections = [azapi_resource.ai_foundry_project_connection_cosmosdb_account.name]
      vectorStoreConnections   = [azapi_resource.ai_foundry_project_connection_search_service_account.name]
    }
  }

  response_export_values    = []
  schema_validation_enabled = false
  locks                     = []
  ignore_casing             = false
  ignore_missing_property   = true

  depends_on = [
    azurerm_role_assignment.role_assignment_search_service_account_search_index_data_contributor_ai_services_project,
    azurerm_role_assignment.role_assignment_search_service_account_search_service_contributor_ai_services_project,
    azurerm_role_assignment.role_assignment_cosmosdb_account_operator_ai_services_project,
    azurerm_role_assignment.role_assignment_storage_account_blob_data_contributor_ai_services_project,
  ]
}
