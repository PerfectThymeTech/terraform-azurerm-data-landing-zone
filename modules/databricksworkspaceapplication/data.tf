data "azuread_service_principal" "service_principal" {
  display_name = var.service_principal_name
}

data "databricks_group" "group_admin" {
  provider = databricks.account

  display_name = var.admin_group_name
}

data "databricks_group" "group_developer" {
  provider = databricks.account

  display_name = var.developer_group_name
}

data "databricks_group" "group_reader" {
  provider = databricks.account

  display_name = var.reader_group_name
}
