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
  subnet_consumption = {
    name = "ConsumptionSubnet"
    properties = {
      addressPrefix         = var.subnet_cidr_range_consumption
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
  subnet_aifoundry = var.aifoundry_enabled ? {
    name = "AiFoundrySubnet"
    properties = {
      addressPrefix         = var.subnet_cidr_range_aifoundry
      defaultOutboundAccess = false
      delegations = [
        {
          name = "AppDelegation"
          properties = {
            serviceName = "Microsoft.App/environments"
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
  } : null
  subnet_engineering_private = {
    name = "EngineeringPrivateSubnet"
    properties = {
      addressPrefix         = var.subnet_cidr_range_engineering_private
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
  subnet_engineering_public = {
    name = "EngineeringPublicSubnet"
    properties = {
      addressPrefix         = var.subnet_cidr_range_engineering_public
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
  subnet_consumption_private = var.databricks_workspace_consumption_enabled ? {
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
  } : null
  subnet_consumption_public = var.databricks_workspace_consumption_enabled ? {
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
  } : null
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
}

locals {
  # Calculate subnet list
  # Databricks Consumption enabled?
  subnets_databricks_consumption = var.databricks_workspace_consumption_enabled ? flatten([
    [
      local.subnet_storage,
      local.subnet_consumption,
      local.subnet_fabric,
      local.subnet_engineering_private,
      local.subnet_engineering_public,
      local.subnet_consumption_private,
      local.subnet_consumption_public,
    ],
    local.subnets_private_endpoint_applications,
    ]) : flatten([
    [
      local.subnet_storage,
      local.subnet_consumption,
      local.subnet_fabric,
      local.subnet_engineering_private,
      local.subnet_engineering_public,
    ],
    local.subnets_private_endpoint_applications,
  ])

  # AI Foundry enabled?
  subnets_aifoundry = var.aifoundry_enabled ? concat(
    local.subnets_databricks_consumption,
    [
      local.subnet_aifoundry
    ]
  ) : local.subnets_databricks_consumption

  # Final subnet list
  subnets = local.subnets_aifoundry
}
