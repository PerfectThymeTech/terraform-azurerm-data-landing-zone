provider "databricks" {
  for_each = local.databricks_workspace_details

  alias                       = "application"
  azure_environment           = "public"
  azure_workspace_resource_id = each.value.id
  host                        = each.value.workspace_url
  http_timeout_seconds        = 60
  rate_limit                  = 15
  skip_verify                 = false
}
