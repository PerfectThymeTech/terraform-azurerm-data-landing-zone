# Cosmos DB connections
resource "azapi_resource" "ai_foundry_project_connection_cosmosdb_account" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-04-01-preview"
  name      = "cosmosdb-account-${local.prefix}"
  parent_id = one(azapi_resource.ai_foundry_project[*].id)

  body = {
    properties = {
      authType      = "AAD"
      category      = "CosmosDb"
      error         = null
      expiryTime    = null
      isSharedToAll = false
      metadata = {
        ApiType    = "Azure"
        ResourceId = var.ai_foundry_account_details.cosmos_db.id
        location   = var.location
      }
      peRequirement               = "NotRequired"
      target                      = var.ai_foundry_account_details.cosmos_db.target
      useWorkspaceManagedIdentity = true
    }
  }

  response_export_values    = []
  schema_validation_enabled = false
  locks                     = []
  ignore_casing             = false
  ignore_missing_property   = true
}

# Search connections
resource "azapi_resource" "ai_foundry_project_connection_search_service_account" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-04-01-preview"
  name      = "cognitivesearch-account-${local.prefix}"
  parent_id = one(azapi_resource.ai_foundry_project[*].id)

  body = {
    properties = {
      authType      = "AAD"
      category      = "CognitiveSearch"
      error         = null
      expiryTime    = null
      isSharedToAll = false
      metadata = {
        ApiType    = "Azure"
        ResourceId = var.ai_foundry_account_details.search_service.id
        location   = var.location
      }
      peRequirement               = "NotRequired"
      target                      = var.ai_foundry_account_details.search_service.target
      useWorkspaceManagedIdentity = true
    }
  }

  response_export_values    = []
  schema_validation_enabled = false
  locks                     = []
  ignore_casing             = false
  ignore_missing_property   = true
}

resource "azapi_resource" "ai_foundry_project_connection_search_service" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled && var.search_service_details.enabled ? 1 : 0

  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-04-01-preview"
  name      = "cognitivesearch-${local.prefix}"
  parent_id = one(azapi_resource.ai_foundry_project[*].id)

  body = {
    properties = {
      authType      = "AAD"
      category      = "CognitiveSearch"
      error         = null
      expiryTime    = null
      isSharedToAll = false
      metadata = {
        ApiType    = "Azure"
        ResourceId = one(module.ai_search[*].search_service_id)
        location   = var.location
      }
      peRequirement               = "NotRequired"
      target                      = "https://${one(module.ai_search[*].search_service_name)}.search.windows.net"
      useWorkspaceManagedIdentity = true
    }
  }

  response_export_values    = []
  schema_validation_enabled = false
  locks                     = []
  ignore_casing             = false
  ignore_missing_property   = true
}

# Open AI connections
resource "azapi_resource" "ai_foundry_project_connection_openai" {
  for_each = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? local.ai_foundry_project_connection_openai : {}

  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-04-01-preview"
  name      = "openai-${local.prefix}-${each.key}"
  parent_id = one(azapi_resource.ai_foundry_project[*].id)

  body = {
    properties = {
      authType      = "AAD"
      category      = "AzureOpenAI"
      error         = null
      expiryTime    = null
      isSharedToAll = false
      metadata = {
        ApiType    = "Azure"
        ResourceId = each.value.id
        location   = each.value.location
      }
      peRequirement               = "NotRequired"
      target                      = each.value.target
      useWorkspaceManagedIdentity = true
    }
  }

  response_export_values    = []
  schema_validation_enabled = false
  locks                     = []
  ignore_casing             = false
  ignore_missing_property   = true
}

# Application Insights connections
resource "azapi_resource" "ai_foundry_project_connection_appinsights" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-04-01-preview"
  name      = "appinsights-${local.prefix}"
  parent_id = one(azapi_resource.ai_foundry_project[*].id)

  body = {
    properties = {
      authType = "ApiKey"
      category = "AppInsights"
      credentials = {
        key = module.application_insights.application_insights_connection_string
      }
      error         = null
      expiryTime    = null
      isSharedToAll = false
      metadata = {
        ApiType    = "Azure"
        ResourceId = module.application_insights.application_insights_id
        location   = var.location
      }
      peRequirement               = "NotRequired"
      target                      = module.application_insights.application_insights_id
      useWorkspaceManagedIdentity = true
    }
  }

  response_export_values    = []
  schema_validation_enabled = false
  locks                     = []
  ignore_casing             = false
  ignore_missing_property   = true
}

# Storage connections
resource "azapi_resource" "ai_foundry_project_connection_storage_account" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-04-01-preview"
  name      = "azurestorageaccount-account-${local.prefix}"
  parent_id = one(azapi_resource.ai_foundry_project[*].id)

  body = {
    properties = {
      authType      = "AAD"
      category      = "AzureStorageAccount"
      error         = null
      expiryTime    = null
      isSharedToAll = false
      metadata = {
        ApiType    = "Azure"
        ResourceId = var.ai_foundry_account_details.storage_account.id
        location   = var.location
      }
      peRequirement               = "NotRequired"
      target                      = var.ai_foundry_account_details.storage_account.target
      useWorkspaceManagedIdentity = true
    }
  }

  response_export_values    = []
  schema_validation_enabled = false
  locks                     = []
  ignore_casing             = false
  ignore_missing_property   = true
}

