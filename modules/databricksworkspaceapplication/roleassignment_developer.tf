resource "databricks_permission_assignment" "permission_assignment_developer" {
  principal_id = data.databricks_group.group_developer.id

  permissions = ["USER"]
}

resource "databricks_permissions" "permissions_directory_developer" {
  directory_path = databricks_directory.directory.path

  access_control {
    group_name       = data.databricks_group.group_developer.display_name
    permission_level = "CAN_MANAGE"
  }
}
