locals {
  # General locals
  prefix                           = "${lower(var.prefix)}-${var.environment}-${lower(var.app_name)}"
  budget_start_date_rotation_years = 9
  tags = merge(
    var.tags,
    {
      prefix      = local.prefix
      app_name    = var.app_name
      environment = var.environment
    }
  )
  tags_cost = {
    app_name    = var.app_name
    cost_center = var.tags["cost_center"]
  }

  # Databricks locals
  databricks_enterprise_application_id = "2ff814a6-3304-4ab8-85cb-cd0e6f879c1d"

  # User assigned identity locals
  user_assigned_identity_federated_identity_credentials = var.data_factory_details.github_repo.account_name != "" && var.data_factory_details.github_repo.branch_name != "" && var.data_factory_details.github_repo.git_url != "" && var.data_factory_details.github_repo.repository_name != "" ? {
    oidc = {
      audience = "api://AzureADTokenExchange",
      issuer   = "https://token.actions.githubusercontent.com",
      subject  = "repo:${var.data_factory_details.github_repo.account_name}/${var.data_factory_details.github_repo.repository_name}:environment:${var.environment}",
    }
  } : {}

  # AI service locals
  ai_service_outbound_network_access_allowed_fqdns_storage = [
    "${reverse(split("/", var.storage_account_ids.provider))[0]}.blob.core.windows.net",
    "${reverse(split("/", var.storage_account_ids.raw))[0]}.blob.core.windows.net",
    "${reverse(split("/", var.storage_account_ids.enriched))[0]}.blob.core.windows.net",
    "${reverse(split("/", var.storage_account_ids.curated))[0]}.blob.core.windows.net",
    "${reverse(split("/", var.storage_account_ids.workspace))[0]}.blob.core.windows.net",
    "${reverse(split("/", var.storage_account_ids.provider))[0]}.dfs.core.windows.net",
    "${reverse(split("/", var.storage_account_ids.raw))[0]}.dfs.core.windows.net",
    "${reverse(split("/", var.storage_account_ids.enriched))[0]}.dfs.core.windows.net",
    "${reverse(split("/", var.storage_account_ids.curated))[0]}.dfs.core.windows.net",
    "${reverse(split("/", var.storage_account_ids.workspace))[0]}.dfs.core.windows.net",
  ]
  ai_service_outbound_network_access_allowed_fqdns_key_vault = [
    replace(module.key_vault.key_vault_uri, "https://", ""),
  ]
  ai_service_outbound_network_access_allowed_fqdns_search = var.search_service_details.enabled ? [
    "${local.search_service_name}.search.windows.net",
  ] : []
  ai_service_outbound_network_access_allowed_fqdns = concat(
    local.ai_service_outbound_network_access_allowed_fqdns_storage,
    local.ai_service_outbound_network_access_allowed_fqdns_key_vault,
    local.ai_service_outbound_network_access_allowed_fqdns_search,
  )
  ai_service_kind_firewall_bypass_azure_services_list = [
    "OpenAI"
  ]
  ai_service_kind_role_map_write = {
    "AnomalyDetector"         = "Cognitive Services User"
    "ComputerVision"          = "Cognitive Services User"
    "CognitiveServices"       = "Cognitive Services User"
    "ContentModerator"        = "Cognitive Services User"
    "CustomVision.Training"   = "Cognitive Services Custom Vision Contributor"
    "CustomVision.Prediction" = "Cognitive Services Custom Vision Contributor"
    "Face"                    = "Cognitive Services User"
    "FormRecognizer"          = "Cognitive Services User"
    "ImmersiveReader"         = "Cognitive Services User"
    "LUIS"                    = "Cognitive Services Language Owner"
    "Personalizer"            = "Cognitive Services User"
    "SpeechServices"          = "Cognitive Services Speech Contributor"
    "TextAnalytics"           = "Cognitive Services Language Owner"
    "TextTranslation"         = "Cognitive Services Language Owner"
    "OpenAI"                  = "Cognitive Services OpenAI Contributor"
  }
  ai_service_kind_role_map_use = {
    "AnomalyDetector"         = "Cognitive Services User"
    "ComputerVision"          = "Cognitive Services User"
    "CognitiveServices"       = "Cognitive Services User"
    "ContentModerator"        = "Cognitive Services User"
    "CustomVision.Training"   = "Cognitive Services Custom Vision Reader"
    "CustomVision.Prediction" = "Cognitive Services Custom Vision Reader"
    "Face"                    = "Cognitive Services User"
    "FormRecognizer"          = "Cognitive Services User"
    "ImmersiveReader"         = "Cognitive Services User"
    "LUIS"                    = "Cognitive Services Language Reader"
    "Personalizer"            = "Cognitive Services User"
    "SpeechServices"          = "Cognitive Services Speech User"
    "TextAnalytics"           = "Cognitive Services Language Reader"
    "TextTranslation"         = "Cognitive Services Language Reader"
    "OpenAI"                  = "Cognitive Services OpenAI User"
  }

  # Data factory locals
  data_factory_default_integration_runtime_name = "AutoResolveIntegrationRuntimeVnet"
  data_factory_default_managed_private_endpoints = {
    "storage-provider-blob" = {
      subresource_name   = "blob"
      target_resource_id = var.storage_account_ids.provider
    }
    "storage-provider-dfs" = {
      subresource_name   = "dfs"
      target_resource_id = var.storage_account_ids.provider
    }
    "storage-raw-blob" = {
      subresource_name   = "blob"
      target_resource_id = var.storage_account_ids.raw
    }
    "storage-raw-dfs" = {
      subresource_name   = "dfs"
      target_resource_id = var.storage_account_ids.raw
    }
    "storage-enriched-blob" = {
      subresource_name   = "blob"
      target_resource_id = var.storage_account_ids.enriched
    }
    "storage-enriched-dfs" = {
      subresource_name   = "dfs"
      target_resource_id = var.storage_account_ids.enriched
    }
    "storage-curated-blob" = {
      subresource_name   = "blob"
      target_resource_id = var.storage_account_ids.curated
    }
    "storage-curated-dfs" = {
      subresource_name   = "dfs"
      target_resource_id = var.storage_account_ids.curated
    }
    "storage-workspace-blob" = {
      subresource_name   = "blob"
      target_resource_id = var.storage_account_ids.workspace
    }
    "storage-workspace-dfs" = {
      subresource_name   = "dfs"
      target_resource_id = var.storage_account_ids.workspace
    }
    "keyvault-vault" = {
      subresource_name   = "vault"
      target_resource_id = module.key_vault.key_vault_id
    }
    "databricks-uiapi" = {
      subresource_name   = "databricks_ui_api"
      target_resource_id = var.databricks_workspace_details["engineering"].id
    }
  }
  data_factory_ai_service_managed_private_endpoints = {
    for key, value in var.ai_services :
    "aiservice-${key}-account" => {
      subresource_name   = "account"
      target_resource_id = module.ai_service[key].cognitive_account_id
    }
  }
  data_factory_managed_private_endpoints = merge(
    local.data_factory_default_managed_private_endpoints,
    local.data_factory_ai_service_managed_private_endpoints,
  )

  # Search service locals
  search_service_name = "${local.prefix}-srch001"
  search_service_shared_default_private_links = {
    "keyvault-vault" = {
      subresource_name   = "vault"
      target_resource_id = module.key_vault.key_vault_id
      approve            = true
    }
  }
  search_service_shared_ai_service_private_links = {
    for key, value in var.ai_services :
    "aiservice-${key}-account" => {
      subresource_name   = value.kind == "OpenAI" ? "openai_account" : "cognitiveservices_account"
      target_resource_id = module.ai_service[key].cognitive_account_id
      approve            = true
    }
  }
  search_service_shared_private_links = merge(
    local.search_service_shared_default_private_links,
    local.search_service_shared_ai_service_private_links
  )
}
