data "databricks_mws_network_connectivity_config" "network_connectivity_config" {
  provider = databricks.account

  name = var.databricks_network_connectivity_config_name
}
