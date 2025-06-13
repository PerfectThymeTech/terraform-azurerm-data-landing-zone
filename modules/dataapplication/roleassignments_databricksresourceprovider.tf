# Key Vault Role Assignments
resource "azurerm_role_assignment" "databricksresourceprovider_role_assignment_key_vault_secrets_user" {
  count = var.databricks_resourceprovider_object_id == "" ? 0 : 1

  description          = "Role assignment to enable key vault backed secret scope in Databricks."
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.databricks_resourceprovider_object_id
  principal_type       = "ServicePrincipal"
}
