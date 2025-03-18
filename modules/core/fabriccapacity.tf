module "fabric_capacity" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/fabriccapacity?ref=main"
  providers = {
    azurerm = azurerm
    azapi   = azapi
  }

  count = var.fabric_capacity_details.enabled ? 1 : 0

  location                     = var.location
  resource_group_name          = azurerm_resource_group.resource_group_fabric.name
  tags                         = var.tags
  fabric_capacity_name         = replace("${local.prefix}-fbc001", "-", "")
  fabric_capacity_admin_emails = var.service_principal_name_terraform_plan == "" ? var.fabric_capacity_details.admin_emails : setunion(var.fabric_capacity_details.admin_emails, [one(data.azuread_service_principal.service_principal_terraform_plan[*].object_id)])
  fabric_capacity_sku          = var.fabric_capacity_details.sku
}
