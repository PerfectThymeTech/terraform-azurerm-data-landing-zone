resource "databricks_default_namespace_setting" "default_namespace_setting_engineering" {
  namespace {
    value = databricks_catalog.catalog_engineering_default.name
  }
}
