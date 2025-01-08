resource "databricks_permission_assignment" "permission_assignment_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  principal_id = one(data.databricks_group.group_developer[*].id)
  permissions  = ["USER"]
}
