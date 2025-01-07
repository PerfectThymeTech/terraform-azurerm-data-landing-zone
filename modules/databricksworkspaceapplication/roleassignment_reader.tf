resource "databricks_permission_assignment" "permission_assignment_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  principal_id = one(data.databricks_group.group_reader[*].id)
  permissions  = ["USER"]
}
