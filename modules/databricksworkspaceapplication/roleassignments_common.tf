resource "databricks_permissions" "permissions_directory_developer" {
  directory_path = databricks_directory.directory.path

  # Admin permissions
  access_control {
    group_name       = data.databricks_group.group_admin.display_name
    permission_level = "CAN_MANAGE"
  }
  # Developer permissions
  dynamic "access_control" {
    for_each = var.developer_group_name == "" ? [] : [1]
    content {
      group_name       = one(data.databricks_group.group_developer[*].display_name)
      permission_level = "CAN_MANAGE"
    }
  }
  # Reader permissions
  dynamic "access_control" {
    for_each = var.reader_group_name == "" ? [] : [1]
    content {
      group_name       = one(data.databricks_group.group_reader[*].display_name)
      permission_level = "CAN_READ"
    }
  }
  # Service principal permissions
  access_control {
    service_principal_name = databricks_service_principal.service_principal.display_name
    permission_level       = "CAN_MANAGE"
  }
}
