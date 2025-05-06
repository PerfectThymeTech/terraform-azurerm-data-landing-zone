resource "databricks_permission_assignment" "permission_assignment_uai" {
  principal_id = databricks_service_principal.service_principal_uai.id
  permissions  = ["USER"]
}

# resource "databricks_secret_acl" "secret_acl_uai" {
#   principal  = databricks_service_principal.service_principal_uai.application_id
#   permission = "READ"
#   scope      = databricks_secret_scope.secret_scope.id

#   depends_on = [
#     databricks_permission_assignment.permission_assignment_uai,
#   ]
# }

resource "databricks_grant" "grant_catalog_internal_uai" {
  catalog   = databricks_catalog.catalog_internal.id
  principal = databricks_service_principal.service_principal_uai.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "EXTERNAL_USE_SCHEMA", # Not allowed as these users should not be external
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Prerequisite
    "USE_CATALOG",
    "USE_SCHEMA",

    # Metadata
    "BROWSE",
    # "APPLY_TAG", # Only allow system assigned tags at catalog level

    # Read
    "EXECUTE",
    "READ_VOLUME",
    "SELECT",

    # Edit
    "MODIFY",
    "REFRESH",
    "WRITE_VOLUME",

    # Create
    "CREATE_FUNCTION",
    "CREATE_MATERIALIZED_VIEW",
    "CREATE_MODEL",
    "CREATE_SCHEMA",
    "CREATE_TABLE",
    "CREATE_VOLUME",
  ]

  depends_on = [
    databricks_permission_assignment.permission_assignment_uai,
  ]
}

resource "databricks_grant" "grant_catalog_published_uai" {
  catalog   = databricks_catalog.catalog_published.id
  principal = databricks_service_principal.service_principal_uai.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "EXTERNAL_USE_SCHEMA", # Not allowed as these users should not be external
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Prerequisite
    "USE_CATALOG",
    "USE_SCHEMA",

    # Metadata
    "BROWSE",
    # "APPLY_TAG", # Only allow system assigned tags at catalog level

    # Read
    "EXECUTE",
    "READ_VOLUME",
    "SELECT",

    # Edit
    "MODIFY",
    "REFRESH",
    "WRITE_VOLUME",

    # Create
    "CREATE_FUNCTION",
    "CREATE_MATERIALIZED_VIEW",
    "CREATE_MODEL",
    "CREATE_SCHEMA",
    "CREATE_TABLE",
    "CREATE_VOLUME",
  ]

  depends_on = [
    databricks_permission_assignment.permission_assignment_uai,
  ]
}

resource "databricks_grant" "grant_external_location_provider_uai" {
  for_each = var.data_provider_details

  external_location = databricks_external_location.external_location_provider[each.key].id
  principal         = databricks_service_principal.service_principal_uai.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Metadata
    "BROWSE",

    # Read
    "READ_FILES",

    # Edit
    "WRITE_FILES",

    # Create
    "CREATE_EXTERNAL_TABLE",
    "CREATE_EXTERNAL_VOLUME",
    "CREATE_FOREIGN_SECURABLE",
    "CREATE_MANAGED_STORAGE",
  ]

  depends_on = [
    databricks_permission_assignment.permission_assignment_uai,
  ]
}

resource "databricks_grant" "grant_external_location_raw_uai" {
  external_location = databricks_external_location.external_location_raw.id
  principal         = databricks_service_principal.service_principal_uai.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Metadata
    "BROWSE",

    # Read
    "READ_FILES",

    # Edit
    "WRITE_FILES",

    # Create
    "CREATE_EXTERNAL_TABLE",
    "CREATE_EXTERNAL_VOLUME",
    "CREATE_FOREIGN_SECURABLE",
    "CREATE_MANAGED_STORAGE",
  ]

  depends_on = [
    databricks_permission_assignment.permission_assignment_uai,
  ]
}

resource "databricks_grant" "grant_external_location_enriched_uai" {
  external_location = databricks_external_location.external_location_enriched.id
  principal         = databricks_service_principal.service_principal_uai.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Metadata
    "BROWSE",

    # Read
    "READ_FILES",

    # Edit
    "WRITE_FILES",

    # Create
    "CREATE_EXTERNAL_TABLE",
    "CREATE_EXTERNAL_VOLUME",
    "CREATE_FOREIGN_SECURABLE",
    "CREATE_MANAGED_STORAGE",
  ]

  depends_on = [
    databricks_permission_assignment.permission_assignment_uai,
  ]
}

resource "databricks_grant" "grant_external_location_curated_uai" {
  external_location = databricks_external_location.external_location_curated.id
  principal         = databricks_service_principal.service_principal_uai.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Metadata
    "BROWSE",

    # Read
    "READ_FILES",

    # Edit
    "WRITE_FILES",

    # Create
    "CREATE_EXTERNAL_TABLE",
    "CREATE_EXTERNAL_VOLUME",
    "CREATE_FOREIGN_SECURABLE",
    "CREATE_MANAGED_STORAGE",
  ]

  depends_on = [
    databricks_permission_assignment.permission_assignment_uai,
  ]
}

resource "databricks_grant" "grant_external_location_workspace_uai" {
  external_location = databricks_external_location.external_location_workspace.id
  principal         = databricks_service_principal.service_principal_uai.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Metadata
    "BROWSE",

    # Read
    "READ_FILES",

    # Edit
    "WRITE_FILES",

    # Create
    "CREATE_EXTERNAL_TABLE",
    "CREATE_EXTERNAL_VOLUME",
    "CREATE_FOREIGN_SECURABLE",
    "CREATE_MANAGED_STORAGE",
  ]

  depends_on = [
    databricks_permission_assignment.permission_assignment_uai,
  ]
}

resource "databricks_grant" "grant_storage_credential_uai" {
  storage_credential = databricks_storage_credential.storage_credential.id
  principal          = databricks_service_principal.service_principal_uai.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Read
    "READ_FILES",

    # Edit
    "WRITE_FILES",

    # Create
    "CREATE EXTERNAL LOCATION",
    "CREATE_EXTERNAL_TABLE",
  ]

  depends_on = [
    databricks_permission_assignment.permission_assignment_uai,
  ]
}

resource "databricks_grant" "grant_credential_uai" {
  credential = databricks_credential.credential.id
  principal  = databricks_service_principal.service_principal_uai.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Read
    "ACCESS",

    # Create
    "CREATE_CONNECTION",
  ]

  depends_on = [
    databricks_permission_assignment.permission_assignment_uai,
  ]
}
