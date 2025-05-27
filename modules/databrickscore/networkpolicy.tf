resource "databricks_account_network_policy" "account_network_policy" {
  provider = databricks.account

  account_id        = var.databricks_account_id
  network_policy_id = "${local.prefix}-default"
  egress = {
    network_access = {
      restriction_mode              = "RESTRICTED_ACCESS"
      allowed_internet_destinations = var.databricks_network_policy_details.allowed_internet_destinations
      allowed_storage_destinations  = var.databricks_network_policy_details.allowed_storage_destinations
      policy_enforcement = {
        dry_run_mode_product_filter = []
        enforcement_mode            = "ENFORCED"
      }
    }
  }
}
