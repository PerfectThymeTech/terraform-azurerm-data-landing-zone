# Resource group role assignments

# Key vault role assignments

# Databricks role assignments

# AI service role assignments

# AI search service role assignment

# Data factory role assignments

# Storage role assignments
resource "azurerm_role_assignment" "role_assignment_storage_container_provider_blob_data_provider_service_principal" {
  for_each = merge([
    for key, value in var.data_provider_details : {
      for service_principal_object_id in value.service_principal_object_ids :
      "${key}-${service_principal_object_id}" => {
        key                         = key
        service_principal_object_id = service_principal_object_id
      }
    }
  ]...)

  description          = "Role assignment to the provider storage container for data provider."
  scope                = azurerm_storage_container.storage_container_provider[each.value.key].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value.service_principal_object_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_provider_blob_data_provider_group" {
  for_each = merge([
    for key, value in var.data_provider_details : {
      for group_object_id in value.group_object_ids :
      "${key}-${group_object_id}" => {
        key             = key
        group_object_id = group_object_id
      }
    }
  ]...)

  description          = "Role assignment to the provider storage container for data provider."
  scope                = azurerm_storage_container.storage_container_provider[each.value.key].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value.group_object_id
  principal_type       = "Group"
}
