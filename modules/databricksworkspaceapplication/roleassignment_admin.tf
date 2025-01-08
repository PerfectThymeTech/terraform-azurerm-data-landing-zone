resource "databricks_permission_assignment" "permission_assignment_admin" {
  principal_id = data.databricks_group.group_admin.id
  permissions  = ["USER"]
}

resource "databricks_secret_acl" "secret_acl_admin" {
  principal  = data.databricks_group.group_admin.display_name
  permission = "READ"
  scope      = databricks_secret_scope.secret_scope.id
}
