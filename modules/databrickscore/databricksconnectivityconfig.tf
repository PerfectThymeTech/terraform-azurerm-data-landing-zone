resource "databricks_mws_network_connectivity_config" "network_connectivity_config" {
  provider = databricks.account

  name   = "${local.prefix}-connectivity"
  region = var.location
}

resource "databricks_mws_ncc_private_endpoint_rule" "ncc_private_endpoint_rule" {
  provider = databricks.account
  
  for_each = var.databricks_private_endpoint_rules

  network_connectivity_config_id = databricks_mws_network_connectivity_config.network_connectivity_config.network_connectivity_config_id

  resource_id = each.value.resource_id
  group_id    = each.value.group_id
}

resource "databricks_mws_ncc_binding" "ncc_binding" {
  provider = databricks.account
  
  for_each = var.databricks_workspace_details

  network_connectivity_config_id = databricks_mws_network_connectivity_config.network_connectivity_config.network_connectivity_config_id

  workspace_id = each.value.workspace_id
}

resource "null_resource" "ncc_private_endpoint_rule_approval" {
  for_each = var.databricks_private_endpoint_rules

  triggers = {
    resource_id = each.value.resource_id
    group_id    = each.value.group_id
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/../../scripts"
    interpreter = ["pwsh", "-Command"]
    command     = "./Approve-ManagedPrivateEndpoint.ps1 -ResourceId '${each.value.resource_id}' -ManagedPrivateEndpointName '${databricks_mws_ncc_private_endpoint_rule.ncc_private_endpoint_rule[each.key].endpoint_name}'"
  }
}
