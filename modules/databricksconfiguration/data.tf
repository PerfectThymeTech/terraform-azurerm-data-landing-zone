data "azurerm_client_config" "current" {}

data "databricks_group" "group" {
  count        = var.databricks_admin_groupname != "" ? 1 : 0
  display_name = var.databricks_admin_groupname

  provider = databricks.account
}
