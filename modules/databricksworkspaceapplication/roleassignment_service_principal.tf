resource "databricks_permission_assignment" "permission_assignment_service_principal" {
  principal_id = databricks_service_principal.service_principal.id

  permissions = ["USER"]
}
