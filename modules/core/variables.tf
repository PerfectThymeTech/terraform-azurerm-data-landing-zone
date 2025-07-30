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
variable "trusted_subscription_ids" {
  description = "Specifies the list of subscription IDs of your data platform."
  type        = list(string)
  sensitive   = false
  default     = []
}

variable "trusted_fabric_workspace_ids" {
  description = "Specifies the list of fabric workspace IDs which should be trusted to bypass storage account firewalls."
  type        = set(string)
  sensitive   = false
  default     = []
}

variable "databricks_workspace_consumption_enabled" {
  description = "Specifies whether the consumption workspace should be enabled."
  type        = bool
  sensitive   = false
  nullable    = false
  default     = false
}

variable "databricks_compliance_security_profile_standards" {
  description = "Specifies which enhanced compliance security profiles ('HIPAA', 'PCI_DSS') should be enabled for the Azure Databricks workspace."
  type        = list(string)
  sensitive   = false
  nullable    = false
  default     = []
  validation {
    condition = alltrue([
      length([for compliance_security_profile_standard in toset(var.databricks_compliance_security_profile_standards) : compliance_security_profile_standard if !contains(["HIPAA", "PCI_DSS"], compliance_security_profile_standard)]) <= 0
    ])
    error_message = "Please specify a valid compliance security profile."
  }
}

variable "fabric_capacity_details" {
  description = "Specifies the fabric capacity configuration."
  type = object({
    enabled      = optional(bool, false)
    admin_emails = optional(list(string), [])
    sku          = optional(string, "F2")
  })
  sensitive = false
  nullable  = false
  default   = {}
  validation {
    condition     = contains(["F2", "F4", "F8", "F16", "F32", "F64", "F128", "F256", "F512", "F1024", "F2048"], var.fabric_capacity_details.sku)
    error_message = "Please specify a valid fabric capacity sku."
  }
}

variable "ai_foundry_account_details" {
  description = "Specifies the ai foundry configuration."
  type = object({
    enabled = optional(bool, false)
    search_service = optional(object({
      sku                 = optional(string, "basic")
      semantic_search_sku = optional(string, "standard")
      partition_count     = optional(number, 1)
      replica_count       = optional(number, 1)
    }), {})
    cosmos_db = optional(object({
      consistency_level = optional(string, "Session")
    }), {})
  })
  sensitive = false
  nullable  = false
  default   = {}
}

# HA/DR variables
variable "zone_redundancy_enabled" {
  description = "Specifies whether zone-redundancy should be enabled for all resources."
  type        = bool
  sensitive   = false
  nullable    = false
  default     = true
}

variable "geo_redundancy_storage_enabled" {
  description = "Specifies whether geo-redundancy should be enabled for the storage layers."
  type = object({
    provider  = optional(bool, false)
    raw       = optional(bool, false)
    enriched  = optional(bool, false)
    curated   = optional(bool, false)
    workspace = optional(bool, false)
  })
  sensitive = false
  nullable  = false
  default   = {}
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

# Identity variables
variable "service_principal_name_terraform_plan" {
  description = "Specifies the name of the service principal used for the Terraform plan in PRs."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.service_principal_name_terraform_plan == "" || length(var.service_principal_name_terraform_plan) >= 2
    error_message = "Please specify a valid name."
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

variable "subnet_id_storage" {
  description = "Specifies the id of the storage subnet used for the storage accounts."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.subnet_id_storage)) == 11
    error_message = "Please specify a valid resource ID."
  }
}

variable "subnet_id_consumption" {
  description = "Specifies the id of the consumption subnet used for the databricks workspaces."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.subnet_id_consumption)) == 11
    error_message = "Please specify a valid resource ID."
  }
}

variable "subnet_id_aifoundry" {
  description = "Specifies the id of the ai foundry subnet used for the agent service."
  type        = string
  sensitive   = false
  validation {
    condition     = var.subnet_id_aifoundry == "" || length(split("/", var.subnet_id_aifoundry)) == 11
    error_message = "Please specify a valid resource ID."
  }
}

