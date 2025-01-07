resource "databricks_permission_assignment" "permission_assignment_reader" {
  principal_id = data.databricks_group.group_reader.id

  permissions = ["USER"]
}
