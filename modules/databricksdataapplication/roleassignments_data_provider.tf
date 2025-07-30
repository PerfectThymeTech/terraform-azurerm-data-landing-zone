resource "databricks_grant" "grant_catalog_provider_data_provider_service_principal" {
  for_each = merge([
    for key, value in var.data_provider_details : {
      for service_principal_name in value.service_principal_names :
      "${key}-${service_principal_name}" => {
        key                    = key
        service_principal_name = service_principal_name
      } if value.databricks_catalog.enabled
    }
  ]...)

  catalog   = databricks_catalog.catalog_provider[each.value.key].id
  principal = data.databricks_service_principal.service_principal_data_provider[each.key].application_id
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
    "APPLY_TAG",

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
}

resource "databricks_grant" "grant_external_location_provider_data_provider_service_principal" {
  for_each = merge([
    for key, value in var.data_provider_details : {
      for service_principal_name in value.service_principal_names :
      "${key}-${service_principal_name}" => {
        key                    = key
        service_principal_name = service_principal_name
      } if value.databricks_catalog.enabled
    }
  ]...)

  external_location = databricks_external_location.external_location_provider[each.value.key].id
  principal         = data.databricks_service_principal.service_principal_data_provider[each.key].application_id
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

resource "databricks_grant" "grant_catalog_provider_data_provider_group" {
  for_each = merge([
    for key, value in var.data_provider_details : {
      for group_name in value.group_names :
      "${key}-${group_name}" => {
        key        = key
        group_name = group_name
      } if value.databricks_catalog.enabled
    }
  ]...)

  catalog   = databricks_catalog.catalog_provider[each.value.key].id
  principal = data.databricks_group.group_data_provider[each.key].display_name
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
    "APPLY_TAG",

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
}

resource "databricks_grant" "grant_external_location_provider_data_provider_group" {
  for_each = merge([
    for key, value in var.data_provider_details : {
      for group_name in value.group_names :
      "${key}-${group_name}" => {
        key        = key
        group_name = group_name
      } if value.databricks_catalog.enabled
    }
  ]...)

  external_location = databricks_external_location.external_location_provider[each.value.key].id
  principal         = data.databricks_group.group_data_provider[each.key].display_name
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
