locals {
  # General locals
  prefix = "${lower(var.prefix)}-core-${var.environment}"

  # Storage locals
  storage_external_network_private_link_access = [
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/Microsoft.Security/datascanners/storageDataScanner",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.Synapse/workspaces/*",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.CognitiveServices/accounts/*",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.Search/searchServices/*",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.MachineLearningServices/workspaces/*",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.Databricks/accessConnectors/*",
  ]
  storage_network_private_link_access = [
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/Microsoft.Security/datascanners/storageDataScanner",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.Synapse/workspaces/*",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.CognitiveServices/accounts/*",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.Search/searchServices/*",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.MachineLearningServices/workspaces/*",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.Databricks/accessConnectors/*",
  ]
  storage_blob_cors_rules = {
    databricks = {
      allowed_headers    = ["x-ms-blob-type"]
      allowed_methods    = ["PUT"]
      allowed_origins    = ["https://*.azuredatabricks.net"]
      exposed_headers    = [""]
      max_age_in_seconds = 1800
    }
  }

  # Databricks locals
  databricks_private_subnet_name = reverse(split("/", var.subnet_id_consumption_private))[0]
  databricks_public_subnet_name  = reverse(split("/", var.subnet_id_consumption_public))[0]
}
