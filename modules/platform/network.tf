resource "azapi_update_resource" "virtual_network" {
  type        = "Microsoft.Network/virtualNetworks@2024-03-01"
  resource_id = data.azurerm_virtual_network.virtual_network.id

  body = {
    properties = {
      subnets = local.subnets
    }
  }

  response_export_values  = ["properties.subnets"]
  locks                   = []
  ignore_casing           = true
  ignore_missing_property = true
}
