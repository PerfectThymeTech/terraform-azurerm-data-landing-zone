resource "databricks_service_principal" "service_principal" {
  count = var.service_principal_name == "" ? 0 : 1

  application_id             = one(data.azuread_service_principal.service_principal[*].client_id)
  display_name               = one(data.azuread_service_principal.service_principal[*].display_name)
  active                     = true
  allow_cluster_create       = false
  allow_instance_pool_create = false
  databricks_sql_access      = false
  workspace_access           = false
  force                      = true
  force_delete_repos         = false
  force_delete_home_dir      = false
  disable_as_user_deletion   = false
}

resource "databricks_service_principal" "service_principal_uai" {
  application_id             = var.databricks_user_assigned_identity_details.user_assigned_identity_principal_id
  display_name               = var.databricks_user_assigned_identity_details.user_assigned_identity_name
  active                     = true
  allow_cluster_create       = false
  allow_instance_pool_create = false
  databricks_sql_access      = false
  workspace_access           = false
  force                      = true
  force_delete_repos         = false
  force_delete_home_dir      = false
  disable_as_user_deletion   = false
}

resource "databricks_service_principal" "service_principal_data_factory" {
  count = var.databricks_data_factory_details.data_factory_enabled ? 1 : 0

  application_id             = var.databricks_data_factory_details.data_factory_principal_id
  display_name               = var.databricks_data_factory_details.data_factory_name
  active                     = true
  allow_cluster_create       = false
  allow_instance_pool_create = false
  databricks_sql_access      = false
  workspace_access           = false
  force                      = true
  force_delete_repos         = false
  force_delete_home_dir      = false
  disable_as_user_deletion   = false
}
