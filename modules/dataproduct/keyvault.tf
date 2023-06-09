data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
  name                = local.names.key_vault
  location            = var.location
  resource_group_name = azurerm_resource_group.data_product_rg.name
  tags                = var.tags

  access_policy                   = []
  enable_rbac_authorization       = true
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
  public_network_access_enabled = false
  purge_protection_enabled      = true
  sku_name                      = "standard"
  soft_delete_retention_days    = 7
  tenant_id                     = data.azurerm_client_config.current.tenant_id
}

resource "time_sleep" "sleep_key_vault" {
  create_duration = "30s"

  depends_on = [
    azurerm_private_endpoint.key_vault_private_endpoint,
    azurerm_role_assignment.current_roleassignment_key_vault
  ]
}

resource "azurerm_key_vault_secret" "key_vault_secret_service_principal_tenant_id" {
  count        = var.service_principal_enabled ? 1 : 0
  name         = "servicePrincipalTenantId"
  key_vault_id = azurerm_key_vault.key_vault.id

  content_type = "text/plain"
  value        = one(azuread_service_principal.service_principal[*].application_tenant_id)

  depends_on = [
    time_sleep.sleep_key_vault
  ]
}

resource "azurerm_key_vault_secret" "key_vault_secret_service_principal_object_id" {
  count        = var.service_principal_enabled ? 1 : 0
  name         = "servicePrincipalObjectId"
  key_vault_id = azurerm_key_vault.key_vault.id

  content_type = "text/plain"
  value        = one(azuread_application.application[*].object_id)

  depends_on = [
    time_sleep.sleep_key_vault
  ]
}

resource "azurerm_key_vault_secret" "key_vault_secret_service_principal_client_id" {
  count        = var.service_principal_enabled ? 1 : 0
  name         = "servicePrincipalClientId"
  key_vault_id = azurerm_key_vault.key_vault.id

  content_type = "text/plain"
  value        = one(azuread_service_principal.service_principal[*].application_id)

  depends_on = [
    time_sleep.sleep_key_vault
  ]
}

resource "azurerm_key_vault_secret" "key_vault_secret_service_principal_client_secret" {
  count        = var.service_principal_enabled ? 1 : 0
  name         = "servicePrincipalClientSecret"
  key_vault_id = azurerm_key_vault.key_vault.id

  content_type = "text/plain"
  value        = one(azuread_service_principal_password.service_principal_password[*].value)

  depends_on = [
    time_sleep.sleep_key_vault
  ]
}

resource "azurerm_key_vault_secret" "key_vault_secret_security_group_display_name" {
  count        = local.conditions.security_group ? 1 : 0
  name         = "securityGroupDisplayName"
  key_vault_id = azurerm_key_vault.key_vault.id

  content_type = "text/plain"
  value        = one(data.azuread_group.security_group[*].display_name)

  depends_on = [
    time_sleep.sleep_key_vault
  ]
}

resource "azurerm_key_vault_secret" "key_vault_secret_security_group_object_id" {
  count        = local.conditions.security_group ? 1 : 0
  name         = "securityGroupObjectId"
  key_vault_id = azurerm_key_vault.key_vault.id

  content_type = "text/plain"
  value        = one(data.azuread_group.security_group[*].object_id)

  depends_on = [
    time_sleep.sleep_key_vault
  ]
}

resource "azurerm_private_endpoint" "key_vault_private_endpoint" {
  count               = var.network_enabled && length(var.subnets) > 0 ? 1 : 0
  name                = "${azurerm_key_vault.key_vault.name}-pe"
  location            = var.location
  resource_group_name = azurerm_key_vault.key_vault.resource_group_name
  tags                = var.tags

  custom_network_interface_name = "${azurerm_key_vault.key_vault.name}-nic"
  private_service_connection {
    name                           = "${azurerm_key_vault.key_vault.name}-pe"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.key_vault.id
    subresource_names              = ["vault"]
  }
  subnet_id = values(azurerm_subnet.subnets)[0].id
  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_id_key_vault == "" ? [] : [1]
    content {
      name = "${azurerm_key_vault.key_vault.name}-arecord"
      private_dns_zone_ids = [
        var.private_dns_zone_id_key_vault
      ]
    }
  }
}
