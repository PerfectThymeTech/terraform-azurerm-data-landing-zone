resource "databricks_permission_assignment" "permission_assignment_admin" {
  principal_id = data.databricks_group.group_admin.id
  permissions  = ["USER"]
}

resource "databricks_secret_acl" "secret_acl_admin" {
  principal  = data.databricks_group.group_admin.display_name
  permission = "READ"
  scope      = databricks_secret_scope.secret_scope.id

  depends_on = [
    databricks_permission_assignment.permission_assignment_admin,
  ]
}

resource "databricks_grant" "grant_catalog_internal_admin" {
  catalog   = databricks_catalog.catalog_internal.id
  principal = data.databricks_group.group_admin.display_name
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
    databricks_permission_assignment.permission_assignment_admin,
  ]
}

resource "databricks_grant" "grant_catalog_external_admin" {
  catalog   = databricks_catalog.catalog_external.id
  principal = data.databricks_group.group_admin.display_name
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
    databricks_permission_assignment.permission_assignment_admin,
  ]
}

resource "databricks_grant" "grant_external_location_external_admin" {
  external_location = databricks_external_location.external_location_external.id
  principal         = data.databricks_group.group_admin.display_name
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
    databricks_permission_assignment.permission_assignment_admin,
  ]
}

resource "databricks_grant" "grant_external_location_raw_admin" {
  external_location = databricks_external_location.external_location_raw.id
  principal         = data.databricks_group.group_admin.display_name
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
    databricks_permission_assignment.permission_assignment_admin,
  ]
}

resource "databricks_grant" "grant_external_location_enriched_admin" {
  external_location = databricks_external_location.external_location_enriched.id
  principal         = data.databricks_group.group_admin.display_name
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
    databricks_permission_assignment.permission_assignment_admin,
  ]
}

resource "databricks_grant" "grant_external_location_curated_admin" {
  external_location = databricks_external_location.external_location_curated.id
  principal         = data.databricks_group.group_admin.display_name
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
    databricks_permission_assignment.permission_assignment_admin,
  ]
}

resource "databricks_grant" "grant_external_location_workspace_admin" {
  external_location = databricks_external_location.external_location_workspace.id
  principal         = data.databricks_group.group_admin.display_name
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
    databricks_permission_assignment.permission_assignment_admin,
  ]
}

resource "databricks_grant" "grant_storage_credential_admin" {
  storage_credential = databricks_storage_credential.storage_credential.id
  principal          = data.databricks_group.group_admin.display_name
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
    databricks_permission_assignment.permission_assignment_admin,
  ]
}

resource "databricks_grant" "grant_credential_admin" {
  credential = databricks_credential.credential.id
  principal  = data.databricks_group.group_admin.display_name
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
    databricks_permission_assignment.permission_assignment_admin,
  ]
}
