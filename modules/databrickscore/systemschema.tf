resource "databricks_system_schema" "system_schema_engineering" {
  for_each = toset(local.system_schema_names)

  schema = each.key
}
