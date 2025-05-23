resource "databricks_secret_acl" "secret_acl_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  principal  = var.databricks_service_principal_terraform_plan_details.application_id
  permission = "READ"
  scope      = databricks_secret_scope.secret_scope.id
}

resource "databricks_grant" "grant_catalog_provider_service_principal_terraform_plan" {
  for_each = {
    for key, value in var.data_provider_details :
    key => value if value.databricks_catalog.enabled && var.service_principal_name_terraform_plan != ""
  }

  catalog   = databricks_catalog.catalog_provider[each.key].id
  principal = var.databricks_service_principal_terraform_plan_details.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "EXTERNAL_USE_SCHEMA", # Not allowed as these users should not be external
    "MANAGE", # Required to read workspace binding

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

resource "databricks_grant" "grant_catalog_internal_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  catalog   = databricks_catalog.catalog_internal.id
  principal = var.databricks_service_principal_terraform_plan_details.application_id
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

resource "databricks_grant" "grant_catalog_published_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  catalog   = databricks_catalog.catalog_published.id
  principal = var.databricks_service_principal_terraform_plan_details.application_id
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
  for_each = var.service_principal_name_terraform_plan == "" ? {} : var.data_provider_details

  external_location = databricks_external_location.external_location_provider[each.key].id
  principal         = var.databricks_service_principal_terraform_plan_details.application_id
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

resource "databricks_grant" "grant_external_location_raw_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  external_location = databricks_external_location.external_location_raw.id
  principal         = var.databricks_service_principal_terraform_plan_details.application_id
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

resource "databricks_grant" "grant_external_location_enriched_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  external_location = databricks_external_location.external_location_enriched.id
  principal         = var.databricks_service_principal_terraform_plan_details.application_id
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

resource "databricks_grant" "grant_external_location_curated_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  external_location = databricks_external_location.external_location_curated.id
  principal         = var.databricks_service_principal_terraform_plan_details.application_id
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

resource "databricks_grant" "grant_external_location_workspace_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  external_location = databricks_external_location.external_location_workspace.id
  principal         = var.databricks_service_principal_terraform_plan_details.application_id
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

  storage_credential = databricks_storage_credential.storage_credential.id
  principal          = var.databricks_service_principal_terraform_plan_details.application_id
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

resource "databricks_grant" "grant_credential_service_principal_terraform_plan" {
  count = var.service_principal_name_terraform_plan == "" ? 0 : 1

  credential = databricks_credential.credential.id
  principal  = var.databricks_service_principal_terraform_plan_details.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Read
    "ACCESS",

    # Create
    # "CREATE_CONNECTION",
  ]
}
