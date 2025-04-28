terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "2.3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.3.0"
    }
    fabric = {
      source  = "microsoft/fabric"
      version = "1.0.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.74.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
  }

  backend "azurerm" {
    environment          = "public"
    resource_group_name  = "<provided-via-config>"
    storage_account_name = "<provided-via-config>"
    container_name       = "<provided-via-config>"
    key                  = "<provided-via-config>"
    use_azuread_auth     = true
  }
}
