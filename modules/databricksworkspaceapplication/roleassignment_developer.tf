resource "databricks_permission_assignment" "permission_assignment_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  principal_id = one(data.databricks_group.group_developer[*].id)
  permissions  = ["USER"]
}

resource "databricks_permissions" "permissions_directory_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  directory_path = databricks_directory.directory.path

  access_control {
    group_name       = one(data.databricks_group.group_developer[*].display_name)
    permission_level = "CAN_MANAGE"
  }
}
