terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      version = "~> 1.59"
      configuration_aliases = [
        databricks.account
      ]
    }
  }
}
