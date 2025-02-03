# Key vault role assignments
resource "azurerm_role_assignment" "role_assignment_key_vault_secrets_user_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  description          = "Role assignment to key vault to read secrets."
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = one(data.azuread_service_principal.service_principal_terraform_plan[*].object_id)
  principal_type       = "ServicePrincipal"
}
