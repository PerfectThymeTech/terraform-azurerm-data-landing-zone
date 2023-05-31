resource "databricks_secret_scope" "platform_secret_scope" {
  name = "platform-secret-scope"

  backend_type = "AZURE_KEYVAULT"
  keyvault_metadata {
    dns_name    = var.key_vault_uri
    resource_id = var.key_vault_id
  }

  depends_on = [
    var.dependencies
  ]
}

resource "time_sleep" "sleep_metastore_assignment" {
  create_duration = "30s"

  depends_on = [
    databricks_metastore_assignment.metastore_assignment
  ]
}

resource "databricks_mws_permission_assignment" "permission_assignment" {
  count        = var.databricks_admin_groupname != "" ? 1 : 0
  workspace_id = var.databricks_workspace_id
  principal_id = one(data.databricks_group.group[*].id)
  permissions = [
    "ADMIN"
  ]

  provider = databricks.account
  depends_on = [
    time_sleep.sleep_metastore_assignment
  ]
}

resource "time_sleep" "sleep_permission_assignment" {
  create_duration = "30s"

  depends_on = [
    databricks_mws_permission_assignment.permission_assignment
  ]
}

resource "databricks_secret_acl" "secret_acl" {
  count      = var.databricks_admin_groupname != "" ? 1 : 0
  principal  = one(data.databricks_group.group[*].display_name)
  permission = "MANAGE"
  scope      = databricks_secret_scope.platform_secret_scope.name

  depends_on = [
    time_sleep.sleep_permission_assignment
  ]
}
