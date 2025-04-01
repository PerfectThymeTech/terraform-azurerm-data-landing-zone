# Key vault role assignments
resource "azurerm_role_assignment" "role_assignment_key_vault_secrets_user_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  description          = "Role assignment to key vault to read secrets."
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = one(data.azuread_service_principal.service_principal_terraform_plan[*].object_id)
  principal_type       = "ServicePrincipal"
}

# AI search service role assignment
resource "azurerm_role_assignment" "role_assignment_search_service_contributor_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan != "" && var.search_service_details.enabled ? 1 : 0

  description          = "Role assignment to load documents and run indexing jobs in AI Search."
  scope                = one(module.ai_search[*].search_service_id)
  role_definition_name = "Search Service Contributor"
  principal_id         = one(data.azuread_service_principal.service_principal_terraform_plan[*].object_id)
  principal_type       = "ServicePrincipal"
}

# Fabric role assignments
resource "fabric_workspace_role_assignment" "workspace_role_assignment_member_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan != "" && var.fabric_workspace_details.enabled && var.fabric_capacity_details.enabled ? 1 : 0

  workspace_id = one(module.fabric_workspace[*].fabric_workspace_id)

  principal = {
    id   = one(data.azuread_service_principal.service_principal_terraform_plan[*].object_id)
    type = "ServicePrincipal"
  }
  role = "Member"
}
