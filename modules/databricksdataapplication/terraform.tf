terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.60"
      configuration_aliases = [
        databricks.account
      ]
    }
  }
}
