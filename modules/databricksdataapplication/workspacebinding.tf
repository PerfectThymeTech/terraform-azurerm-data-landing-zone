# # Credentials
# resource "databricks_workspace_binding" "workspace_binding_credential" {
#   binding_type   = "BINDING_TYPE_READ_WRITE"
#   securable_name = databricks_credential.credential.name
#   securable_type = "credential"
#   workspace_id   = var.databricks_workspace_workspace_id
# }

# resource "databricks_workspace_binding" "workspace_binding_storage_credential" {
#   binding_type   = "BINDING_TYPE_READ_WRITE"
#   securable_name = databricks_storage_credential.storage_credential.name
#   securable_type = "storage_credential"
#   workspace_id   = var.databricks_workspace_workspace_id
# }

# # Catalog
# resource "databricks_workspace_binding" "workspace_binding_catalog_internal" {
#   binding_type   = "BINDING_TYPE_READ_WRITE"
#   securable_name = databricks_catalog.catalog_internal.name
#   securable_type = "catalog"
#   workspace_id   = var.databricks_workspace_workspace_id
# }

# # External location
# resource "databricks_workspace_binding" "workspace_binding_external_location_external" {
#   binding_type   = "BINDING_TYPE_READ_WRITE"
#   securable_name = databricks_external_location.external_location_external.id
#   securable_type = "external_location"
#   workspace_id   = var.databricks_workspace_workspace_id
# }

# resource "databricks_workspace_binding" "workspace_binding_external_location_raw" {
#   binding_type   = "BINDING_TYPE_READ_WRITE"
#   securable_name = databricks_external_location.external_location_raw.id
#   securable_type = "external_location"
#   workspace_id   = var.databricks_workspace_workspace_id
# }

# resource "databricks_workspace_binding" "workspace_binding_external_location_enriched" {
#   binding_type   = "BINDING_TYPE_READ_WRITE"
#   securable_name = databricks_external_location.external_location_enriched.id
#   securable_type = "external_location"
#   workspace_id   = var.databricks_workspace_workspace_id
# }

# resource "databricks_workspace_binding" "external_location_curated" {
#   binding_type   = "BINDING_TYPE_READ_WRITE"
#   securable_name = databricks_external_location.external_location_curated.id
#   securable_type = "external_location"
#   workspace_id   = var.databricks_workspace_workspace_id
# }

# resource "databricks_workspace_binding" "workspace_binding_external_location_workspace" {
#   binding_type   = "BINDING_TYPE_READ_WRITE"
#   securable_name = databricks_external_location.external_location_workspace.id
#   securable_type = "external_location"
#   workspace_id   = var.databricks_workspace_workspace_id
# }
