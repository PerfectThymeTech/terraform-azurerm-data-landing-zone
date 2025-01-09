resource "databricks_permission_assignment" "permission_assignment_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  principal_id = one(data.databricks_group.group_developer[*].id)
  permissions  = ["USER"]
}

resource "databricks_secret_acl" "secret_acl_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  principal  = one(data.databricks_group.group_developer[*].display_name)
  permission = "READ"
  scope      = databricks_secret_scope.secret_scope.id
}

resource "databricks_grant" "grant_catalog_internal_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  catalog   = databricks_catalog.catalog_internal.id
  principal = one(data.databricks_group.group_developer[*].display_name)
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
    # "CREATE_SCHEMA", # Only allow admins to create schemas
    "CREATE_TABLE",
    "CREATE_VOLUME",
  ]
}

resource "databricks_grant" "grant_catalog_external_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  catalog   = databricks_catalog.catalog_external.id
  principal = one(data.databricks_group.group_developer[*].display_name)
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
    # "CREATE_SCHEMA", # Only allow admins to create schemas
    "CREATE_TABLE",
    "CREATE_VOLUME",
  ]
}

resource "databricks_grant" "permissions_external_location_external_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  external_location = databricks_external_location.external_location_external.id
  principal         = one(data.databricks_group.group_developer[*].display_name)
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
}

resource "databricks_grant" "permissions_external_location_raw_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  external_location = databricks_external_location.external_location_raw.id
  principal         = one(data.databricks_group.group_developer[*].display_name)
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
}

resource "databricks_grant" "permissions_external_location_enriched_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  external_location = databricks_external_location.external_location_enriched.id
  principal         = one(data.databricks_group.group_developer[*].display_name)
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
}

resource "databricks_grant" "permissions_external_location_curated_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  external_location = databricks_external_location.external_location_curated.id
  principal         = one(data.databricks_group.group_developer[*].display_name)
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
}

resource "databricks_grant" "permissions_external_location_workspace_developer" {
  count = var.developer_group_name == "" ? 0 : 1

  external_location = databricks_external_location.external_location_workspace.id
  principal         = one(data.databricks_group.group_developer[*].display_name)
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
}
