output "datalake_id" {
  value       = azurerm_storage_account.datalake.id
  description = "Specifies the resource ID of the datalake."
  sensitive   = false
}

output "datalake_setup_completed" {
  value       = true
  description = "Specifies whether the connectivity and identity has been successfully configured."
  sensitive   = false

  depends_on = [
    azurerm_role_assignment.current_roleassignment_storage,
    azurerm_private_endpoint.azurerm_private_endpoint.datalake_private_endpoint_blob,
    azurerm_private_endpoint.azurerm_private_endpoint.datalake_private_endpoint_dfs,
    azurerm_private_endpoint.datalake_private_endpoint_queue,
    azurerm_private_endpoint.datalake_private_endpoint_table,
  ]
}
