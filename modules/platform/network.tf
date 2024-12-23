resource "azapi_update_resource" "virtual_network" {
  type        = "Microsoft.Network/virtualNetworks@2024-03-01"
  resource_id = data.azurerm_virtual_network.virtual_network.id

  body = {
    properties = {
      subnets = flatten([
        [
          local.subnet_storage,
          local.subnet_fabric,
          local.subnet_engineering_private,
          local.subnet_engineering_public,
          local.subnet_consumption_private,
          local.subnet_consumption_public,
        ],
        local.subnets_private_endpoint_applications,
        # local.subnets_databricks_private_applications,
        # local.subnets_databricks_public_applications,
      ])
    }
  }

  response_export_values  = ["properties.subnets"]
  locks                   = []
  ignore_casing           = true
  ignore_missing_property = true
}
