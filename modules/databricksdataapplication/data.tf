# data "databricks_current_user" "current_user" {}

data "azuread_service_principal" "service_principal" {
  count = var.service_principal_name == "" ? 0 : 1

  display_name = var.service_principal_name
}

data "databricks_group" "group_admin" {
  provider = databricks.account

  display_name = var.admin_group_name
}

data "databricks_group" "group_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  provider = databricks.account

  display_name = var.developer_group_name
}

data "databricks_group" "group_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  provider = databricks.account

  display_name = var.reader_group_name
}

data "databricks_group" "group_data_provider" {
  for_each = merge([
    for key, value in var.data_provider_details : {
      for group_name in value.group_names :
      "${key}-${group_name}" => {
        key        = key
        group_name = group_name
      } if value.databricks_catalog.enabled
    }
  ]...)

  provider = databricks.account

  display_name = each.value.group_name
}

data "databricks_service_principal" "service_principal_data_provider" {
  for_each = merge([
    for key, value in var.data_provider_details : {
      for service_principal_name in value.service_principal_names :
      "${key}-${service_principal_name}" => {
        key                    = key
        service_principal_name = service_principal_name
      } if value.databricks_catalog.enabled
    }
  ]...)

  provider = databricks.account

  display_name = each.value.service_principal_name
}
