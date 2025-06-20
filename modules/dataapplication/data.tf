data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_location" "current" {
  location = var.location
}

data "azuread_service_principal" "service_principal_databricks" {
  client_id = local.databricks_enterprise_application_id
}

data "azuread_service_principal" "service_principal" {
  count = var.service_principal_name == "" ? 0 : 1

  display_name = var.service_principal_name
}

data "azuread_service_principal" "service_principal_data_factory" {
  count = var.data_factory_details.enabled ? 1 : 0

  object_id = one(module.data_factory[*].data_factory_principal_id)
}

data "azuread_service_principal" "service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  display_name = var.service_principal_name_terraform_plan
}

data "azuread_group" "group_admin" {
  display_name     = var.admin_group_name
  security_enabled = true
}

data "azuread_group" "group_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  display_name     = var.developer_group_name
  security_enabled = true
}

data "azuread_group" "group_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  display_name     = var.reader_group_name
  security_enabled = true
}

data "azuread_group" "group_data_provider" {
  for_each = merge([
    for key, value in var.data_provider_details : {
      for group_name in value.group_names :
      "${key}-${group_name}" => {
        key        = key
        group_name = group_name
      }
    }
  ]...)

  display_name = each.value.group_name
}

data "azuread_service_principal" "service_principal_data_provider" {
  for_each = merge([
    for key, value in var.data_provider_details : {
      for service_principal_name in value.service_principal_names :
      "${key}-${service_principal_name}" => {
        key                    = key
        service_principal_name = service_principal_name
      }
    }
  ]...)

  display_name = each.value.service_principal_name
}
