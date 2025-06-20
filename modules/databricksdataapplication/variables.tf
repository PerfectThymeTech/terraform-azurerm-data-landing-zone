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

variable "databricks_account_id" {
  description = "Specifies the databricks account id."
  type        = string
  sensitive   = false
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

variable "databricks_workspace_binding_catalog" {
  description = "Specifies the workspace ids of the databricks workspaces to which the catalog should be connected."
  type = map(object({
    workspace_id = string
  }))
  sensitive = false
  nullable  = false
  default   = {}
}

variable "databricks_access_connector_id" {
  description = "Specifies the id of the databricks access connector."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.databricks_access_connector_id)) == 9
    error_message = "Please specify a valid workspace id."
  }
}

variable "databricks_cluster_policy_library_path" {
  description = "Specifies the databricks cluster policy library path."
  type        = string
  sensitive   = false
  default     = ""
}

variable "databricks_cluster_policy_file_variables" {
  description = "Specifies custom template variables used when reading in databricks policy template files from the library path."
  type        = map(string)
  sensitive   = false
  default     = {}
}

variable "databricks_cluster_policy_file_overwrites" {
  description = "Specifies policy properties which must be overwritten in the databricks policy template files from the library path."
  type        = any
  sensitive   = false
  default     = {}
}

variable "databricks_keyvault_secret_scope_details" {
  description = "Specifies the databricks key vault secret scope details that should be added to the workspace."
  type = object({
    key_vault_name = optional(string, "")
    key_vault_uri  = optional(string, "")
    key_vault_id   = optional(string, "")
  })
  sensitive = false
  nullable  = false
  default   = {}
  validation {
    condition     = var.databricks_keyvault_secret_scope_details.key_vault_name == "" && var.databricks_keyvault_secret_scope_details.key_vault_uri == "" && var.databricks_keyvault_secret_scope_details.key_vault_id == "" || var.databricks_keyvault_secret_scope_details.key_vault_name != "" && var.databricks_keyvault_secret_scope_details.key_vault_uri != "" && var.databricks_keyvault_secret_scope_details.key_vault_id != ""
    error_message = "Please provide valid key vault details."
  }
}

variable "databricks_data_factory_details" {
  description = "Specifies the databricks data factory details to onboard the managed identity to the account."
  type = object({
    data_factory_enabled      = optional(bool, false)
    data_factory_name         = optional(string, "")
    data_factory_id           = optional(string, "")
    data_factory_principal_id = optional(string, "")
    data_factory_client_id    = optional(string, "")
  })
  sensitive = false
  nullable  = false
  default   = {}
  validation {
    condition     = var.databricks_data_factory_details.data_factory_name == "" && var.databricks_data_factory_details.data_factory_id == "" && var.databricks_data_factory_details.data_factory_principal_id == "" || var.databricks_data_factory_details.data_factory_name != "" && var.databricks_data_factory_details.data_factory_id != "" && var.databricks_data_factory_details.data_factory_principal_id != ""
    error_message = "Please provide valid data factory details."
  }
}

variable "databricks_user_assigned_identity_details" {
  description = "Specifies the databricks data factory details to onboard the managed identity to the account."
  type = object({
    user_assigned_identity_enabled      = optional(bool, false)
    user_assigned_identity_name         = optional(string, "")
    user_assigned_identity_id           = optional(string, "")
    user_assigned_identity_principal_id = optional(string, "")
    user_assigned_identity_client_id    = optional(string, "")
  })
  sensitive = false
  nullable  = false
  default   = {}
  validation {
    condition     = var.databricks_user_assigned_identity_details.user_assigned_identity_name == "" && var.databricks_user_assigned_identity_details.user_assigned_identity_id == "" && var.databricks_user_assigned_identity_details.user_assigned_identity_principal_id == "" || var.databricks_user_assigned_identity_details.user_assigned_identity_name != "" && var.databricks_user_assigned_identity_details.user_assigned_identity_id != "" && var.databricks_user_assigned_identity_details.user_assigned_identity_principal_id != ""
    error_message = "Please provide valid data factory details."
  }
}

variable "databricks_sql_endpoint_details" {
  description = "Specifies the databricks sql endpoint details to create pro SQL warehouses."
  type = map(object({
    auto_stop_mins            = optional(number, 60)
    enable_serverless_compute = optional(bool, false)
    cluster_size              = optional(string, "2X-Small")
    min_num_clusters          = optional(number, 1)
    max_num_clusters          = optional(number, 1)
  }))
  sensitive = false
  nullable  = false
  default   = {}
  validation {
    condition = alltrue([
      length([for auto_stop_mins in values(var.databricks_sql_endpoint_details)[*].auto_stop_mins : auto_stop_mins if auto_stop_mins < 0 || auto_stop_mins > 120]) <= 0,
      length([for cluster_size in values(var.databricks_sql_endpoint_details)[*].cluster_size : cluster_size if !contains(["2X-Small", "X-Small", "Small", "Medium", "Large", "X-Large", "2X-Large", "3X-Large", "4X-Large"], cluster_size)]) <= 0,
      length([for min_num_clusters in values(var.databricks_sql_endpoint_details)[*].min_num_clusters : min_num_clusters if min_num_clusters < 1]) <= 0,
      length([for max_num_clusters in values(var.databricks_sql_endpoint_details)[*].max_num_clusters : max_num_clusters if max_num_clusters < 1]) <= 0,
    ])
    error_message = "Please specify a valid sql endpoint configuration."
  }
}

