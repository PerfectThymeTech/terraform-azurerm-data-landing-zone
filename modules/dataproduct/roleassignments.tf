# Role assignments current
resource "azurerm_role_assignment" "current_roleassignment_key_vault" {
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

# Role assignments Security Group
resource "azurerm_role_assignment" "security_group_roleassignment_resource_group" {
  count                = local.conditions.security_group ? 1 : 0
  scope                = azurerm_resource_group.data_product_rg.id
  role_definition_name = "Contributor"
  principal_id         = one(data.azuread_group.security_group[*].object_id)
}

resource "azurerm_role_assignment" "security_group_roleassignment_key_vault" {
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = one(data.azuread_group.security_group[*].object_id)
}

resource "azurerm_role_assignment" "security_group_roleassignment_subnets" {
  for_each             = azapi_resource.subnets
  scope                = each.value.id
  role_definition_name = "Network Contributor"
  principal_id         = one(data.azuread_group.security_group[*].object_id)
}

resource "azurerm_role_assignment" "security_group_roleassignment_storage_raw" {
  count                = var.containers_enabled.raw && local.conditions.security_group ? 1 : 0
  scope                = data.azurerm_storage_account.datalake_raw.id
  role_definition_name = "Reader"
  principal_id         = one(data.azuread_group.security_group[*].object_id)
}

resource "azurerm_role_assignment" "security_group_roleassignment_container_raw" {
  count                = var.containers_enabled.raw && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_raw[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(data.azuread_group.security_group[*].object_id)
}

resource "azurerm_role_assignment" "security_group_roleassignment_storage_enriched" {
  count                = var.containers_enabled.enriched && local.conditions.security_group ? 1 : 0
  scope                = data.azurerm_storage_account.datalake_enriched.id
  role_definition_name = "Reader"
  principal_id         = one(data.azuread_group.security_group[*].object_id)
}

resource "azurerm_role_assignment" "security_group_roleassignment_container_enriched" {
  count                = var.containers_enabled.enriched && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_enriched[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(data.azuread_group.security_group[*].object_id)
}

resource "azurerm_role_assignment" "security_group_roleassignment_storage_curated" {
  count                = var.containers_enabled.curated && local.conditions.security_group ? 1 : 0
  scope                = data.azurerm_storage_account.datalake_curated.id
  role_definition_name = "Reader"
  principal_id         = one(data.azuread_group.security_group[*].object_id)
}

resource "azurerm_role_assignment" "security_group_roleassignment_container_curated" {
  count                = var.containers_enabled.curated && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_curated[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(data.azuread_group.security_group[*].object_id)
}

resource "azurerm_role_assignment" "security_group_roleassignment_storage_workspace" {
  count                = var.containers_enabled.workspace && local.conditions.security_group ? 1 : 0
  scope                = data.azurerm_storage_account.datalake_workspace.id
  role_definition_name = "Reader"
  principal_id         = one(data.azuread_group.security_group[*].object_id)
}

resource "azurerm_role_assignment" "security_group_roleassignment_container_workspace" {
  count                = var.containers_enabled.workspace && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_workspace[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(data.azuread_group.security_group[*].object_id)
}

# Role assignments for User Assigned Identity
resource "azurerm_role_assignment" "user_assigned_identity_roleassignment_key_vault" {
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = one(azurerm_user_assigned_identity.user_assigned_identity[*].principal_id)
}

resource "azurerm_role_assignment" "user_assigned_identity_roleassignment_resource_group" {
  count                = local.conditions.security_group ? 1 : 0
  scope                = azurerm_resource_group.data_product_rg.id
  role_definition_name = "Contributor"
  principal_id         = one(azurerm_user_assigned_identity.user_assigned_identity[*].principal_id)
}

resource "azurerm_role_assignment" "user_assigned_identity_roleassignment_subnets" {
  for_each             = azapi_resource.subnets
  scope                = each.value.id
  role_definition_name = "Network Contributor"
  principal_id         = one(azurerm_user_assigned_identity.user_assigned_identity[*].principal_id)
}

resource "azurerm_role_assignment" "user_assigned_identity_roleassignment_container_raw" {
  count                = var.containers_enabled.raw && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_raw[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azurerm_user_assigned_identity.user_assigned_identity[*].principal_id)
}

resource "azurerm_role_assignment" "user_assigned_identity_roleassignment_container_enriched" {
  count                = var.containers_enabled.enriched && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_enriched[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azurerm_user_assigned_identity.user_assigned_identity[*].principal_id)
}

resource "azurerm_role_assignment" "user_assigned_identity_roleassignment_container_curated" {
  count                = var.containers_enabled.curated && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_curated[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azurerm_user_assigned_identity.user_assigned_identity[*].principal_id)
}

resource "azurerm_role_assignment" "user_assigned_identity_roleassignment_container_workspace" {
  count                = var.containers_enabled.workspace && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_workspace[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azurerm_user_assigned_identity.user_assigned_identity[*].principal_id)
}

# Role assignments Service Principal
resource "azurerm_role_assignment" "service_principal_roleassignment_key_vault" {
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = one(azuread_service_principal.service_principal[*].object_id)
}

resource "azurerm_role_assignment" "service_principal_roleassignment_resource_group" {
  count                = local.conditions.security_group ? 1 : 0
  scope                = azurerm_resource_group.data_product_rg.id
  role_definition_name = "Contributor"
  principal_id         = one(azuread_service_principal.service_principal[*].object_id)
}

resource "azurerm_role_assignment" "service_principal_roleassignment_subnets" {
  for_each             = azapi_resource.subnets
  scope                = each.value.id
  role_definition_name = "Network Contributor"
  principal_id         = one(azuread_service_principal.service_principal[*].object_id)
}

resource "azurerm_role_assignment" "service_principal_roleassignment_container_raw" {
  count                = var.containers_enabled.raw && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_raw[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azuread_service_principal.service_principal[*].object_id)
}

resource "azurerm_role_assignment" "service_principal_roleassignment_container_enriched" {
  count                = var.containers_enabled.enriched && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_enriched[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azuread_service_principal.service_principal[*].object_id)
}

resource "azurerm_role_assignment" "service_principal_roleassignment_container_curated" {
  count                = var.containers_enabled.curated && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_curated[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azuread_service_principal.service_principal[*].object_id)
}

resource "azurerm_role_assignment" "service_principal_roleassignment_container_workspace" {
  count                = var.containers_enabled.workspace && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_workspace[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azuread_service_principal.service_principal[*].object_id)
}

# Role assignments for Databricks Access Connector
resource "azurerm_role_assignment" "dbac_roleassignment_storage_raw" {
  count                = var.containers_enabled.raw && local.conditions.security_group ? 1 : 0
  scope                = data.azurerm_storage_account.datalake_raw.id
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(azurerm_databricks_access_connector.databricks_access_connector[*].identity[0].principal_id)
}

resource "azurerm_role_assignment" "dbac_roleassignment_container_raw" {
  count                = var.containers_enabled.raw && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_raw[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azurerm_databricks_access_connector.databricks_access_connector[*].identity[0].principal_id)
}

resource "azurerm_role_assignment" "dbac_roleassignment_storage_enriched" {
  count                = var.containers_enabled.enriched && local.conditions.security_group ? 1 : 0
  scope                = data.azurerm_storage_account.datalake_enriched.id
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(azurerm_databricks_access_connector.databricks_access_connector[*].identity[0].principal_id)
}

resource "azurerm_role_assignment" "dbac_roleassignment_container_enriched" {
  count                = var.containers_enabled.enriched && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_enriched[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azurerm_databricks_access_connector.databricks_access_connector[*].identity[0].principal_id)
}

resource "azurerm_role_assignment" "dbac_roleassignment_storage_curated" {
  count                = var.containers_enabled.curated && local.conditions.security_group ? 1 : 0
  scope                = data.azurerm_storage_account.datalake_curated.id
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(azurerm_databricks_access_connector.databricks_access_connector[*].identity[0].principal_id)
}

resource "azurerm_role_assignment" "dbac_roleassignment_container_curated" {
  count                = var.containers_enabled.curated && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_curated[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azurerm_databricks_access_connector.databricks_access_connector[*].identity[0].principal_id)
}

resource "azurerm_role_assignment" "dbac_roleassignment_storage_workspace" {
  count                = var.containers_enabled.workspace && local.conditions.security_group ? 1 : 0
  scope                = data.azurerm_storage_account.datalake_workspace.id
  role_definition_name = "Storage Blob Delegator"
  principal_id         = one(azurerm_databricks_access_connector.databricks_access_connector[*].identity[0].principal_id)
}

resource "azurerm_role_assignment" "dbac_roleassignment_container_workspace" {
  count                = var.containers_enabled.workspace && local.conditions.security_group ? 1 : 0
  scope                = one(azurerm_storage_container.container_workspace[*].resource_manager_id)
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(azurerm_databricks_access_connector.databricks_access_connector[*].identity[0].principal_id)
}
