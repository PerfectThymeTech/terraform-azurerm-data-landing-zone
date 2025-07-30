locals {
  # General locals
  prefix = "${lower(var.prefix)}-${var.environment}-core"

  # Storage locals
  trusted_subscription_ids = distinct(concat(var.trusted_subscription_ids, [data.azurerm_client_config.current.subscription_id]))
  storage_network_private_link_access_fabric = [
    for item in var.trusted_fabric_workspace_ids :
    "/subscriptions/00000000-0000-0000-0000-000000000000/resourcegroups/Fabric/providers/Microsoft.Fabric/workspaces/${item}"
  ]
  storage_network_private_link_access_azure = flatten([
    for item in local.trusted_subscription_ids : [
      "/subscriptions/${item}/providers/Microsoft.Security/datascanners/storageDataScanner",
      "/subscriptions/${item}/resourceGroups/*/providers/Microsoft.Synapse/workspaces/*",
      "/subscriptions/${item}/resourceGroups/*/providers/Microsoft.CognitiveServices/accounts/*",
      "/subscriptions/${item}/resourceGroups/*/providers/Microsoft.Search/searchServices/*",
      "/subscriptions/${item}/resourceGroups/*/providers/Microsoft.MachineLearningServices/workspaces/*",
      "/subscriptions/${item}/resourceGroups/*/providers/Microsoft.Databricks/accessConnectors/*",
    ]
  ])
  storage_network_private_link_access = concat(local.storage_network_private_link_access_azure, local.storage_network_private_link_access_fabric)
  storage_blob_cors_rules = {
    databricks = {
      allowed_headers    = ["x-ms-blob-type"]
      allowed_methods    = ["PUT"]
      allowed_origins    = ["https://*.azuredatabricks.net"]
      exposed_headers    = [""]
      max_age_in_seconds = 1800
    }
    openai = {
      allowed_headers    = ["*"]
      allowed_methods    = ["GET", "POST", "OPTIONS", "PUT"]
      allowed_origins    = ["*"]
      exposed_headers    = ["*"]
      max_age_in_seconds = 200
    }
  }

  # Databricks locals
  databricks_engineering_private_subnet_name = reverse(split("/", var.subnet_id_engineering_private))[0]
  databricks_engineering_public_subnet_name  = reverse(split("/", var.subnet_id_engineering_public))[0]
  databricks_consumption_private_subnet_name = reverse(split("/", var.subnet_id_consumption_private))[0]
  databricks_consumption_public_subnet_name  = reverse(split("/", var.subnet_id_consumption_public))[0]
  databricks_workspace_details_engineering = {
    id                            = module.databricks_workspace_engineering.databricks_workspace_id
    workspace_id                  = module.databricks_workspace_engineering.databricks_workspace_workspace_id
    workspace_url                 = module.databricks_workspace_engineering.databricks_workspace_workspace_url
    access_connector_id           = module.databricks_access_connector_engineering.databricks_access_connector_id
    access_connector_principal_id = module.databricks_access_connector_engineering.databricks_access_connector_principal_id
  }
  databricks_workspace_details_consumption = {
    id                            = one(module.databricks_workspace_consumption[*].databricks_workspace_id)
    workspace_id                  = one(module.databricks_workspace_consumption[*].databricks_workspace_workspace_id)
    workspace_url                 = one(module.databricks_workspace_consumption[*].databricks_workspace_workspace_url)
    access_connector_id           = one(module.databricks_access_connector_consumption[*].databricks_access_connector_id)
    access_connector_principal_id = one(module.databricks_access_connector_consumption[*].databricks_access_connector_principal_id)
  }
  databricks_workspace_details = var.databricks_workspace_consumption_enabled ? {
    engineering = local.databricks_workspace_details_engineering
    consumption = local.databricks_workspace_details_consumption
    } : {
    engineering = local.databricks_workspace_details_engineering
  }
  databricks_private_endpoint_rules = {
    "storage-account-provider-blob" = {
      resource_id = module.storage_account_provider.storage_account_id
      group_id    = "blob"
    }
    "storage-account-provider-dfs" = {
      resource_id = module.storage_account_provider.storage_account_id
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

  # Search service locals
  search_service_shared_private_links = {}
}
