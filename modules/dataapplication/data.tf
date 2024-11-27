data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_location" "current" {
  location = var.location
}

data "azuread_service_principal" "service_principal_databricks" {
  client_id = local.databricks_enterprise_application_id
}
