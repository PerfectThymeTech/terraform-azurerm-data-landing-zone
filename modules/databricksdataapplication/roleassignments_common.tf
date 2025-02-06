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
  dynamic "access_control" {
    for_each = var.service_principal_name == "" ? [] : [1]
    content {
      service_principal_name = one(databricks_service_principal.service_principal[*].application_id)
      permission_level       = "CAN_MANAGE"
    }
  }
  # Service principal data factory permissions
  dynamic "access_control" {
    for_each = var.databricks_data_factory_details.data_factory_enabled ? [1] : [0]
    content {
      service_principal_name = one(databricks_service_principal.service_principal_data_factory[*].application_id)
      permission_level       = "CAN_MANAGE"
    }
  }
  # UAI permissions
  access_control {
    group_name       = databricks_service_principal.service_principal_uai.application_id
    permission_level = "CAN_MANAGE"
  }

  depends_on = [
    databricks_permission_assignment.permission_assignment_admin,
    databricks_permission_assignment.permission_assignment_developer,
    databricks_permission_assignment.permission_assignment_reader,
    databricks_permission_assignment.permission_assignment_service_principal,
    databricks_permission_assignment.permission_assignment_uai,
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
  # Service principal permissions
  dynamic "access_control" {
    for_each = var.service_principal_name == "" ? [] : [1]
    content {
      service_principal_name = one(databricks_service_principal.service_principal[*].application_id)
      permission_level       = "CAN_USE"
    }
  }
  # Service principal data factory permissions
  dynamic "access_control" {
    for_each = var.databricks_data_factory_details.data_factory_enabled ? [1] : [0]
    content {
      service_principal_name = one(databricks_service_principal.service_principal_data_factory[*].application_id)
      permission_level       = "CAN_USE"
    }
  }
  # UAI permissions
  access_control {
    group_name       = databricks_service_principal.service_principal_uai.application_id
    permission_level = "CAN_USE"
  }

  depends_on = [
    databricks_permission_assignment.permission_assignment_admin,
    databricks_permission_assignment.permission_assignment_developer,
    databricks_permission_assignment.permission_assignment_reader,
    databricks_permission_assignment.permission_assignment_service_principal,
    databricks_permission_assignment.permission_assignment_uai,
  ]
}

# resource "databricks_permissions" "permissions_budget" { # Not supported yet by provider because of missing APIs: https://github.com/databricks/terraform-provider-databricks/issues/4180
#   budget_id = databricks_budget.budget.id

#   # Admin permissions
#   access_control {
#     group_name       = data.databricks_group.group_admin.display_name
#     permission_level = "CAN_USE"
#   }
#   # Developer permissions
#   dynamic "access_control" {
#     for_each = var.developer_group_name == "" ? [] : [1]
#     content {
#       group_name       = one(data.databricks_group.group_developer[*].display_name)
#       permission_level = "CAN_USE"
#     }
#   }
#   # Reader permissions
#   dynamic "access_control" {
#     for_each = var.reader_group_name == "" ? [] : [1]
#     content {
#       group_name       = one(data.databricks_group.group_reader[*].display_name)
#       permission_level = "CAN_USE"
#     }
#   }
#   # Service principal permissions
#   dynamic "access_control" {
#     for_each = var.service_principal_name == "" ? [] : [1]
#     content {
#       service_principal_name = one(databricks_service_principal.service_principal[*].application_id)
#       permission_level       = "CAN_USE"
#     }
#   }
#   # Service principal data factory permissions
#   dynamic "access_control" {
#     for_each = var.databricks_data_factory_details.data_factory_enabled ? [1] : [0]
#     content {
#       service_principal_name = one(databricks_service_principal.service_principal_data_factory[*].application_id)
#       permission_level       = "CAN_USE"
#     }
#   }
#   # UAI permissions
#   access_control {
#     group_name       = databricks_service_principal.service_principal_uai.application_id
#     permission_level = "CAN_USE"
#   }


#   depends_on = [
#     databricks_permission_assignment.permission_assignment_admin,
#     databricks_permission_assignment.permission_assignment_developer,
#     databricks_permission_assignment.permission_assignment_reader,
#     databricks_permission_assignment.permission_assignment_service_principal,
#     databricks_permission_assignment.permission_assignment_uai,
#   ]
# }
