data "azurerm_client_config" "current" {}

data "azuread_service_principal" "service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  display_name = var.service_principal_name_terraform_plan
}
