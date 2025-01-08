resource "databricks_permission_assignment" "permission_assignment_service_principal" {
  principal_id = databricks_service_principal.service_principal.id
  permissions  = ["USER"]
}

resource "databricks_secret_acl" "secret_acl_service_principal" {
  principal  = databricks_service_principal.service_principal.application_id
  permission = "READ"
  scope      = databricks_secret_scope.secret_scope.id
}
