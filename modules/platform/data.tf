data "azurerm_virtual_network" "virtual_network" {
  name                = local.virtual_network.name
  resource_group_name = local.virtual_network.resource_group_name
}

data "azurerm_network_security_group" "network_security_group" {
  name                = local.network_security_group.name
  resource_group_name = local.network_security_group.resource_group_name
}

data "azurerm_route_table" "route_table" {
  name                = local.route_table.name
  resource_group_name = local.route_table.resource_group_name
}
