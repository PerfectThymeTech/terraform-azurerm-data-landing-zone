# Resource group role assignments
resource "azurerm_role_assignment" "role_assignment_resource_group_app_reader_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app.id
  role_definition_name = "Reader"
  principal_id         = one(data.azuread_group.group_reader[*].object_id)
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_app_monitoring_reader_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app_monitoring.id
  role_definition_name = "Reader"
  principal_id         = one(data.azuread_group.group_reader[*].object_id)
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_storage_reader_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  description          = "Role assignment to storage resource group."
  scope                = "${data.azurerm_subscription.current.id}/resourceGroups/${split("/", var.storage_account_ids.external)[4]}"
  role_definition_name = "Reader"
  principal_id         = one(data.azuread_group.group_reader[*].object_id)
  principal_type       = "Group"
}

# Key vault role assignments

# Databricks role assignments
resource "azurerm_role_assignment" "role_assignment_databricks_workspace_reader_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  description          = "Role assignment to databricks workspace."
  scope                = var.databricks_workspace_details["engineering"].id
  role_definition_name = "Reader"
  principal_id         = one(data.azuread_group.group_reader[*].object_id)
  principal_type       = "Group"
}

# AI service role assignments

# Storage role assignments
resource "azurerm_role_assignment" "role_assignment_storage_container_external_blob_data_reader_reader" {
  for_each = var.reader_group_name == "" ? {} : var.data_provider_details

  description          = "Role assignment to the external storage container."
  scope                = azurerm_storage_container.storage_container_external[each.key].id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = one(data.azuread_group.group_reader[*].object_id)
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_raw_blob_data_reader_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  description          = "Role assignment to the raw storage container."
  scope                = azurerm_storage_container.storage_container_raw.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = one(data.azuread_group.group_reader[*].object_id)
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_enriched_blob_data_reader_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  description          = "Role assignment to the enriched storage container."
  scope                = azurerm_storage_container.storage_container_enriched.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = one(data.azuread_group.group_reader[*].object_id)
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_curated_blob_data_reader_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  description          = "Role assignment to the curated storage container."
  scope                = azurerm_storage_container.storage_container_curated.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = one(data.azuread_group.group_reader[*].object_id)
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_workspace_blob_data_reader_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  description          = "Role assignment to the workspace storage container."
  scope                = azurerm_storage_container.storage_container_workspace.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = one(data.azuread_group.group_reader[*].object_id)
  principal_type       = "Group"
}
