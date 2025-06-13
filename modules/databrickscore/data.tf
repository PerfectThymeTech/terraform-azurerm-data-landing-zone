data "databricks_current_user" "current_engineering" {}

data "databricks_service_principal" "service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  provider = databricks.account

  display_name = var.service_principal_name_terraform_plan
}

data "databricks_mws_network_connectivity_config" "network_connectivity_config" {
  provider = databricks.account

  name = var.databricks_network_connectivity_config_name
}

data "databricks_sql_warehouse" "sql_endpoint_engineering_starter" {
  name = contains(var.databricks_compliance_security_profile_standards, "PCI_DSS") ? "Starter Warehouse" : "Serverless Starter Warehouse"
}

data "azurerm_databricks_access_connector" "databricks_access_connector_engineering" {
  name                = local.databricks_access_connector_engineering.name
  resource_group_name = local.databricks_access_connector_engineering.resource_group_name
}
