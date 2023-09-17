terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.71.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "1.8.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.25.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.41.0"
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

data "azurerm_client_config" "current" {}

provider "azurerm" {
  disable_correlation_request_id = false
  environment                    = "public"
  skip_provider_registration     = false
  storage_use_azuread            = true
  # use_oidc                       = true

  features {
    application_insights {
      disable_generated_rule = false
    }
    cognitive_account {
      purge_soft_delete_on_destroy = true
    }
    key_vault {
      purge_soft_delete_on_destroy               = false
      purge_soft_deleted_certificates_on_destroy = false
      purge_soft_deleted_keys_on_destroy         = false
      purge_soft_deleted_secrets_on_destroy      = false
      recover_soft_deleted_key_vaults            = true
      recover_soft_deleted_certificates          = true
      recover_soft_deleted_keys                  = true
      recover_soft_deleted_secrets               = true
    }
    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azapi" {
  default_location               = var.location
  default_tags                   = var.tags
  disable_correlation_request_id = false
  environment                    = "public"
  skip_provider_registration     = false
  # use_oidc                       = true
}

provider "azuread" {
  tenant_id = data.azurerm_client_config.current.tenant_id
}

provider "databricks" {
  alias      = "account"
  host       = "https://accounts.azuredatabricks.net"
  account_id = "581824c3-9c92-47ef-8512-e2891cd9ae45"
}
