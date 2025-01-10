# Resource group role assignments
resource "azurerm_role_assignment" "role_assignment_resource_group_app_reader_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app.id
  role_definition_name = "Reader"
  principal_id         = one(data.databricks_group.group_developer[*].display_name)
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_app_monitoring_reader_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app_monitoring.id
  role_definition_name = "Reader"
  principal_id         = one(data.databricks_group.group_developer[*].display_name)
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_storage_reader_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  description          = "Role assignment to storage resource group."
  scope                = "${data.azurerm_subscription.current.id}/resourceGroups/${split("/", var.storage_account_ids.external)[4]}"
  role_definition_name = "Reader"
  principal_id         = one(data.databricks_group.group_developer[*].display_name)
  principal_type       = "Group"
}

# Key vault role assignments
resource "azurerm_role_assignment" "role_assignment_key_vault_secrets_reader_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  description          = "Role assignment to key vault to create secrets."
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets Reader"
  principal_id         = one(data.databricks_group.group_developer[*].display_name)
  principal_type       = "Group"
}

# Databricks role assignments
resource "azurerm_role_assignment" "role_assignment_databricks_workspace_reader_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  description          = "Role assignment to databricks workspace."
  scope                = var.databricks_workspace_details["engineering"].id
  role_definition_name = "Reader"
  principal_id         = one(data.databricks_group.group_developer[*].display_name)
  principal_type       = "Group"
}

# Storage role assignments
resource "azurerm_role_assignment" "role_assignment_storage_container_external_blob_data_conributor_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  description          = "Role assignment to the external storage container."
  scope                = azurerm_storage_container.storage_container_external.resource_manager_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(data.databricks_group.group_developer[*].display_name)
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_raw_blob_data_conributor_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  description          = "Role assignment to the raw storage container."
  scope                = azurerm_storage_container.storage_container_raw.resource_manager_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(data.databricks_group.group_developer[*].display_name)
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_enriched_blob_data_conributor_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  description          = "Role assignment to the enriched storage container."
  scope                = azurerm_storage_container.storage_container_enriched.resource_manager_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(data.databricks_group.group_developer[*].display_name)
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_curated_blob_data_conributor_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  description          = "Role assignment to the curated storage container."
  scope                = azurerm_storage_container.storage_container_curated.resource_manager_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(data.databricks_group.group_developer[*].display_name)
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_workspace_blob_data_conributor_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  description          = "Role assignment to the workspace storage container."
  scope                = azurerm_storage_container.storage_container_workspace.resource_manager_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = one(data.databricks_group.group_developer[*].display_name)
  principal_type       = "Group"
}