variable "storage_container_ids" {
  description = "Specifies the storage container ids that will be used for the external locations."
  type = object({
    provider  = optional(map(string), {})
    raw       = optional(string, "")
    enriched  = optional(string, "")
    curated   = optional(string, "")
    workspace = optional(string, "")
  })
  sensitive = false
  nullable  = false
  default   = {}
  validation {
    condition = alltrue([
      length([for id in values(var.storage_container_ids.provider)[*] : id if length(split("/", id)) != 13]) <= 0,
    ])
    error_message = "Please provide valid provider storage container id."
  }
  validation {
    condition     = var.storage_container_ids.raw == "" || length(split("/", var.storage_container_ids.raw)) == 13
    error_message = "Please provide valid raw storage container id."
  }
  validation {
    condition     = var.storage_container_ids.enriched == "" || length(split("/", var.storage_container_ids.enriched)) == 13
    error_message = "Please provide valid curated storage container id."
  }
  validation {
    condition     = var.storage_container_ids.curated == "" || length(split("/", var.storage_container_ids.curated)) == 13
    error_message = "Please provide valid curated storage container id."
  }
  validation {
    condition     = var.storage_container_ids.workspace == "" || length(split("/", var.storage_container_ids.workspace)) == 13
    error_message = "Please provide valid workspace storage container id."
  }
}

variable "storage_queue_ids" {
  description = "Specifies the storage queue ids that will be used for the external locations."
  type = object({
    provider  = optional(map(string), {})
    raw       = optional(string, "")
    enriched  = optional(string, "")
    curated   = optional(string, "")
    workspace = optional(string, "")
  })
  sensitive = false
  nullable  = false
  default   = {}
  validation {
    condition = alltrue([
      length([for id in values(var.storage_queue_ids.provider)[*] : id if !(startswith(var.storage_queue_ids.raw, "https://") && strcontains(var.storage_queue_ids.raw, ".queue.core.windows.net/"))]) <= 0,
    ])
    error_message = "Please provide valid provider storage queue id."
  }
  validation {
    condition     = var.storage_queue_ids.raw == "" || (startswith(var.storage_queue_ids.raw, "https://") && strcontains(var.storage_queue_ids.raw, ".queue.core.windows.net/"))
    error_message = "Please provide valid raw storage queue id."
  }
  validation {
    condition     = var.storage_queue_ids.enriched == "" || (startswith(var.storage_queue_ids.enriched, "https://") && strcontains(var.storage_queue_ids.enriched, ".queue.core.windows.net/"))
    error_message = "Please provide valid curated storage queue id."
  }
  validation {
    condition     = var.storage_queue_ids.curated == "" || (startswith(var.storage_queue_ids.curated, "https://") && strcontains(var.storage_queue_ids.curated, ".queue.core.windows.net/"))
    error_message = "Please provide valid curated storage queue id."
  }
  validation {
    condition     = var.storage_queue_ids.workspace == "" || (startswith(var.storage_queue_ids.workspace, "https://") && strcontains(var.storage_queue_ids.workspace, ".queue.core.windows.net/"))
    error_message = "Please provide valid workspace storage queue id."
  }
}

variable "data_provider_details" {
  description = "Specifies the list of data provider systems that are pushing data."
  type = map(object({
    service_principal_names = optional(list(string), [])
    group_names             = optional(list(string), [])
    databricks_catalog = optional(object({
      enabled                   = optional(bool, false)
      workspace_binding_catalog = optional(list(string), [])
    }), {})
  }))
  sensitive = false
  default   = {}
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
    condition     = var.service_principal_name == "" || length(var.service_principal_name) >= 2
    error_message = "Please specify a valid Entra ID service principal name."
  }
}

variable "databricks_service_principal_terraform_plan_details" {
  description = "Specifies the application id of the service principal used for Terraform Plan."
  type = object({
    application_id   = optional(string, "")
    acl_principal_id = optional(string, "")
  })
  sensitive = false
  default   = {}
  validation {
    condition     = var.databricks_service_principal_terraform_plan_details.application_id == "" || length(var.databricks_service_principal_terraform_plan_details.application_id) >= 2
    error_message = "Please specify a valid application id."
  }
  validation {
    condition     = var.databricks_service_principal_terraform_plan_details.acl_principal_id == "" || length(var.databricks_service_principal_terraform_plan_details.acl_principal_id) >= 2
    error_message = "Please specify a valid acl principal id."
  }
}

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
