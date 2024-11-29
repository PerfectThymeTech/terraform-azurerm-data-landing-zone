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
  databricks_workspace_details = {
    core = {
      id                  = module.databricks_workspace.databricks_workspace_id
      workspace_id        = module.databricks_workspace.databricks_workspace_workspace_id
      workspace_url       = module.databricks_workspace.databricks_workspace_workspace_url
      access_connector_id = module.databricks_access_connector.databricks_access_connector_id
    }
  }
  databricks_private_endpoint_rules = {
    "storage-account-external-blob" = {
      resource_id = module.storage_account_external.storage_account_id
      group_id    = "blob"
    }
    "storage-account-external-dfs" = {
      resource_id = module.storage_account_external.storage_account_id
      group_id    = "dfs"
    }
    "storage-account-raw-blob" = {
      resource_id = module.storage_account_raw.storage_account_id
      group_id    = "blob"
    }
    "storage-account-raw-dfs" = {
      resource_id = module.storage_account_raw.storage_account_id
      group_id    = "dfs"
    }
    "storage-account-enriched-blob" = {
      resource_id = module.storage_account_enriched.storage_account_id
      group_id    = "blob"
    }
    "storage-account-enriched-dfs" = {
      resource_id = module.storage_account_enriched.storage_account_id
      group_id    = "dfs"
    }
    "storage-account-curated-blob" = {
      resource_id = module.storage_account_curated.storage_account_id
      group_id    = "blob"
    }
    "storage-account-curated-dfs" = {
      resource_id = module.storage_account_curated.storage_account_id
      group_id    = "dfs"
    }
    "storage-account-workspace-blob" = {
      resource_id = module.storage_account_workspace.storage_account_id
      group_id    = "blob"
    }
    "storage-account-workspace-dfs" = {
      resource_id = module.storage_account_workspace.storage_account_id
      group_id    = "dfs"
    }
  }
}
