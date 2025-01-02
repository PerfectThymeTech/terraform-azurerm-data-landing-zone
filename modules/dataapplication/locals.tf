locals {
  # General locals
  prefix                           = "${lower(var.prefix)}-${lower(var.app_name)}-${var.environment}"
  budget_start_date_rotation_years = 9

  # Databricks locals
  databricks_enterprise_application_id = "2ff814a6-3304-4ab8-85cb-cd0e6f879c1d"
}
