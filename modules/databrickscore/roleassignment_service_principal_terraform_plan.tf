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

resource "databricks_grant" "grant_catalog_engineering_default_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  catalog   = databricks_catalog.catalog_engineering_default.id
  principal = one(databricks_service_principal.service_principal_terraform_plan[*].application_id)
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "EXTERNAL_USE_SCHEMA", # Not allowed as these users should not be external
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Prerequisite
    "USE_CATALOG",
    # "USE_SCHEMA",

    # Metadata
    "BROWSE",
    # "APPLY_TAG", # Only allow system assigned tags at catalog level

    # Read
    # "EXECUTE",
    # "READ_VOLUME",
    # "SELECT",

    # Edit
    # "MODIFY",
    # "REFRESH",
    # "WRITE_VOLUME",

    # Create
    # "CREATE_FUNCTION",
    # "CREATE_MATERIALIZED_VIEW",
    # "CREATE_MODEL",
    # "CREATE_SCHEMA",
    # "CREATE_TABLE",
    # "CREATE_VOLUME",
  ]
}

resource "databricks_grant" "grant_external_location_provider_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  external_location = databricks_external_location.external_location_engineering_default.id
  principal         = one(databricks_service_principal.service_principal_terraform_plan[*].application_id)
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Metadata
    "BROWSE",

    # Read
    "READ_FILES",

    # Edit
    # "WRITE_FILES",

    # Create
    # "CREATE_EXTERNAL_TABLE",
    # "CREATE_EXTERNAL_VOLUME",
    # "CREATE_FOREIGN_SECURABLE",
    # "CREATE_MANAGED_STORAGE",
  ]
}

resource "databricks_grant" "grant_storage_credential_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  storage_credential = databricks_storage_credential.storage_credential_engineering_default.id
  principal          = one(databricks_service_principal.service_principal_terraform_plan[*].application_id)
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Read
    "READ_FILES",

    # Edit
    # "WRITE_FILES",

    # Create
    # "CREATE EXTERNAL LOCATION",
    # "CREATE_EXTERNAL_TABLE",
  ]
}
