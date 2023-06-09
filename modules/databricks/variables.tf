variable "location" {
  description = "Specifies the location for all Azure resources."
  type        = string
  sensitive   = false
}

variable "workspace_name" {
  description = "Specifies the name of the Databricks workspace."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.workspace_name) >= 2
    error_message = "Please specify a valid name."
  }
}

variable "key_vault_name" {
  description = "Specifies the name of the Key Vault used for your Databricks workspace."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.key_vault_name) >= 2
    error_message = "Please specify a valid name."
  }
}

variable "tags" {
  description = "Specifies the tags that you want to apply to all resources."
  type        = map(string)
  sensitive   = false
}

variable "resource_group_name" {
  description = "Specifies the resource group name"
  type        = string
  sensitive   = false
}

variable "vnet_id" {
  description = "Specifies the resource ID of the virtual network."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.vnet_id)) == 9
    error_message = "Please specify a valid resource ID."
  }
}

variable "private_subnet_name" {
  description = "Specifies the name of the private subnet."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.private_subnet_name) >= 2
    error_message = "Please specify a valid name."
  }
}

variable "private_subnet_network_security_group_association_id" {
  description = "Specifies the ID of the private subnet NSG association."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.private_subnet_network_security_group_association_id) >= 2
    error_message = "Please specify a valid ID."
  }
}

variable "public_subnet_name" {
  description = "Specifies the name of the public subnet."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.public_subnet_name) >= 2
    error_message = "Please specify a valid name."
  }
}

variable "public_subnet_network_security_group_association_id" {
  description = "Specifies the ID of the public subnet NSG association."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.public_subnet_network_security_group_association_id) >= 2
    error_message = "Please specify a valid ID."
  }
}

variable "private_endpoints_subnet_id" {
  description = "Specifies the resource ID of the subnet used for private endpoints."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.private_endpoints_subnet_id)) == 11
    error_message = "Please specify a valid resource ID."
  }
}

variable "enable_databricks_auth_private_endpoint" {
  description = "Specifies whether to deploy the private endpoint used for browser authentication. Create one of these per region for all Azure Databricks workspaces as this will be shared."
  type        = bool
  sensitive   = false
  default     = false
}

variable "private_dns_zone_id_databricks" {
  description = "Specifies the resource ID of the private DNS zone for Azure Databricks UI endpoints."
  type        = string
  sensitive   = false
  validation {
    condition     = var.private_dns_zone_id_databricks == "" || (length(split("/", var.private_dns_zone_id_databricks)) == 9 && endswith(var.private_dns_zone_id_databricks, "privatelink.azuredatabricks.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_key_vault" {
  description = "Specifies the resource ID of the private DNS zone for Azure Key Vault endpoints."
  type        = string
  sensitive   = false
  validation {
    condition     = var.private_dns_zone_id_key_vault == "" || (length(split("/", var.private_dns_zone_id_key_vault)) == 9 && endswith(var.private_dns_zone_id_key_vault, "privatelink.vaultcore.azure.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_blob" {
  description = "Specifies the resource ID of the private DNS zone for Azure Blob Storage endpoints."
  type        = string
  sensitive   = false
  validation {
    condition     = var.private_dns_zone_id_blob == "" || (length(split("/", var.private_dns_zone_id_blob)) == 9 && endswith(var.private_dns_zone_id_blob, "privatelink.blob.core.windows.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_dfs" {
  description = "Specifies the resource ID of the private DNS zone for Azure Data Lake Storage endpoints."
  type        = string
  sensitive   = false
  validation {
    condition     = var.private_dns_zone_id_dfs == "" || (length(split("/", var.private_dns_zone_id_dfs)) == 9 && endswith(var.private_dns_zone_id_dfs, "privatelink.dfs.core.windows.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}
