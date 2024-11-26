locals {
  # General locals
  prefix = "${lower(var.prefix)}-${var.environment}"

  # Network locals
  virtual_network = {
    resource_group_name = split("/", var.vnet_id)[4]
    name                = split("/", var.vnet_id)[8]
  }
  network_security_group = {
    resource_group_name = try(split("/", var.nsg_id)[4], "")
    name                = try(split("/", var.nsg_id)[8], "")
  }
  route_table = {
    resource_group_name = try(split("/", var.route_table_id)[4], "")
    name                = try(split("/", var.route_table_id)[8], "")
  }

  # Subnet locals
  subnet_storage = {
    name = "StorageSubnet"
    properties = {
      addressPrefix         = var.subnet_cidr_range_storage
      defaultOutboundAccess = false
      delegations           = []
      ipAllocations         = []
      networkSecurityGroup = {
        id = data.azurerm_network_security_group.network_security_group.id
      }
      privateEndpointNetworkPolicies    = "Enabled"
      privateLinkServiceNetworkPolicies = "Enabled"
      routeTable = {
        id = data.azurerm_route_table.route_table.id
      }
      serviceEndpointPolicies = []
      serviceEndpoints        = []
    }
  }
  subnet_fabric = {
    name = "FabricSubnet"
    properties = {
      addressPrefix         = var.subnet_cidr_range_fabric
      defaultOutboundAccess = false
      delegations = [
        {
          name = "PowerPlatformDelegation"
          properties = {
            serviceName = "Microsoft.PowerPlatform/vnetaccesslinks"
          }
        }
      ]
      ipAllocations = []
      networkSecurityGroup = {
        id = data.azurerm_network_security_group.network_security_group.id
      }
      privateEndpointNetworkPolicies    = "Enabled"
      privateLinkServiceNetworkPolicies = "Enabled"
      routeTable = {
        id = data.azurerm_route_table.route_table.id
      }
      serviceEndpointPolicies = []
      serviceEndpoints        = []
    }
  }
  subnet_consumption_private = {
    name = "ConsumptionPrivateSubnet"
    properties = {
      addressPrefix         = var.subnet_cidr_range_consumption_private
      defaultOutboundAccess = false
      delegations = [
        {
          name = "DatabricksDelegation"
          properties = {
            serviceName = "Microsoft.Databricks/workspaces"
          }
        }
      ]
      ipAllocations = []
      networkSecurityGroup = {
        id = data.azurerm_network_security_group.network_security_group.id
      }
      privateEndpointNetworkPolicies    = "Enabled"
      privateLinkServiceNetworkPolicies = "Enabled"
      routeTable = {
        id = data.azurerm_route_table.route_table.id
      }
      serviceEndpointPolicies = []
      serviceEndpoints        = []
    }
  }
  subnet_consumption_public = {
    name = "ConsumptionPublicSubnet"
    properties = {
      addressPrefix         = var.subnet_cidr_range_consumption_public
      defaultOutboundAccess = false
      delegations = [
        {
          name = "DatabricksDelegation"
          properties = {
            serviceName = "Microsoft.Databricks/workspaces"
          }
        }
      ]
      ipAllocations = []
      networkSecurityGroup = {
        id = data.azurerm_network_security_group.network_security_group.id
      }
      privateEndpointNetworkPolicies    = "Enabled"
      privateLinkServiceNetworkPolicies = "Enabled"
      routeTable = {
        id = data.azurerm_route_table.route_table.id
      }
      serviceEndpointPolicies = []
      serviceEndpoints        = []
    }
  }
  subnets_private_endpoint_applications = [
    for key, value in var.subnet_cidr_range_applications :
    {
      name = "PrivateEndpointSubnet-${key}"
      properties = {
        addressPrefix         = value.private_endpoint_subnet
        defaultOutboundAccess = false
        delegations           = []
        ipAllocations         = []
        networkSecurityGroup = {
          id = data.azurerm_network_security_group.network_security_group.id
        }
        privateEndpointNetworkPolicies    = "Enabled"
        privateLinkServiceNetworkPolicies = "Enabled"
        routeTable = {
          id = data.azurerm_route_table.route_table.id
        }
        serviceEndpointPolicies = []
        serviceEndpoints        = []
      }
    }
  ]
  subnets_databricks_private_applications = [
    for key, value in var.subnet_cidr_range_applications :
    {
      name = "DatabricksPrivateSubnet-${key}"
      properties = {
        addressPrefix         = value.databricks_private_subnet
        defaultOutboundAccess = false
        delegations = [
          {
            name = "DatabricksDelegation"
            properties = {
              serviceName = "Microsoft.Databricks/workspaces"
            }
          }
        ]
        ipAllocations = []
        networkSecurityGroup = {
          id = data.azurerm_network_security_group.network_security_group.id
        }
        privateEndpointNetworkPolicies    = "Enabled"
        privateLinkServiceNetworkPolicies = "Enabled"
        routeTable = {
          id = data.azurerm_route_table.route_table.id
        }
        serviceEndpointPolicies = []
        serviceEndpoints        = []
      }
    } if value.databricks_private_subnet != "" && value.databricks_public_subnet != ""
  ]
  subnets_databricks_public_applications = [
    for key, value in var.subnet_cidr_range_applications :
    {
      name = "DatabricksPublicSubnet-${key}"
      properties = {
        addressPrefix         = value.databricks_public_subnet
        defaultOutboundAccess = false
        delegations = [
          {
            name = "DatabricksDelegation"
            properties = {
              serviceName = "Microsoft.Databricks/workspaces"
            }
          }
        ]
        ipAllocations = []
        networkSecurityGroup = {
          id = data.azurerm_network_security_group.network_security_group.id
        }
        privateEndpointNetworkPolicies    = "Enabled"
        privateLinkServiceNetworkPolicies = "Enabled"
        routeTable = {
          id = data.azurerm_route_table.route_table.id
        }
        serviceEndpointPolicies = []
        serviceEndpoints        = []
      }
    } if value.databricks_private_subnet != "" && value.databricks_public_subnet != ""
  ]
}
