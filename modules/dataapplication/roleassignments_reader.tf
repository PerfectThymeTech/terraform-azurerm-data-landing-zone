# Subscription role assignments
resource "azurerm_role_assignment" "role_assignment_budget_cost_management_reader_reader" {
  count = var.reader_group_object_id == "" ? 0 : 1

  description          = "Role assignment to budget to read consumption."
  scope                = azurerm_consumption_budget_subscription.consumption_budget_subscription.id
  role_definition_name = "Cost Management Reader"
  principal_id         = var.reader_group_object_id
  principal_type       = "Group"
}

# Resource group role assignments
resource "azurerm_role_assignment" "role_assignment_resource_group_app_reader_reader" {
  count = var.reader_group_object_id == "" ? 0 : 1

  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app.id
  role_definition_name = "Reader"
  principal_id         = var.reader_group_object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_app_monitoring_reader_reader" {
  count = var.reader_group_object_id == "" ? 0 : 1

  description          = "Role assignment to app resource group."
  scope                = azurerm_resource_group.resource_group_app_monitoring.id
  role_definition_name = "Reader"
  principal_id         = var.reader_group_object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_resource_group_storage_reader_reader" {
  count = var.reader_group_object_id == "" ? 0 : 1

  description          = "Role assignment to storage resource group."
  scope                = "${data.azurerm_subscription.current.id}/resourceGroups/${split("/", var.storage_account_ids.provider)[4]}"
  role_definition_name = "Reader"
  principal_id         = var.reader_group_object_id
  principal_type       = "Group"
}

# Key vault role assignments

# Databricks role assignments
resource "azurerm_role_assignment" "role_assignment_databricks_workspace_reader_reader" {
  count = var.reader_group_object_id == "" ? 0 : 1

  description          = "Role assignment to databricks workspace."
  scope                = var.databricks_workspace_details["engineering"].id
  role_definition_name = "Reader"
  principal_id         = var.reader_group_object_id
  principal_type       = "Group"
}

# AI service role assignments

# AI search service role assignment

# Data factory role assignments

# Fabric role assignments
resource "fabric_workspace_role_assignment" "workspace_role_assignment_viewer_reader" {
  count = var.reader_group_object_id == "" && var.fabric_workspace_details.enabled && var.fabric_capacity_details.enabled ? 1 : 0

  workspace_id = one(module.fabric_workspace[*].fabric_workspace_id)

  principal = {
    id   = var.reader_group_object_id
    type = "Group"
  }
  role = "Viewer"
}

# Storage role assignments
resource "azurerm_role_assignment" "role_assignment_storage_container_provider_blob_data_reader_reader" {
  for_each = var.reader_group_object_id == "" ? {} : var.data_provider_details

  description          = "Role assignment to the provider storage container."
  scope                = azurerm_storage_container.storage_container_provider[each.key].id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = var.reader_group_object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_raw_blob_data_reader_reader" {
  count = var.reader_group_object_id == "" ? 0 : 1

  description          = "Role assignment to the raw storage container."
  scope                = azurerm_storage_container.storage_container_raw.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = var.reader_group_object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_enriched_blob_data_reader_reader" {
  count = var.reader_group_object_id == "" ? 0 : 1

  description          = "Role assignment to the enriched storage container."
  scope                = azurerm_storage_container.storage_container_enriched.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = var.reader_group_object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_curated_blob_data_reader_reader" {
  count = var.reader_group_object_id == "" ? 0 : 1

  description          = "Role assignment to the curated storage container."
  scope                = azurerm_storage_container.storage_container_curated.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = var.reader_group_object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_workspace_blob_data_reader_reader" {
  count = var.reader_group_object_id == "" ? 0 : 1

  description          = "Role assignment to the workspace storage container."
  scope                = azurerm_storage_container.storage_container_workspace.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = var.reader_group_object_id
  principal_type       = "Group"
}
