resource "databricks_permission_assignment" "permission_assignment_service_principal_terraform_plan" {
  principal_id = one(data.databricks_service_principal.service_principal_terraform_plan[*].id)
  permissions  = ["USER"]
}

resource "databricks_secret_acl" "secret_acl_service_principal_terraform_plan" {
  principal  = one(data.databricks_service_principal.service_principal[*].application_id)
  permission = "READ"
  scope      = databricks_secret_scope.secret_scope.id

  depends_on = [
    databricks_permission_assignment.permission_assignment_service_principal_terraform_plan,
  ]
}
