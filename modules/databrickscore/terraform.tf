terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.81"
      configuration_aliases = [
        databricks.account
      ]
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}
