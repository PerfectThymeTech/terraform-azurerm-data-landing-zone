
resource "databricks_workspace_binding" "workspace_binding_credential" {
  securable_name = databricks_credential.credential.name
  binding_type   = "credential"
  workspace_id   = var.databricks_workspace_workspace_id
}

# TODO
