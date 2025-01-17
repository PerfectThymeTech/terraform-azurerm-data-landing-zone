# General variables
variable "location" {
  description = "Specifies the location for all Azure resources."
  type        = string
  sensitive   = false
}

variable "environment" {
  description = "Specifies the environment of the deployment."
  type        = string
  sensitive   = false
  default     = "dev"
  validation {
    condition     = contains(["int", "dev", "tst", "qa", "uat", "prd"], var.environment)
    error_message = "Please use an allowed value: \"int\", \"dev\", \"tst\", \"qa\", \"uat\" or \"prd\"."
  }
}

variable "prefix" {
  description = "Specifies the prefix for all resources created in this deployment."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.prefix) >= 2 && length(var.prefix) <= 10
    error_message = "Please specify a prefix with more than two and less than 10 characters."
  }
}

variable "tags" {
  description = "Specifies the tags that you want to apply to all resources."
  type        = map(string)
  sensitive   = false
  default     = {}
}

# Service variables
variable "app_name" {
  description = "Specifies the app name for all resources created in this deployment."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.app_name) >= 2 && length(var.app_name) <= 10
    error_message = "Please specify an app name with more than two and less than 10 characters."
  }
}

variable "storage_account_ids" {
  description = "Specifies the ids of the storage accounts in the core layer."
  type = object({
    external  = string
    raw       = string
    enriched  = string
    curated   = string
    workspace = string
  })
  sensitive = false
  validation {
    condition     = length(split("/", var.storage_account_ids.external)) == 9
    error_message = "Please specify a valid external storage account id."
  }
  validation {
    condition     = length(split("/", var.storage_account_ids.raw)) == 9
    error_message = "Please specify a valid raw storage account id."
  }
  validation {
    condition     = length(split("/", var.storage_account_ids.enriched)) == 9
    error_message = "Please specify a valid enriched storage account id."
  }
  validation {
    condition     = length(split("/", var.storage_account_ids.curated)) == 9
    error_message = "Please specify a valid curated storage account id."
  }
  validation {
    condition     = length(split("/", var.storage_account_ids.workspace)) == 9
    error_message = "Please specify a valid workspace storage account id."
  }
}

variable "databricks_workspace_details" {
  description = "Specifies the workspace details of databricks workspaces."
  type = map(object({
    id                  = string
    workspace_id        = string
    workspace_url       = string
    access_connector_id = string
  }))
  sensitive = false
  nullable  = false
  default   = {}
}

variable "ai_services" {
  description = "Specifies the map of ai services to be created for this application."
  type = map(object({
    location = optional(string, null)
    kind     = string
    sku      = string
  }))
  sensitive = false
  nullable  = false
  default   = {}
  validation {
    condition = alltrue([
      length([for kind in values(var.ai_services)[*].kind : kind if !contains(["AnomalyDetector", "ComputerVision", "CognitiveServices", "ContentModerator", "CustomVision.Training", "CustomVision.Prediction", "Face", "FormRecognizer", "ImmersiveReader", "LUIS", "Personalizer", "SpeechServices", "TextAnalytics", "TextTranslation", "OpenAI"], kind)]) <= 0,
      length([for sku in values(var.ai_services)[*].sku : sku if !startswith(sku, "S") && !startswith(sku, "P") && !startswith(sku, "E") && !startswith(sku, "DC")]) <= 0
    ])
    error_message = "Please specify a valid ai service configuration."
  }
}

# HA/DR variables
variable "zone_redundancy_enabled" {
  description = "Specifies whether zone-redundancy should be enabled for all resources."
  type        = bool
  sensitive   = false
  nullable    = false
  default     = true
}

# Logging and monitoring variables
variable "diagnostics_configurations" {
  description = "Specifies the diagnostic configuration for the service."
  type = list(object({
    log_analytics_workspace_id = optional(string, ""),
    storage_account_id         = optional(string, "")
  }))
  sensitive = false
  default   = []
  validation {
    condition = alltrue([
      length([for diagnostics_configuration in toset(var.diagnostics_configurations) : diagnostics_configuration if diagnostics_configuration.log_analytics_workspace_id == "" && diagnostics_configuration.storage_account_id == ""]) <= 0
    ])
    error_message = "Please specify a valid resource ID."
  }
}

variable "alerting" {
  description = "Specifies the alerting details."
  type = object({
    categories = optional(object({
      service_health = optional(object({
        severity       = optional(string, "Info")
        incident_level = optional(number, 3)
      }), {})
    }), {})
    endpoints = optional(object({
      email = optional(object({
        email_address = string
      }), null)
    }), {})
  })
  sensitive = false
  validation {
    condition = alltrue([
      var.alerting.endpoints == {} || length(var.alerting.endpoints) > 0,
      contains(["Debug", "Info", "Warning", "Error", "Critical"], var.alerting.categories.service_health.severity),
      var.alerting.categories.service_health.incident_level >= 0,
    ])
    error_message = "Please specify valid alerting details."
  }
}

