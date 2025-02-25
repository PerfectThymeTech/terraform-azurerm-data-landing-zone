resource "azurerm_private_endpoint" "private_endpoint" {
  for_each = var.private_endpoints

  name                = "${local.prefix}-${each.key}-pe"
  resource_group_name = azurerm_resource_group.resource_group_app.name
  location            = var.location

  custom_network_interface_name = "${local.prefix}-${each.key}-nic"
  private_service_connection {
    name                           = "${local.prefix}-${each.key}-svc"
    is_manual_connection           = true
    private_connection_resource_id = each.value.resource_id
    request_message                = "Private Endpoint Connection Request from Data Landing Zone Stamp Application with prefix: ${local.prefix}"
    subresource_names              = [each.value.subresource_name]
  }
  subnet_id = var.subnet_id_app
  dynamic "private_dns_zone_group" {
    for_each = each.value.private_dns_zone_id == "" ? [] : [1]
    content {
      name = "${local.prefix}-${each.key}-arecord"
      private_dns_zone_ids = [
        each.value.private_dns_zone_id
      ]
    }
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}
