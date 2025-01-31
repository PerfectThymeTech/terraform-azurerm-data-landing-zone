resource "databricks_secret_scope" "secret_scope" {
  name = "${local.prefix}-secret-scope"

  backend_type = "AZURE_KEYVAULT"
  keyvault_metadata {
    dns_name    = var.databricks_keyvault_secret_scope_details.key_vault_uri
    resource_id = var.databricks_keyvault_secret_scope_details.key_vault_id
  }
}