resource "azapi_resource" "ai_foundry_project_connection_storage_provider" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-04-01-preview"
  name      = "azurestorageaccount-provider-${local.prefix}"
  parent_id = one(azapi_resource.ai_foundry_project[*].id)

  body = {
    properties = {
      authType      = "AAD"
      category      = "AzureStorageAccount"
      error         = null
      expiryTime    = null
      isSharedToAll = false
      metadata = {
        ApiType    = "Azure"
        ResourceId = var.storage_account_ids.provider
        location   = var.location
      }
      peRequirement               = "NotRequired"
      target                      = "https://${reverse(split("/", var.storage_account_ids.provider))[0]}.blob.core.windows.net/"
      useWorkspaceManagedIdentity = true
    }
  }

  response_export_values    = []
  schema_validation_enabled = false
  locks                     = []
  ignore_casing             = false
  ignore_missing_property   = true
}

resource "azapi_resource" "ai_foundry_project_connection_storage_raw" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-04-01-preview"
  name      = "azurestorageaccount-raw-${local.prefix}"
  parent_id = one(azapi_resource.ai_foundry_project[*].id)

  body = {
    properties = {
      authType      = "AAD"
      category      = "AzureStorageAccount"
      error         = null
      expiryTime    = null
      isSharedToAll = false
      metadata = {
        ApiType    = "Azure"
        ResourceId = var.storage_account_ids.raw
        location   = var.location
      }
      peRequirement               = "NotRequired"
      target                      = "https://${reverse(split("/", var.storage_account_ids.raw))[0]}.blob.core.windows.net/"
      useWorkspaceManagedIdentity = true
    }
  }

  response_export_values    = []
  schema_validation_enabled = false
  locks                     = []
  ignore_casing             = false
  ignore_missing_property   = true
}

resource "azapi_resource" "ai_foundry_project_connection_storage_enriched" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-04-01-preview"
  name      = "azurestorageaccount-enriched-${local.prefix}"
  parent_id = one(azapi_resource.ai_foundry_project[*].id)

  body = {
    properties = {
      authType      = "AAD"
      category      = "AzureStorageAccount"
      error         = null
      expiryTime    = null
      isSharedToAll = false
      metadata = {
        ApiType    = "Azure"
        ResourceId = var.storage_account_ids.enriched
        location   = var.location
      }
      peRequirement               = "NotRequired"
      target                      = "https://${reverse(split("/", var.storage_account_ids.enriched))[0]}.blob.core.windows.net/"
      useWorkspaceManagedIdentity = true
    }
  }

  response_export_values    = []
  schema_validation_enabled = false
  locks                     = []
  ignore_casing             = false
  ignore_missing_property   = true
}

resource "azapi_resource" "ai_foundry_project_connection_storage_curated" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-04-01-preview"
  name      = "azurestorageaccount-curated-${local.prefix}"
  parent_id = one(azapi_resource.ai_foundry_project[*].id)

  body = {
    properties = {
      authType      = "AAD"
      category      = "AzureStorageAccount"
      error         = null
      expiryTime    = null
      isSharedToAll = false
      metadata = {
        ApiType    = "Azure"
        ResourceId = var.storage_account_ids.curated
        location   = var.location
      }
      peRequirement               = "NotRequired"
      target                      = "https://${reverse(split("/", var.storage_account_ids.curated))[0]}.blob.core.windows.net/"
      useWorkspaceManagedIdentity = true
    }
  }

  response_export_values    = []
  schema_validation_enabled = false
  locks                     = []
  ignore_casing             = false
  ignore_missing_property   = true
}

resource "azapi_resource" "ai_foundry_project_connection_storage_workspace" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.enabled ? 1 : 0

  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-04-01-preview"
  name      = "azurestorageaccount-workspace-${local.prefix}"
  parent_id = one(azapi_resource.ai_foundry_project[*].id)

  body = {
    properties = {
      authType      = "AAD"
      category      = "AzureStorageAccount"
      error         = null
      expiryTime    = null
      isSharedToAll = false
      metadata = {
        ApiType    = "Azure"
        ResourceId = var.storage_account_ids.workspace
        location   = var.location
      }
      peRequirement               = "NotRequired"
      target                      = "https://${reverse(split("/", var.storage_account_ids.workspace))[0]}.blob.core.windows.net/"
      useWorkspaceManagedIdentity = true
    }
  }

  response_export_values    = []
  schema_validation_enabled = false
  locks                     = []
  ignore_casing             = false
  ignore_missing_property   = true
}
