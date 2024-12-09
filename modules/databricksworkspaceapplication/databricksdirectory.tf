resource "databricks_directory" "directory" {
  path = "/${local.prefix}"
  delete_recursive = true
}
