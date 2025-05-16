resource "databricks_ip_access_list" "ip_access_list_allow_engineering" {
  count = length(var.databricks_ip_access_list_allow) > 0 ? 1 : 0

  enabled      = true
  ip_addresses = []
  label        = "allow-list"
  list_type    = "ALLOW"
}

resource "databricks_ip_access_list" "ip_access_list_deny_engineering" {
  count = length(var.databricks_ip_access_list_deny) > 0 ? 1 : 0

  enabled      = true
  ip_addresses = []
  label        = "deny-list"
  list_type    = "BLOCK"
}
