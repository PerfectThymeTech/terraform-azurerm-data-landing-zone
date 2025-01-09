resource "databricks_permission_assignment" "permission_assignment_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  principal_id = one(data.databricks_group.group_reader[*].id)
  permissions  = ["USER"]
}

resource "databricks_grant" "grant_catalog_internal_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  catalog   = databricks_catalog.catalog_internal.id
  principal = one(data.databricks_group.group_reader[*].display_name)
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
    # "MODIFY", # Only allow read permissions
    # "REFRESH", # Only allow read permissions
    # "WRITE_VOLUME", # Only allow read permissions

    # Create
    # "CREATE_FUNCTION", # Only allow read permissions
    # "CREATE_MATERIALIZED_VIEW", # Only allow read permissions
    # "CREATE_MODEL", # Only allow read permissions
    # "CREATE_SCHEMA", # Only allow admins to create schemas
    # "CREATE_TABLE", # Only allow read permissions
    # "CREATE_VOLUME", # Only allow read permissions
  ]
}

resource "databricks_grant" "grant_catalog_external_reader" {
  count = var.reader_group_name == "" ? 0 : 1

  catalog   = databricks_catalog.catalog_external.id
  principal = one(data.databricks_group.group_reader[*].display_name)
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
    # "MODIFY", # Only allow read permissions
    # "REFRESH", # Only allow read permissions
    # "WRITE_VOLUME", # Only allow read permissions

    # Create
    # "CREATE_FUNCTION", # Only allow read permissions
    # "CREATE_MATERIALIZED_VIEW", # Only allow read permissions
    # "CREATE_MODEL", # Only allow read permissions
    # "CREATE_SCHEMA", # Only allow admins to create schemas
    # "CREATE_TABLE", # Only allow read permissions
    # "CREATE_VOLUME", # Only allow read permissions
  ]
}

resource "databricks_grant" "permissions_external_location_external_reader" {
  external_location = databricks_external_location.external_location_external.id
  principal = databricks_service_principal.service_principal.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Metadata
    "BROWSE",

    # Read
    "READ_FILES",

    # Edit
    # "WRITE_FILES", # Only allow read permissions

    # Create
    # "CREATE_EXTERNAL_TABLE", # Only allow read permissions
    # "CREATE_EXTERNAL_VOLUME", # Only allow read permissions
    # "CREATE_FOREIGN_SECURABLE", # Only allow read permissions
    # "CREATE_MANAGED_STORAGE", # Only allow read permissions
  ]
}

resource "databricks_grant" "permissions_external_location_raw_reader" {
  external_location = databricks_external_location.external_location_raw.id
  principal = databricks_service_principal.service_principal.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Metadata
    "BROWSE",

    # Read
    "READ_FILES",

    # Edit
    # "WRITE_FILES", # Only allow read permissions

    # Create
    # "CREATE_EXTERNAL_TABLE", # Only allow read permissions
    # "CREATE_EXTERNAL_VOLUME", # Only allow read permissions
    # "CREATE_FOREIGN_SECURABLE", # Only allow read permissions
    # "CREATE_MANAGED_STORAGE", # Only allow read permissions
  ]
}

resource "databricks_grant" "permissions_external_location_enriched_reader" {
  external_location = databricks_external_location.external_location_enriched.id
  principal = databricks_service_principal.service_principal.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Metadata
    "BROWSE",

    # Read
    "READ_FILES",

    # Edit
    # "WRITE_FILES", # Only allow read permissions

    # Create
    # "CREATE_EXTERNAL_TABLE", # Only allow read permissions
    # "CREATE_EXTERNAL_VOLUME", # Only allow read permissions
    # "CREATE_FOREIGN_SECURABLE", # Only allow read permissions
    # "CREATE_MANAGED_STORAGE", # Only allow read permissions
  ]
}

resource "databricks_grant" "permissions_external_location_curated_reader" {
  external_location = databricks_external_location.external_location_curated.id
  principal = databricks_service_principal.service_principal.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Metadata
    "BROWSE",

    # Read
    "READ_FILES",

    # Edit
    # "WRITE_FILES", # Only allow read permissions

    # Create
    # "CREATE_EXTERNAL_TABLE", # Only allow read permissions
    # "CREATE_EXTERNAL_VOLUME", # Only allow read permissions
    # "CREATE_FOREIGN_SECURABLE", # Only allow read permissions
    # "CREATE_MANAGED_STORAGE", # Only allow read permissions
  ]
}

resource "databricks_grant" "permissions_external_location_workspace_reader" {
  external_location = databricks_external_location.external_location_workspace.id
  principal = databricks_service_principal.service_principal.application_id
  privileges = [
    # General
    # "ALL_PRIVILIGES", # Use specific permissions instead of allowing all permissions by default
    # "MANAGE", # Only allow system assigned permissions at catalog level and enforce permissions at lower levels

    # Metadata
    "BROWSE",

    # Read
    "READ_FILES",

    # Edit
    # "WRITE_FILES", # Only allow read permissions

    # Create
    # "CREATE_EXTERNAL_TABLE", # Only allow read permissions
    # "CREATE_EXTERNAL_VOLUME", # Only allow read permissions
    # "CREATE_FOREIGN_SECURABLE", # Only allow read permissions
    # "CREATE_MANAGED_STORAGE", # Only allow read permissions
  ]
}
