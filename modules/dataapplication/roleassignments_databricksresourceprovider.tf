# Key Vault Role Assignments
resource "azurerm_role_assignment" "databricksresourceprovider_role_assignment_key_vault_secrets_user" {
  description          = "Role assignment to enable key vault backed secret scope in Databricks."
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = data.azuread_service_principal.service_principal_databricks.object_id
  principal_type       = "ServicePrincipal"
}
