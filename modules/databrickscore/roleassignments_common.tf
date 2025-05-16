resource "databricks_permissions" "permissions_engineering_sql_endpoint_starter" {
  sql_endpoint_id = data.databricks_sql_warehouse.sql_endpoint_engineering_starter.id

  # Admin permissions
  access_control {
    service_principal_name = data.databricks_current_user.current_engineering.user_name
    permission_level       = "IS_OWNER"
  }
}
