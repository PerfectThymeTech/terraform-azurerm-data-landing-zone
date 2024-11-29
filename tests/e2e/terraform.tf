terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.11.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "2.0.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.0.2"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.59.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
  }

  backend "azurerm" {
    environment          = "public"
    resource_group_name  = "mycrp-prd-cicd"
    storage_account_name = "mycrpprdstg001"
    container_name       = "data-landing-zone"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
    # use_oidc             = true
  }
}
