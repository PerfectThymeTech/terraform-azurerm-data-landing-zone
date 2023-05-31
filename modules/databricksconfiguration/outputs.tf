output "databricks_configuration_setup_completed" {
  value = true
  description = "Specifies whether the connectivity and identity has been successfully configured."
  sensitive = false
  
  depends_on = [
    databricks_metastore_assignment.metastore_assignment,
  ]
}
