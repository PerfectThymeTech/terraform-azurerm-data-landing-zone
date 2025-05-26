resource "databricks_workspace_network_option" "workspace_network_option" {
  provider = databricks.account

  for_each = var.databricks_workspace_details

  network_policy_id = databricks_account_network_policy.account_network_policy.network_policy_id
  workspace_id      = each.value.workspace_id
}
