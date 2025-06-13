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
  # Service principal data factory permissions
  dynamic "access_control" {
    for_each = var.databricks_data_factory_details.data_factory_enabled ? [1] : []
    content {
      service_principal_name = one(databricks_service_principal.service_principal_data_factory[*].application_id)
      permission_level       = "CAN_MANAGE"
    }
  }
  # UAI permissions
  access_control {
    service_principal_name = databricks_service_principal.service_principal_uai.application_id
    permission_level       = "CAN_MANAGE"
  }

  depends_on = [
    databricks_permission_assignment.permission_assignment_admin,
    databricks_permission_assignment.permission_assignment_developer,
    databricks_permission_assignment.permission_assignment_reader,
    databricks_permission_assignment.permission_assignment_service_principal_data_factory,
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
  # Service principal data factory permissions
  dynamic "access_control" {
    for_each = var.databricks_data_factory_details.data_factory_enabled ? [1] : []
    content {
      service_principal_name = one(databricks_service_principal.service_principal_data_factory[*].application_id)
      permission_level       = "CAN_USE"
    }
  }
  # UAI permissions
  access_control {
    service_principal_name = databricks_service_principal.service_principal_uai.application_id
    permission_level       = "CAN_USE"
  }

  depends_on = [
    databricks_permission_assignment.permission_assignment_admin,
    databricks_permission_assignment.permission_assignment_developer,
    databricks_permission_assignment.permission_assignment_reader,
    databricks_permission_assignment.permission_assignment_service_principal_data_factory,
    databricks_permission_assignment.permission_assignment_uai,
  ]
}

resource "databricks_permissions" "permissions_sql_endpoint" {
  for_each = var.databricks_sql_endpoint_details

  sql_endpoint_id = databricks_sql_endpoint.sql_endpoint[each.key].id

  # Admin permissions
  access_control {
    group_name       = data.databricks_group.group_admin.display_name
    permission_level = "CAN_MONITOR"
  }
  # Developer permissions
  dynamic "access_control" {
    for_each = var.developer_group_name == "" ? [] : [1]
    content {
      group_name       = one(data.databricks_group.group_developer[*].display_name)
      permission_level = "CAN_MONITOR"
    }
  }
  # Reader permissions
  dynamic "access_control" {
    for_each = var.reader_group_name == "" ? [] : [1]
    content {
      group_name       = one(data.databricks_group.group_reader[*].display_name)
      permission_level = "CAN_USE"
    }
  }
  # Service principal data factory permissions
  dynamic "access_control" {
    for_each = var.databricks_data_factory_details.data_factory_enabled ? [1] : []
    content {
      service_principal_name = one(databricks_service_principal.service_principal_data_factory[*].application_id)
      permission_level       = "CAN_MONITOR"
    }
  }
  # UAI permissions
  access_control {
    service_principal_name = databricks_service_principal.service_principal_uai.application_id
    permission_level       = "CAN_MONITOR"
  }

  depends_on = [
    databricks_permission_assignment.permission_assignment_admin,
    databricks_permission_assignment.permission_assignment_developer,
    databricks_permission_assignment.permission_assignment_reader,
    databricks_permission_assignment.permission_assignment_service_principal_data_factory,
    databricks_permission_assignment.permission_assignment_uai,
  ]
}

resource "databricks_access_control_rule_set" "access_control_rule_set_budget_policy" {
  name = "accounts/${var.databricks_account_id}/budgetPolicies/${databricks_budget_policy.budget_policy.policy_id}/ruleSets/default"

  grant_rules {
    principals = compact([
      data.databricks_group.group_admin.acl_principal_id,
      one(data.databricks_group.group_developer[*].acl_principal_id),
      one(data.databricks_group.group_reader[*].acl_principal_id),
      one(databricks_service_principal.service_principal_data_factory[*].acl_principal_id),
      databricks_service_principal.service_principal_uai.acl_principal_id,
      var.databricks_service_principal_terraform_plan_details.acl_principal_id,
    ])
    role = "roles/budgetPolicy.user"
  }

  depends_on = [
    databricks_permission_assignment.permission_assignment_admin,
    databricks_permission_assignment.permission_assignment_developer,
    databricks_permission_assignment.permission_assignment_reader,
    databricks_permission_assignment.permission_assignment_service_principal_data_factory,
    databricks_permission_assignment.permission_assignment_uai,
  ]
}

resource "databricks_access_control_rule_set" "access_control_rule_set_service_principal_uai" {
  name = "accounts/${var.databricks_account_id}/servicePrincipals/${databricks_service_principal.service_principal_uai.application_id}/ruleSets/default"

  grant_rules {
    principals = compact([
      data.databricks_group.group_admin.acl_principal_id,
      one(data.databricks_group.group_developer[*].acl_principal_id),
      one(data.databricks_group.group_reader[*].acl_principal_id),
      one(databricks_service_principal.service_principal_data_factory[*].acl_principal_id),
      databricks_service_principal.service_principal_uai.acl_principal_id,
      var.databricks_service_principal_terraform_plan_details.acl_principal_id,
    ])
    role = "roles/servicePrincipal.user"
  }
}
