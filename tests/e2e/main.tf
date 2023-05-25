module "data_landing_zone" {
  source = "../../"
  providers = {
    azurerm            = azurerm
    azapi              = azapi
    azuread            = azuread
    databricks.account = databricks.account
  }
}
