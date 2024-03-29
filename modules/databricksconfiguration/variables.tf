variable "key_vault_id" {
  description = "Specifies the resource ID of the key vault used for the platform."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.key_vault_id)) == 9
    error_message = "Please specify a valid resource ID."
  }
}

variable "key_vault_uri" {
  description = "Specifies the uri of the key vault used for the platform."
  type        = string
  sensitive   = false
  validation {
    condition     = endswith(var.key_vault_uri, "vault.azure.net/")
    error_message = "Please specify a valid uri."
  }
}

variable "client_id_secret_name" {
  description = "Specifies the AAD client id secret name in the key vault."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.client_id_secret_name == "" || length(var.client_id_secret_name) >= 2
    error_message = "Please specify a valid name."
  }
}

variable "client_secret_secret_name" {
  description = "Specifies the AAD client secret secret-name in the key vault."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.client_secret_secret_name == "" || length(var.client_secret_secret_name) >= 2
    error_message = "Please specify a valid name."
  }
}

variable "databricks_workspace_id" {
  description = "Specifies the id of the Databricks workspace."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.databricks_workspace_id == "" || length(var.databricks_workspace_id) >= 2
    error_message = "Please specify a valid name."
  }
}

variable "databricks_admin_groupname" {
  description = "Specifies the pre-existing databricks account admin group name (available in https://accounts.azuredatabricks.net/) that should be granted access to the Databricks workspace artifacts. This feature requires you to grant Databricks account admin access to your Service Principal."
  type        = string
  sensitive   = false
  validation {
    condition     = var.databricks_admin_groupname == "" || length(var.databricks_admin_groupname) >= 2
    error_message = "Please specify a valid Databricks account group name."
  }
}

variable "databricks_cluster_policies" {
  description = "Specifies the databricks cluster policies that should be added to the workspace."
  type        = any
  sensitive   = false
  default     = {}
}

variable "unity_metastore_name" {
  description = "Specifies the name of the Databricks Unity metastore."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.unity_metastore_name == "" || length(var.unity_metastore_name) >= 2
    error_message = "Please specify a valid name."
  }
}

variable "unity_metastore_id" {
  description = "Specifies the id of the Databricks Unity metastore."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.unity_metastore_id == "" || length(var.unity_metastore_id) >= 2
    error_message = "Please specify a valid name."
  }
}

variable "dependencies" {
  description = "Specifies a list of dependencies."
  type        = list(bool)
  sensitive   = false
  default     = []
}
