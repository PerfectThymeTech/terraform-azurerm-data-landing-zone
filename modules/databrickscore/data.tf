data "databricks_current_user" "current" {}

data "databricks_mws_network_connectivity_config" "network_connectivity_config" {
  provider = databricks.account

  name = var.databricks_network_connectivity_config_name
}

data "azuread_service_principal" "service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  display_name = var.service_principal_name_terraform_plan
}

data "databricks_sql_warehouse" "sql_endpoint_starter" {
  name = contains(var.databricks_compliance_security_profile_standards, "PCI_DSS") ? "Starter Warehouse" : "Serverless Starter Warehouse"
}
