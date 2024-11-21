output "subnet_storage_id" {
  description = "Specifies the storage subnet id."
  sensitive = false
  value = "${azapi_update_resource.virtual_network.id}/subnets/${local.subnet_storage.name}"
}

output "subnet_fabric_id" {
  description = "Specifies the fabric subnet id."
  sensitive = false
  value = "${azapi_update_resource.virtual_network.id}/subnets/${local.subnet_fabric.name}"
}

output "subnet_consumption_private_id" {
  description = "Specifies the private consumption subnet id."
  sensitive = false
  value = "${azapi_update_resource.virtual_network.id}/subnets/${local.subnet_consumption_private.name}"
}

output "subnet_consumption_public_id" {
  description = "Specifies the public consumption subnet id."
  sensitive = false
  value = "${azapi_update_resource.virtual_network.id}/subnets/${local.subnet_consumption_public.name}"
}

output "subnets_private_endpoint_application_ids" {
  description = "Specifies the application private endpoint subnet ids."
  sensitive = false
  value = {
    for key, value in var.subnet_cidr_range_applications :
    key => "${azapi_update_resource.virtual_network.id}/subnets/PrivateEndpointSubnet-${key}"
  }
}

output "subnets_databricks_private_application_ids" {
  description = "Specifies the application databricks private subnet ids."
  sensitive = false
  value = {
    for key, value in var.subnet_cidr_range_applications :
    key => value.databricks_private_subnet != "" && value.databricks_public_subnet != "" ? "${azapi_update_resource.virtual_network.id}/subnets/DatabricksPrivateSubnet-${key}" : null
  }
}

output "subnets_databricks_public_application_ids" {
  description = "Specifies the application databricks public subnet ids."
  sensitive = false
  value = {
    for key, value in var.subnet_cidr_range_applications :
    key => value.databricks_private_subnet != "" && value.databricks_public_subnet != "" ? "${azapi_update_resource.virtual_network.id}/subnets/DatabricksPublicSubnet-${key}" : null
  }
}
