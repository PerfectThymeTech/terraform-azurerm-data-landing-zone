resource "databricks_system_schema" "system_schema" {
  for_each = toset(local.system_schema_names)

  schema = each.key
}
