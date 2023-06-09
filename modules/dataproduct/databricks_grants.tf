resource "databricks_grants" "grants_experimentation_catalog" {
  count   = var.databricks_enabled && var.unity_catalog_configurations.enabled && var.databricks_experimentation && var.unity_catalog_configurations.group_name != "" ? 1 : 0
  catalog = one(databricks_catalog.experimentation_catalog[*].name)
  grant {
    principal  = var.unity_catalog_configurations.group_name
    privileges = ["ALL_PRIVILEGES"]
  }

  depends_on = [
    var.dependencies_databricks
  ]
}

resource "databricks_grants" "grants_automation_catalog" {
  count   = var.databricks_enabled && var.unity_catalog_configurations.enabled && !var.databricks_experimentation && var.unity_catalog_configurations.group_name != "" ? 1 : 0
  catalog = one(databricks_catalog.automation_catalog[*].name)
  grant {
    principal  = var.unity_catalog_configurations.group_name
    privileges = ["ALL_PRIVILEGES"]
  }

  depends_on = [
    var.dependencies_databricks
  ]
}
