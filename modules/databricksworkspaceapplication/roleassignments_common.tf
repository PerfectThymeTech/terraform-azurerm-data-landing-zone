resource "databricks_permissions" "permissions_directory" {
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

  depends_on = [
    databricks_permission_assignment.permission_assignment_admin,
    databricks_permission_assignment.permission_assignment_developer,
    databricks_permission_assignment.permission_assignment_reader,
    databricks_permission_assignment.permission_assignment_service_principal,
  ]
}

resource "databricks_permissions" "permissions_cluster_policy" {
  for_each = local.databricks_cluster_policy_definitions

  cluster_policy_id = databricks_cluster_policy.cluster_policy[each.key].id

  # Admin permissions
  access_control {
    group_name       = data.databricks_group.group_admin.display_name
    permission_level = "CAN_USE"
  }
  # # Service principal permissions
  # access_control {
  #   service_principal_name = databricks_service_principal.service_principal.display_name
  #   permission_level       = "CAN_USE"
  # }

  depends_on = [
    databricks_permission_assignment.permission_assignment_admin,
    databricks_permission_assignment.permission_assignment_developer,
    databricks_permission_assignment.permission_assignment_reader,
    databricks_permission_assignment.permission_assignment_service_principal,
  ]
}
