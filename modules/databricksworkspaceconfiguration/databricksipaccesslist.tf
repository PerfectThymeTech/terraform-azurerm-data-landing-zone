resource "databricks_ip_access_list" "ip_access_list_allow" {
  enabled      = true
  ip_addresses = []
  label        = "allow-list"
  list_type    = "ALLOW"
}
