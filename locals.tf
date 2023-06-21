locals {
  prefix = "${lower(var.prefix)}-${var.environment}"

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

  subnet_cidr_ranges = {
    storage_subnet                = var.subnet_cidr_ranges.storage_subnet != "" ? var.subnet_cidr_ranges.storage_subnet : tostring(cidrsubnet(data.azurerm_virtual_network.virtual_network.address_space[0], 28 - tonumber(reverse(split("/", data.azurerm_virtual_network.virtual_network.address_space[0]))[0]), 1))
    runtimes_subnet               = var.subnet_cidr_ranges.runtimes_subnet != "" ? var.subnet_cidr_ranges.runtimes_subnet : tostring(cidrsubnet(data.azurerm_virtual_network.virtual_network.address_space[0], 28 - tonumber(reverse(split("/", data.azurerm_virtual_network.virtual_network.address_space[0]))[0]), 2))
    powerbi_subnet                = var.subnet_cidr_ranges.powerbi_subnet != "" ? var.subnet_cidr_ranges.powerbi_subnet : tostring(cidrsubnet(data.azurerm_virtual_network.virtual_network.address_space[0], 28 - tonumber(reverse(split("/", data.azurerm_virtual_network.virtual_network.address_space[0]))[0]), 3))
    shared_app_aut_subnet         = var.subnet_cidr_ranges.shared_app_aut_subnet != "" ? var.subnet_cidr_ranges.shared_app_aut_subnet : tostring(cidrsubnet(data.azurerm_virtual_network.virtual_network.address_space[0], 28 - tonumber(reverse(split("/", data.azurerm_virtual_network.virtual_network.address_space[0]))[0]), 4))
    shared_app_exp_subnet         = var.subnet_cidr_ranges.shared_app_exp_subnet != "" ? var.subnet_cidr_ranges.shared_app_exp_subnet : tostring(cidrsubnet(data.azurerm_virtual_network.virtual_network.address_space[0], 28 - tonumber(reverse(split("/", data.azurerm_virtual_network.virtual_network.address_space[0]))[0]), 5))
    databricks_private_subnet_001 = var.subnet_cidr_ranges.databricks_private_subnet_001 != "" ? var.subnet_cidr_ranges.databricks_private_subnet_001 : tostring(cidrsubnet(data.azurerm_virtual_network.virtual_network.address_space[0], 23 - tonumber(reverse(split("/", data.azurerm_virtual_network.virtual_network.address_space[0]))[0]), 1))
    databricks_public_subnet_001  = var.subnet_cidr_ranges.databricks_public_subnet_001 != "" ? var.subnet_cidr_ranges.databricks_public_subnet_001 : tostring(cidrsubnet(data.azurerm_virtual_network.virtual_network.address_space[0], 23 - tonumber(reverse(split("/", data.azurerm_virtual_network.virtual_network.address_space[0]))[0]), 2))
    databricks_private_subnet_002 = var.subnet_cidr_ranges.databricks_private_subnet_002 != "" ? var.subnet_cidr_ranges.databricks_private_subnet_002 : tostring(cidrsubnet(data.azurerm_virtual_network.virtual_network.address_space[0], 23 - tonumber(reverse(split("/", data.azurerm_virtual_network.virtual_network.address_space[0]))[0]), 3))
    databricks_public_subnet_002  = var.subnet_cidr_ranges.databricks_public_subnet_002 != "" ? var.subnet_cidr_ranges.databricks_public_subnet_002 : tostring(cidrsubnet(data.azurerm_virtual_network.virtual_network.address_space[0], 23 - tonumber(reverse(split("/", data.azurerm_virtual_network.virtual_network.address_space[0]))[0]), 4))
  }
}

locals {
  data_product_library_path = var.data_product_library_path

  # Load file paths
  data_product_filepaths_json = local.data_product_library_path == "" ? [] : tolist(fileset(local.data_product_library_path, "**/*.{json,json.tftpl}"))
  data_product_filepaths_yaml = local.data_product_library_path == "" ? [] : tolist(fileset(local.data_product_library_path, "**/*.{yml,yml.tftpl,yaml,yaml.tftpl}"))

  # Load file content
  data_product_definitions_json = {
    for filepath in local.data_product_filepaths_json :
    filepath => jsondecode(templatefile("${local.data_product_library_path}/${filepath}", var.data_product_template_file_variables))
  }
  data_product_definitions_yaml = {
    for filepath in local.data_product_filepaths_yaml :
    filepath => yamldecode(templatefile("${local.data_product_library_path}/${filepath}", var.data_product_template_file_variables))
  }

  # Merge data
  data_product_definitions = merge(
    local.data_product_definitions_json,
    local.data_product_definitions_yaml
  )
}
