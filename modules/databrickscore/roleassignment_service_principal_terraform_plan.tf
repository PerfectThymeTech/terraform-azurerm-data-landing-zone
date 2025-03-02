resource "databricks_permission_assignment" "permission_assignment_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  principal_id = one(data.databricks_service_principal.service_principal_terraform_plan[*].id)
  permissions  = ["ADMIN"]
}

resource "databricks_service_principal_role" "service_principal_role_account_admin_terraform_plan" {
  service_principal_id = data.databricks_service_principal.application.id
  role                 = "account_admin"
}
