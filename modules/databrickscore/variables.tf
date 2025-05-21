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
variable "storage_account_ids" {
  description = "Specifies the ids of the storage accounts in the core layer."
  type = object({
    provider  = string
    raw       = string
    enriched  = string
    curated   = string
    workspace = string
  })
  sensitive = false
  validation {
    condition     = length(split("/", var.storage_account_ids.provider)) == 9
    error_message = "Please specify a valid provider storage account id."
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

variable "storage_dependencies" {
  description = "Specifies a list of dependencies for storage resources."
  type        = list(bool)
  sensitive   = false
  default     = []
}

variable "databricks_workspace_details" {
  description = "Specifies the workspace details of databricks workspaces."
  type = map(object({
    id                            = string
    workspace_id                  = string
    workspace_url                 = string
    access_connector_id           = string
    access_connector_principal_id = string
  }))
  sensitive = false
  nullable  = false
  default   = {}
}

variable "databricks_private_endpoint_rules" {
  description = "Specifies the private endpoint outbound rules for databricks ncc."
  type = map(object({
    resource_id = string
    group_id    = string
  }))
  sensitive = false
  nullable  = false
  default   = {}
}

variable "databricks_ip_access_list_allow" {
  description = "Specifies the ip access allow-list for the databricks workspace."
  type        = list(string)
  sensitive   = false
  default     = []
}

variable "databricks_ip_access_list_deny" {
  description = "Specifies the ip access deny-list for the databricks workspace."
  type        = list(string)
  sensitive   = false
  default     = []
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