# Identity variables
variable "admin_group_name" {
  description = "Specifies the name of the admin Entra ID security group."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.admin_group_name) >= 2
    error_message = "Please specify a valid Entra ID group name."
  }
}

variable "developer_group_name" {
  description = "Specifies the name of the developer Entra ID security group."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.developer_group_name == "" || length(var.developer_group_name) >= 2
    error_message = "Please specify a valid Entra ID group name."
  }
}

variable "reader_group_name" {
  description = "Specifies the name of the reader Entra ID security group."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.reader_group_name == "" || length(var.reader_group_name) >= 2
    error_message = "Please specify a valid Entra ID group name."
  }
}

variable "service_principal_name" {
  description = "Specifies the name of the Entra ID service principal name."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.service_principal_name) >= 2
    error_message = "Please specify a valid Entra ID service principal name."
  }
}

# Network variables
variable "vnet_id" {
  description = "Specifies the resource ID of the Vnet used for the Data Landing Zone."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.vnet_id)) == 9
    error_message = "Please specify a valid resource ID."
  }
}

variable "subnet_id_app" {
  description = "Specifies the id of the app subnet used for the private endpoints."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.subnet_id_app)) == 11
    error_message = "Please specify a valid resource ID."
  }
}

variable "connectivity_delay_in_seconds" {
  description = "Specifies the delay in seconds after the private endpoint deployment (required for the DNS automation via Policies)."
  type        = number
  sensitive   = false
  nullable    = false
  default     = 120
  validation {
    condition     = var.connectivity_delay_in_seconds >= 0
    error_message = "Please specify a valid non-negative number."
  }
}

# DNS variables
variable "private_dns_zone_id_blob" {
  description = "Specifies the resource ID of the private DNS zone for Azure Storage blob endpoints. Not required if DNS A-records get created via Azure Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_blob == "" || (length(split("/", var.private_dns_zone_id_blob)) == 9 && endswith(var.private_dns_zone_id_blob, "privatelink.blob.core.windows.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_dfs" {
  description = "Specifies the resource ID of the private DNS zone for Azure Storage dfs endpoints. Not required if DNS A-records get created via Azure Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_dfs == "" || (length(split("/", var.private_dns_zone_id_dfs)) == 9 && endswith(var.private_dns_zone_id_dfs, "privatelink.dfs.core.windows.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_databricks" {
  description = "Specifies the resource ID of the private DNS zone for Azure Databricks UI endpoints. Not required if DNS A-records get created via Azure Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_databricks == "" || (length(split("/", var.private_dns_zone_id_databricks)) == 9 && endswith(var.private_dns_zone_id_databricks, "privatelink.azuredatabricks.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_vault" {
  description = "Specifies the resource ID of the private DNS zone for Azure Key Vault. Not required if DNS A-records get created via Azure Policy."
  type        = string
  sensitive   = false
  nullable    = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_vault == "" || (length(split("/", var.private_dns_zone_id_vault)) == 9 && endswith(var.private_dns_zone_id_vault, "privatelink.vaultcore.azure.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_cognitive_account" {
  description = "Specifies the resource ID of the private DNS zone for Azure Cognitive Services. Not required if DNS A-records get created via Azure Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_cognitive_account == "" || (length(split("/", var.private_dns_zone_id_cognitive_account)) == 9 && (endswith(var.private_dns_zone_id_cognitive_account, "privatelink.cognitiveservices.azure.com") || endswith(var.private_dns_zone_id_cognitive_account, "privatelink.openai.azure.com")))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

# Customer-managed key variables
variable "customer_managed_key" {
  description = "Specifies the customer managed key configurations."
  type = object({
    key_vault_id                     = string,
    key_vault_key_versionless_id     = string,
    user_assigned_identity_id        = string,
    user_assigned_identity_client_id = string,
  })
  sensitive = false
  nullable  = true
  default   = null
  validation {
    condition = alltrue([
      var.customer_managed_key == null || length(split("/", try(var.customer_managed_key.key_vault_id, ""))) == 9,
      var.customer_managed_key == null || startswith(try(var.customer_managed_key.key_vault_key_versionless_id, ""), "https://"),
      var.customer_managed_key == null || length(split("/", try(var.customer_managed_key.user_assigned_identity_id, ""))) == 9,
      var.customer_managed_key == null || length(try(var.customer_managed_key.user_assigned_identity_client_id, "")) >= 2,
    ])
    error_message = "Please specify a valid resource ID."
  }
}

# Budget variables
variable "budget" {
  description = "Specifies the budget details."
  type = object({
    categories = object({
      azure      = number
      databricks = number
    })
    endpoints = optional(object({
      email = optional(object({
        email_address = string
      }), null)
    }), {})
  })
  sensitive = false
  nullable  = true
  validation {
    condition     = var.budget == null || try(var.budget.categories.azure, 0) > 0
    error_message = "Please provide a valid azure budget greater than 0."
  }
  validation {
    condition     = var.budget == null || try(var.budget.categories.databricks, 0) > 0
    error_message = "Please provide a valid databricks budget greater than 0."
  }
}
