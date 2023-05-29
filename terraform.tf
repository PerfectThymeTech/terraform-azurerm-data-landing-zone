terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.56.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.5.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = ">= 1.16.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.39.0"
    }
  }
}

provider "databricks" {
  alias      = "account"
  host       = "https://accounts.azuredatabricks.net"
  account_id = var.databricks_account_id
}

provider "databricks" {
  alias                       = "automation"
  azure_environment           = "public"
  azure_workspace_resource_id = module.databricks_automation.databricks_id
  host                        = module.databricks_automation.databricks_workspace_url
  http_timeout_seconds        = 600
}

provider "databricks" {
  alias                       = "experimentation"
  azure_environment           = "public"
  azure_workspace_resource_id = module.databricks_experimentation.databricks_id
  host                        = module.databricks_experimentation.databricks_workspace_url
  http_timeout_seconds        = 600
}
