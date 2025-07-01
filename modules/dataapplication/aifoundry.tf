resource "azapi_resource" "ai_foundry_project" {
  count = var.ai_foundry_project_details.enabled && var.ai_foundry_account_details.ai_foundry_account.id != "" ? 1 : 0

  type      = "Microsoft.CognitiveServices/accounts/projects@2025-04-01-preview"
  name      = local.prefix
  location  = var.location
  parent_id = var.ai_foundry_account_details.ai_foundry_id
  identity {
    type = "SystemAssigned"
  }

  body = {
    properties = {
      description = "Azure AI Foundry Project - ${local.prefix}"
      displayName = "${local.prefix} Project"
    }
  }

  response_export_values    = ["properties.internalId"]
  schema_validation_enabled = true
  locks                     = []
  ignore_casing             = false
  ignore_missing_property   = true
}
