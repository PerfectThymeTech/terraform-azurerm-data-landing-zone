# Resource group role assignments

# Key vault role assignments

# Databricks role assignments

# AI service role assignments

# AI search service role assignment

# Data factory role assignments

# Storage role assignments
resource "azurerm_role_assignment" "role_assignment_storage_container_external_blob_data_provider_service_principal" {
  for_each = merge([
    for key, value in var.data_provider_details : {
      for service_principal_name in value.service_principal_names :
      "${key}-${service_principal_name}" => {
        key                    = key
        service_principal_name = service_principal_name
      }
    }
  ]...)

  description          = "Role assignment to the external storage container for data provider."
  scope                = azurerm_storage_container.storage_container_external[each.value.key].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_service_principal.service_principal_data_provider[each.key].object_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "role_assignment_storage_container_external_blob_data_provider_group" {
  for_each = merge([
    for key, value in var.data_provider_details : {
      for group_name in value.group_names :
      "${key}-${group_name}" => {
        key        = key
        group_name = group_name
      }
    }
  ]...)

  description          = "Role assignment to the external storage container for data provider."
  scope                = azurerm_storage_container.storage_container_external[each.value.key].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_group.group_data_provider[each.key].object_id
  principal_type       = "Group"
}
