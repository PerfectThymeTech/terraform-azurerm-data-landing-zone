provider "databricks" {
  azure_environment    = "public"
  host                 = "https://accounts.azuredatabricks.net"
  account_id           = var.databricks_account_id
  http_timeout_seconds = 60
  rate_limit           = 15
  skip_verify          = false
}

provider "databricks" {
  alias                       = "engineering"
  azure_environment           = "public"
  azure_workspace_resource_id = module.core.databricks_workspace_details.engineering.id
  host                        = module.core.databricks_workspace_details.engineering.workspace_url
  http_timeout_seconds        = 60
  rate_limit                  = 15
  skip_verify                 = false
}

provider "databricks" {
  alias                       = "consumption"
  azure_environment           = "public"
  azure_workspace_resource_id = module.core.databricks_workspace_details.consumption.id
  host                        = module.core.databricks_workspace_details.consumption.workspace_url
  http_timeout_seconds        = 60
  rate_limit                  = 15
  skip_verify                 = false
}
