resource "databricks_permission_assignment" "permission_assignment_admin" {
  principal_id = data.databricks_group.group_admin.id

  permissions = ["USER"]
}

resource "databricks_permissions" "permissions_directory_admin" {
  directory_path = databricks_directory.directory.path

  access_control {
    group_name       = data.databricks_group.group_admin.display_name
    permission_level = "CAN_MANAGE"
  }
}
