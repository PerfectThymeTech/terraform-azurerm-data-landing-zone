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
    condition     = contains(["dev", "tst", "qa", "prd"], var.environment)
    error_message = "Please use an allowed value: \"dev\", \"tst\", \"qa\" or \"prd\"."
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

variable "databricks_workspace_workspace_id" {
  description = "Specifies the workspace id of the databricks workspace."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.databricks_workspace_workspace_id) >= 2
    error_message = "Please specify a valid workspace id."
  }
}

variable "databricks_cluster_policies" {
  description = "Specifies the databricks cluster policies that should be added to the workspace."
  type        = any
  sensitive   = false
  default     = {}
}

variable "databricks_keyvault_secret_scope_details" {
  description = "Specifies the databricks key vault secret scope details that should be added to the workspace."
  type = object({
    key_vault_uri = optional(string, "")
    key_vault_id  = optional(string, "")
  })
  sensitive = false
  nullable  = false
  default   = {}
  validation {
    condition     = var.databricks_keyvault_secret_scope_details.key_vault_uri == "" && var.databricks_keyvault_secret_scope_details.key_vault_id == "" || var.databricks_keyvault_secret_scope_details.key_vault_uri != "" && var.databricks_keyvault_secret_scope_details.key_vault_id != ""
    error_message = "Please provide valid key vault details."
  }
}

variable "budget" {
  description = "Specifies the budget details."
  type = object({
    categories = object({
      databricks = number
    })
    endpoints = object({
      email = string
    })
  })
  sensitive = false
  nullable  = false
  validation {
    condition     = var.budget.categories.databricks > 0
    error_message = "Please provide a valid budget greater than 0."
  }
}