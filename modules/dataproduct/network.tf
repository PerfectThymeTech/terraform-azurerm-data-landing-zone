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

# azapi would cause concurrency issues and hence we have to move to azurerm
# resource "azapi_resource" "subnets" {
#   for_each = {
#     for index, subnet in var.subnets : "${local.names.subnet}${index + 1}" => subnet if var.network_enabled
#   }
#   type      = "Microsoft.Network/virtualNetworks/subnets@2022-07-01"
#   name      = each.key
#   parent_id = data.azurerm_virtual_network.virtual_network.id

#   body = jsonencode({
#     properties = {
#       addressPrefix = each.value.cidr_range
#       delegations   = []
#       ipAllocations = []
#       networkSecurityGroup = {
#         id = data.azurerm_network_security_group.network_security_group.id
#       }
#       privateEndpointNetworkPolicies    = "Enabled"
#       privateLinkServiceNetworkPolicies = "Enabled"
#       routeTable = {
#         id = data.azurerm_route_table.route_table.id
#       }
#       serviceEndpointPolicies = []
#       serviceEndpoints        = []
#     }
#   })

#   depends_on = [
#     var.dependencies_network
#   ]
# }

resource "azurerm_subnet" "subnets" {
  for_each             = local.subnet_map
  name                 = each.key
  virtual_network_name = data.azurerm_virtual_network.virtual_network.name
  resource_group_name  = data.azurerm_virtual_network.virtual_network.resource_group_name

  address_prefixes = [
    each.value.cidr_range
  ]
  private_endpoint_network_policies_enabled     = true
  private_link_service_network_policies_enabled = true
  service_endpoint_policy_ids                   = null
  service_endpoints                             = []

  depends_on = [
    var.dependencies_network
  ]
}

resource "azurerm_subnet_network_security_group_association" "devops_subnet_nsg" {
  for_each                  = azurerm_subnet.subnets
  network_security_group_id = data.azurerm_network_security_group.network_security_group.id
  subnet_id                 = each.value.id
}

resource "azurerm_subnet_route_table_association" "devops_subnet_routetable" {
  for_each       = azurerm_subnet.subnets
  route_table_id = data.azurerm_route_table.route_table.id
  subnet_id      = each.value.id
}
