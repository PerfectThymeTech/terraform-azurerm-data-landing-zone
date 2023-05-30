data "azuread_client_config" "current" {}

data "azuread_group" "security_group" {
  count            = local.conditions.security_group ? 1 : 0
  display_name     = var.security_group_display_name
  security_enabled = true
}

resource "azuread_application" "application" {
  count        = var.service_principal_enabled ? 1 : 0
  display_name = local.names.service_principal
  owners       = [data.azuread_client_config.current.object_id]

  description = "Data Product Application - ${var.data_product_name}"
  feature_tags {
    custom_single_sign_on = false
    enterprise            = false
    gallery               = false
    hide                  = false
  }
  identifier_uris  = []
  sign_in_audience = "AzureADMyOrg"
}

resource "azuread_service_principal" "service_principal" {
  count          = var.service_principal_enabled ? 1 : 0
  application_id = one(azuread_application.application[*].application_id)
  owners         = [data.azuread_client_config.current.object_id]

  account_enabled              = true
  app_role_assignment_required = false
  description                  = "Data Product Service Principal - ${var.data_product_name}"
  feature_tags {
    custom_single_sign_on = false
    enterprise            = false
    gallery               = false
    hide                  = false
  }
  notes = "Azure RBAC"
}

resource "time_rotating" "rotation" {
  rotation_days = 90
}

resource "azuread_service_principal_password" "service_principal_password" {
  count                = var.service_principal_enabled ? 1 : 0
  service_principal_id = one(azuread_service_principal.service_principal[*].id)
  display_name         = "Azure RBAC"
  end_date_relative    = "2400h"
  rotate_when_changed = {
    rotation = time_rotating.rotation.id
  }
}
