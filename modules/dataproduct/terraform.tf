terraform {
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
      configuration_aliases = [
        databricks.automation,
        databricks.experimentation,
      ]
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.39.0"
    }
  }
}
