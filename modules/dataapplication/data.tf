data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_location" "current" {
  location = var.location
}

# data "azuread_group" "group_data_provider" {
#   for_each = merge([
#     for key, value in var.data_provider_details : {
#       for group_name in value.group_names :
#       "${key}-${group_name}" => {
#         key        = key
#         group_name = group_name
#       }
#     }
#   ]...)

#   display_name = each.value.group_name
# }

# data "azuread_service_principal" "service_principal_data_provider" {
#   for_each = merge([
#     for key, value in var.data_provider_details : {
#       for service_principal_name in value.service_principal_names :
#       "${key}-${service_principal_name}" => {
#         key                    = key
#         service_principal_name = service_principal_name
#       }
#     }
#   ]...)

#   display_name = each.value.service_principal_name
# }
