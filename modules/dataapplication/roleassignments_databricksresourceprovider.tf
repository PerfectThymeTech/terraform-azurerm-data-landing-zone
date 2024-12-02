# Key Vault Role Assignments
resource "azurerm_role_assignment" "databricksresourceprovider_role_assignment_key_vault_secrets_user" {
  # count = var.subnet_id_databricks_private != "" && var.subnet_id_databricks_public != "" ? 1 : 0

  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = data.azuread_service_principal.service_principal_databricks.object_id
  principal_type       = "ServicePrincipal"
}