variable "subnet_id_engineering_private" {
  description = "Specifies the id of the private subnet used for the databricks workspace for engineering."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.subnet_id_engineering_private)) == 11
    error_message = "Please specify a valid resource ID."
  }
}

variable "subnet_id_engineering_public" {
  description = "Specifies the id of the public subnet used for the databricks workspace for engineering."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.subnet_id_engineering_public)) == 11
    error_message = "Please specify a valid resource ID."
  }
}

variable "subnet_id_consumption_private" {
  description = "Specifies the id of the private subnet used for the databricks workspace for ad-hoc consumption."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.subnet_id_consumption_private == "" || length(split("/", var.subnet_id_consumption_private)) == 11
    error_message = "Please specify a valid resource ID."
  }
}

variable "subnet_id_consumption_public" {
  description = "Specifies the id of the public subnet used for the databricks workspace for ad-hoc consumption."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.subnet_id_consumption_public == "" || length(split("/", var.subnet_id_consumption_public)) == 11
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

variable "private_dns_zone_id_queue" {
  description = "Specifies the resource ID of the private DNS zone for Azure Storage queue endpoints. Not required if DNS A-records get created via Azure Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_queue == "" || (length(split("/", var.private_dns_zone_id_queue)) == 9 && endswith(var.private_dns_zone_id_queue, "privatelink.queue.core.windows.net"))
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

variable "private_dns_zone_id_cognitive_account" {
  description = "Specifies the resource ID of the private DNS zone for Azure Cognitive Services. Not required if DNS A-records get created via Azure Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_cognitive_account == "" || (length(split("/", var.private_dns_zone_id_cognitive_account)) == 9 && (endswith(var.private_dns_zone_id_cognitive_account, "privatelink.cognitiveservices.azure.com")))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_open_ai" {
  description = "Specifies the resource ID of the private DNS zone for Azure Open AI. Not required if DNS A-records get created via Azure Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_open_ai == "" || (length(split("/", var.private_dns_zone_id_open_ai)) == 9 && (endswith(var.private_dns_zone_id_open_ai, "privatelink.openai.azure.com")))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_ai_services" {
  description = "Specifies the resource ID of the private DNS zone for Azure Foundry (AI Services). Not required if DNS A-records get created via Azure Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_ai_services == "" || (length(split("/", var.private_dns_zone_id_ai_services)) == 9 && endswith(var.private_dns_zone_id_ai_services, "privatelink.services.ai.azure.com"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_search_service" {
  description = "Specifies the resource ID of the private DNS zone for Azure Cognitive Search endpoints. Not required if DNS A-records get created via Azure Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_search_service == "" || (length(split("/", var.private_dns_zone_id_search_service)) == 9 && endswith(var.private_dns_zone_id_search_service, "privatelink.search.windows.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_cosmos_sql" {
  description = "Specifies the resource ID of the private DNS zone for cosmos db sql. Not required if DNS A-records get created via Azure Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_cosmos_sql == "" || (length(split("/", var.private_dns_zone_id_cosmos_sql)) == 9 && endswith(var.private_dns_zone_id_cosmos_sql, "privatelink.documents.azure.com"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

# Customer-managed key variables
variable "customer_managed_key" {
  description = "Specifies the customer managed key configurations."
  type = object({
    key_vault_id                     = string,
    key_vault_key_id                 = string,
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
      var.customer_managed_key == null || startswith(try(var.customer_managed_key.key_vault_key_id, ""), "https://"),
      var.customer_managed_key == null || startswith(try(var.customer_managed_key.key_vault_key_versionless_id, ""), "https://"),
      var.customer_managed_key == null || length(split("/", try(var.customer_managed_key.user_assigned_identity_id, ""))) == 9,
      var.customer_managed_key == null || length(try(var.customer_managed_key.user_assigned_identity_client_id, "")) >= 2,
    ])
    error_message = "Please specify a valid resource ID."
  }
}
