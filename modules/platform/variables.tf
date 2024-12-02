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

variable "subnet_cidr_range_storage" {
  description = "Specifies the cidr ranges of the storage subnet used for the Data Landing Zone."
  type        = string
  sensitive   = false
  validation {
    condition     = try(cidrnetmask(var.subnet_cidr_range_storage), "invalid") != "invalid"
    error_message = "Please specify a valid CIDR range for the storage subnet."
  }
}

variable "subnet_cidr_range_fabric" {
  description = "Specifies the cidr ranges of the fabric subnet used for the Data Landing Zone."
  type        = string
  sensitive   = false
  validation {
    condition     = try(cidrnetmask(var.subnet_cidr_range_fabric), "invalid") != "invalid"
    error_message = "Please specify a valid CIDR range for the fabric subnet."
  }
}

variable "subnet_cidr_range_engineering_private" {
  description = "Specifies the cidr ranges of the engineering private subnet used for the Data Landing Zone."
  type        = string
  sensitive   = false
  validation {
    condition     = try(cidrnetmask(var.subnet_cidr_range_engineering_private), "invalid") != "invalid"
    error_message = "Please specify a valid CIDR range for the consumption private subnet."
  }
}

variable "subnet_cidr_range_engineering_public" {
  description = "Specifies the cidr ranges of the engineering public subnet used for the Data Landing Zone."
  type        = string
  sensitive   = false
  validation {
    condition     = try(cidrnetmask(var.subnet_cidr_range_engineering_public), "invalid") != "invalid"
    error_message = "Please specify a valid CIDR range for the consumption public subnet."
  }
}

variable "subnet_cidr_range_consumption_private" {
  description = "Specifies the cidr ranges of the consumption private subnet used for the Data Landing Zone."
  type        = string
  sensitive   = false
  validation {
    condition     = try(cidrnetmask(var.subnet_cidr_range_consumption_private), "invalid") != "invalid"
    error_message = "Please specify a valid CIDR range for the consumption private subnet."
  }
}

variable "subnet_cidr_range_consumption_public" {
  description = "Specifies the cidr ranges of the consumption public subnet used for the Data Landing Zone."
  type        = string
  sensitive   = false
  validation {
    condition     = try(cidrnetmask(var.subnet_cidr_range_consumption_public), "invalid") != "invalid"
    error_message = "Please specify a valid CIDR range for the consumption public subnet."
  }
}

variable "subnet_cidr_range_applications" {
  description = "Specifies the cidr ranges of the data application subnets used for the Data Landing Zone."
  type = map(object({
    private_endpoint_subnet = string
    # databricks_private_subnet = optional(string, "")
    # databricks_public_subnet  = optional(string, "")
  }))
  sensitive = false
  validation {
    condition = alltrue([
      for key, value in var.subnet_cidr_range_applications : try(cidrnetmask(value.private_endpoint_subnet), "invalid") != "invalid"
    ])
    error_message = "Please specify a valid CIDR range for the private endpoint subnets of all applications."
  }
  # validation {
  #   condition = alltrue([
  #     for key, value in var.subnet_cidr_range_applications : value.databricks_private_subnet == "" || try(cidrnetmask(value.databricks_private_subnet), "invalid") != "invalid"
  #   ])
  #   error_message = "Please specify a valid CIDR range for the databricks private subnets of all applications."
  # }
  # validation {
  #   condition = alltrue([
  #     for key, value in var.subnet_cidr_range_applications : value.databricks_public_subnet == "" || try(cidrnetmask(value.databricks_public_subnet), "invalid") != "invalid"
  #   ])
  #   error_message = "Please specify a valid CIDR range for the databricks public subnets of all applications."
  # }
}
