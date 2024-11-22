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
variable "databricks_workspace_details" {
  description = "Specifies the workspace details of databricks workspaces."
  type = map(object({
    workspace_id = string
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
