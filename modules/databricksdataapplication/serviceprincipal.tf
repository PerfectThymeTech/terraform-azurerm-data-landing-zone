resource "databricks_service_principal" "service_principal" {
  provider = databricks.account

  application_id             = data.azuread_service_principal.service_principal.client_id
  display_name               = "sp-${data.azuread_service_principal.service_principal.display_name}"
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
  provider = databricks.account

  application_id             = var.databricks_data_factory_details.data_factory_principal_id
  display_name               = "adf-${var.databricks_data_factory_details.data_factory_name}"
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
