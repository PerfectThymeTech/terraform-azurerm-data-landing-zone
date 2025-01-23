data "azuread_service_principal" "service_principal" {
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
