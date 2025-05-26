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
variable "data_platform_subscription_ids" {
  description = "Specifies the list of subscription IDs of your data platform."
  type        = set(string)
  sensitive   = false
  default     = []
}

variable "data_application_library_path" {
  description = "If specified, sets the path to a custom library folder for apllication artefacts."
  type        = string
  sensitive   = false
  default     = ""
}

variable "data_application_file_variables" {
  description = "If specified, provides the ability to define custom template variables used when reading in data product template files from the library path."
  type        = any
  sensitive   = false
  default     = {}
}

variable "databricks_cluster_policy_library_path" {
  description = "Specifies the databricks cluster policy library path."
  type        = string
  sensitive   = false
  default     = ""
}

variable "databricks_cluster_policy_file_variables" {
  description = "Specifies custom template variables used when reading in databricks policy template files from the library path."
  type        = any
  sensitive   = false
  default     = {}
}

variable "databricks_account_id" {
  description = "Specifies the databricks account id."
  type        = string
  sensitive   = false
}

variable "databricks_network_connectivity_config_name" {
  description = "Specifies the name of the ncc connectivity config name that should be attached to the databricks workspace."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.databricks_network_connectivity_config_name) > 2
    error_message = "Please provide a valid name for the databricks connectivity config."
  }
}

variable "databricks_network_policy_details" {
  description = "Specifies the name of the ncc connectivity config name that should be attached to the databricks workspace."
  type = object({
    allowed_internet_destinations = optional(list(object({
      destination               = string
      internet_destination_type = optional(string, "DNS_NAME")
    })), [])
    allowed_storage_destinations = optional(list(object({
      azure_storage_account    = string
      storage_destination_type = string
    })), [])
  })
  sensitive = false
  nullable  = false
  default   = {}
  validation {
    condition = alltrue([
      length([for allowed_internet_destination in toset(var.databricks_network_policy_details.allowed_internet_destinations) : true if !contains(["DNS_NAME"], allowed_internet_destination.internet_destination_type)]) <= 0
    ])
    error_message = "Please specify a valid internet destination type for all allowed internet destionations."
  }
  validation {
    condition = alltrue([
      length([for allowed_storage_destination in toset(var.databricks_network_policy_details.allowed_storage_destinations) : true if !contains(["blob", "dfs"], allowed_storage_destination.storage_destination_type)]) <= 0
    ])
    error_message = "Please specify a valid storage destination type for all allowed storage destionations."
  }
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

variable "databricks_workspace_binding_catalog" {
  description = "Specifies the workspace ids of the databricks workspaces to which the catalog should be connected."
  type = map(object({
    workspace_id = string
  }))
  sensitive = false
  nullable  = false
  default   = {}
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

# HA/DR variables
variable "zone_redundancy_enabled" {
  description = "Specifies whether zone-redundancy should be enabled for all resources."
  type        = bool
  sensitive   = false
  nullable    = false
  default     = true
}

# Logging variables
variable "log_analytics_workspace_id" {
  description = "Specifies the resource ID of a log analytics workspace for all diagnostic logs."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = length(split("/", var.log_analytics_workspace_id)) == 9 || var.log_analytics_workspace_id == ""
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

variable "nsg_id" {
  description = "Specifies the resource ID of the default network security group for the Data Landing Zone."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.nsg_id)) == 9
    error_message = "Please specify a valid resource ID."
  }
}

variable "route_table_id" {
  description = "Specifies the resource ID of the default route table for the Data Landing Zone."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.route_table_id)) == 9
    error_message = "Please specify a valid resource ID."
  }
}

variable "subnet_cidr_ranges" {
  description = "Specifies the cidr ranges of the subnets used for the Data Management Zone. If not specified, the module will automatically define the right subnet cidr ranges. For this to work, the provided vnet must have no subnets."
  type = object(
    {
      storage_subnet                        = string
      fabric_subnet                         = string
      databricks_engineering_private_subnet = string
      databricks_engineering_public_subnet  = string
      databricks_consumption_private_subnet = string
      databricks_consumption_public_subnet  = string
    }
  )
  sensitive = false
  validation {
    condition = alltrue([
      try(cidrnetmask(var.subnet_cidr_ranges.storage_subnet), "invalid") != "invalid",
      try(cidrnetmask(var.subnet_cidr_ranges.fabric_subnet), "invalid") != "invalid",
      try(cidrnetmask(var.subnet_cidr_ranges.databricks_engineering_private_subnet), "invalid") != "invalid",
      try(cidrnetmask(var.subnet_cidr_ranges.databricks_engineering_public_subnet), "invalid") != "invalid",
      try(cidrnetmask(var.subnet_cidr_ranges.databricks_consumption_private_subnet), "invalid") != "invalid",
      try(cidrnetmask(var.subnet_cidr_ranges.databricks_consumption_public_subnet), "invalid") != "invalid",
    ])
    error_message = "Please specify a valid CIDR range for all subnets."
  }
}

# DNS variables
variable "private_dns_zone_id_blob" {
  description = "Specifies the resource ID of the private DNS zone for Azure Storage blob endpoints. Not required if DNS A-records get created via Azue Policy."
  type        = string
  sensitive   = false
  nullable    = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_blob == "" || (length(split("/", var.private_dns_zone_id_blob)) == 9 && endswith(var.private_dns_zone_id_blob, "privatelink.blob.core.windows.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_dfs" {
  description = "Specifies the resource ID of the private DNS zone for Azure Storage dfs endpoints. Not required if DNS A-records get created via Azue Policy."
  type        = string
  sensitive   = false
  nullable    = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_dfs == "" || (length(split("/", var.private_dns_zone_id_dfs)) == 9 && endswith(var.private_dns_zone_id_dfs, "privatelink.dfs.core.windows.net"))
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

variable "private_dns_zone_id_databricks" {
  description = "Specifies the resource ID of the private DNS zone for Azure Databricks UI endpoints. Not required if DNS A-records get created via Azue Policy."
  type        = string
  sensitive   = false
  nullable    = false
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

variable "private_dns_zone_id_data_factory" {
  description = "Specifies the resource ID of the private DNS zone for Azure Data Factory. Not required if DNS A-records get created via Azure Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_data_factory == "" || (length(split("/", var.private_dns_zone_id_data_factory)) == 9 && endswith(var.private_dns_zone_id_data_factory, "privatelink.datafactory.azure.net"))
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
