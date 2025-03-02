resource "databricks_service_principal" "service_principal_terraform_plan" {
  provider = databricks.account

  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

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
