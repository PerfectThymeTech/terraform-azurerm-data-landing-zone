resource "databricks_permission_assignment" "permission_assignment_admin" {
  principal_id = data.databricks_group.group_admin.id

  permissions = ["USER"]
}
