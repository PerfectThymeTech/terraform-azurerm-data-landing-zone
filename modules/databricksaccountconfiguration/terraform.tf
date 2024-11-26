terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.59"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}
