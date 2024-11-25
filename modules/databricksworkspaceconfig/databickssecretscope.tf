resource "databricks_secret_scope" "secret_scope" {
  count = var.databricks_keyvault_secret_scope_details.key_vault_uri != "" && var.databricks_keyvault_secret_scope_details.key_vault_id != "" ? 1 : 0

  name = "${local.prefix}-secret-scope"

  backend_type = "AZURE_KEYVAULT"
  keyvault_metadata {
    dns_name    = var.databricks_keyvault_secret_scope_details.key_vault_uri
    resource_id = var.databricks_keyvault_secret_scope_details.key_vault_id
  }
}

# resource "databricks_secret_acl" "secret_acl" {
#   count      = var.databricks_admin_groupname != "" ? 1 : 0
  
#   principal  = one(data.databricks_group.group[*].display_name)
#   permission = "MANAGE"
#   scope      = databricks_secret_scope.platform_secret_scope.name

#   depends_on = [
#     time_sleep.sleep_permission_assignment
#   ]
# }
