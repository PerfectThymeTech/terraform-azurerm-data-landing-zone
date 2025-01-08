resource "databricks_permission_assignment" "permission_assignment_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  principal_id = one(data.databricks_group.group_developer[*].id)
  permissions  = ["USER"]
}

resource "databricks_secret_acl" "secret_acl_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  principal  = one(data.databricks_group.group_developer[*].id)
  permission = "READ"
  scope      = databricks_secret_scope.secret_scope.id
}
