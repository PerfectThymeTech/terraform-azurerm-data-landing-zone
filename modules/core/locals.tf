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
  ]
  storage_network_private_link_access = [
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/Microsoft.Security/datascanners/storageDataScanner",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.Synapse/workspaces/*",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.CognitiveServices/accounts/*",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.Search/searchServices/*",
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/*/providers/Microsoft.MachineLearningServices/workspaces/*",
  ]

  # Databricks locals
  databricks_private_subnet_name = reverse(split("/", var.subnet_id_consumption_private))[0]
  databricks_public_subnet_name  = reverse(split("/", var.subnet_id_consumption_public))[0]
}
