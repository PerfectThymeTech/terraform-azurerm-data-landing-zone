resource "databricks_permission_assignment" "permission_assignment_engineering_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  principal_id = one(databricks_service_principal.service_principal_terraform_plan[*].id)
  permissions  = ["ADMIN"]
}

resource "databricks_service_principal_role" "service_principal_role_account_admin_terraform_plan" {
  provider = databricks.account

  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  service_principal_id = one(databricks_service_principal.service_principal_terraform_plan[*].id)
  role                 = "account_admin"
}
