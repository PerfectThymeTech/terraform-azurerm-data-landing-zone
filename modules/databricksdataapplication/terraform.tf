terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.69"
      configuration_aliases = [
        databricks.account
      ]
    }
  }
}
