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

variable "admin_username" {
  description = "Specifies the admin username of the VMs used for the Self-hosted Integration Runtimes."
  type        = string
  sensitive   = false
  default     = "VmMainUser"
  validation {
    condition     = can(regex("^[0-9A-Za-z]+$", var.admin_username))
    error_message = "Please specify a valid user name."
  }
}

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
      storage_subnet                = optional(string, "")
      runtimes_subnet               = optional(string, "")
      powerbi_subnet                = optional(string, "")
      shared_app_aut_subnet         = optional(string, "")
      shared_app_exp_subnet         = optional(string, "")
      databricks_private_subnet_001 = optional(string, "")
      databricks_public_subnet_001  = optional(string, "")
      databricks_private_subnet_002 = optional(string, "")
      databricks_public_subnet_002  = optional(string, "")
    }
  )
  sensitive = false
  default   = {}
  validation {
    condition = alltrue([
      var.subnet_cidr_ranges.storage_subnet == "" || try(cidrnetmask(var.subnet_cidr_ranges.storage_subnet), "invalid") != "invalid",
      var.subnet_cidr_ranges.runtimes_subnet == "" || try(cidrnetmask(var.subnet_cidr_ranges.runtimes_subnet), "invalid") != "invalid",
      var.subnet_cidr_ranges.powerbi_subnet == "" || try(cidrnetmask(var.subnet_cidr_ranges.powerbi_subnet), "invalid") != "invalid",
      var.subnet_cidr_ranges.shared_app_exp_subnet == "" || try(cidrnetmask(var.subnet_cidr_ranges.shared_app_exp_subnet), "invalid") != "invalid",
      var.subnet_cidr_ranges.databricks_private_subnet_001 == "" || try(cidrnetmask(var.subnet_cidr_ranges.databricks_private_subnet_001), "invalid") != "invalid",
      var.subnet_cidr_ranges.databricks_public_subnet_001 == "" || try(cidrnetmask(var.subnet_cidr_ranges.databricks_public_subnet_001), "invalid") != "invalid",
      var.subnet_cidr_ranges.databricks_private_subnet_002 == "" || try(cidrnetmask(var.subnet_cidr_ranges.databricks_private_subnet_002), "invalid") != "invalid",
      var.subnet_cidr_ranges.databricks_public_subnet_002 == "" || try(cidrnetmask(var.subnet_cidr_ranges.databricks_public_subnet_002), "invalid") != "invalid",
    ])
    error_message = "Please specify a valid CIDR range for all subnets."
  }
}

variable "enable_databricks_auth_private_endpoint" {
  description = "Specifies whether to deploy the private endpoint used for browser authentication. Create one of these per region for all Azure Databricks workspaces as this will be shared."
  type        = bool
  sensitive   = false
  default     = false
}

variable "purview_id" {
  description = "Specifies the resource ID of the default Purview Account for the Data Landing Zone."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.purview_id == "" || length(split("/", var.purview_id)) == 9
    error_message = "Please specify a valid resource ID."
  }
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

variable "databricks_admin_groupname" {
  description = "Specifies the databricks admin group name that should be granted access to the Databricks workspace artifacts."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.databricks_admin_groupname == "" || length(var.databricks_admin_groupname) >= 2
    error_message = "Please specify a valid group name."
  }
}

variable "data_platform_subscription_ids" {
  description = "Specifies the list of subscription IDs of your data platform."
  type        = list(string)
  sensitive   = false
  default     = []
}

variable "data_product_template_file_variables" {
  description = "If specified, provides the ability to define custom template variables used when reading in data product template files from the library path."
  type        = any
  sensitive   = false
  default     = {}
}

variable "private_dns_zone_id_blob" {
  description = "Specifies the resource ID of the private DNS zone for Azure Storage blob endpoints. Not required if DNS A-records get created via Azue Policy."
  type        = string
  sensitive   = false
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
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_dfs == "" || (length(split("/", var.private_dns_zone_id_dfs)) == 9 && endswith(var.private_dns_zone_id_dfs, "privatelink.dfs.core.windows.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_queue" {
  description = "Specifies the resource ID of the private DNS zone for Azure Storage queue endpoints. Not required if DNS A-records get created via Azue Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_queue == "" || (length(split("/", var.private_dns_zone_id_queue)) == 9 && endswith(var.private_dns_zone_id_queue, "privatelink.queue.core.windows.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_table" {
  description = "Specifies the resource ID of the private DNS zone for Azure Storage table endpoints. Not required if DNS A-records get created via Azue Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_table == "" || (length(split("/", var.private_dns_zone_id_table)) == 9 && endswith(var.private_dns_zone_id_table, "privatelink.table.core.windows.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_key_vault" {
  description = "Specifies the resource ID of the private DNS zone for Azure Key Vault. Not required if DNS A-records get created via Azue Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_key_vault == "" || (length(split("/", var.private_dns_zone_id_key_vault)) == 9 && endswith(var.private_dns_zone_id_key_vault, "privatelink.vaultcore.azure.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_data_factory" {
  description = "Specifies the resource ID of the private DNS zone for Azure Data Factory. Not required if DNS A-records get created via Azue Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_data_factory == "" || (length(split("/", var.private_dns_zone_id_data_factory)) == 9 && endswith(var.private_dns_zone_id_data_factory, "privatelink.datafactory.azure.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_data_factory_portal" {
  description = "Specifies the resource ID of the private DNS zone for Azure Data Factory Portal. Not required if DNS A-records get created via Azue Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_data_factory_portal == "" || (length(split("/", var.private_dns_zone_id_data_factory_portal)) == 9 && endswith(var.private_dns_zone_id_data_factory_portal, "privatelink.adf.azure.com"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

variable "private_dns_zone_id_databricks" {
  description = "Specifies the resource ID of the private DNS zone for Azure Databricks UI endpoints. Not required if DNS A-records get created via Azue Policy."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.private_dns_zone_id_databricks == "" || (length(split("/", var.private_dns_zone_id_databricks)) == 9 && endswith(var.private_dns_zone_id_databricks, "privatelink.azuredatabricks.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}
