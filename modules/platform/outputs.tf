output "subnet_id_storage" {
  description = "Specifies the storage subnet id."
  sensitive   = false
  value       = "${azapi_update_resource.virtual_network.id}/subnets/${local.subnet_storage.name}"
}

output "subnet_id_consumption" {
  description = "Specifies the consumption subnet id."
  sensitive   = false
  value       = "${azapi_update_resource.virtual_network.id}/subnets/${local.subnet_consumption.name}"
}

output "subnet_id_fabric" {
  description = "Specifies the fabric subnet id."
  sensitive   = false
  value       = "${azapi_update_resource.virtual_network.id}/subnets/${local.subnet_fabric.name}"
}

output "subnet_id_engineering_private" {
  description = "Specifies the private consumption subnet id."
  sensitive   = false
  value       = "${azapi_update_resource.virtual_network.id}/subnets/${local.subnet_engineering_private.name}"
}

output "subnet_id_engineering_public" {
  description = "Specifies the public consumption subnet id."
  sensitive   = false
  value       = "${azapi_update_resource.virtual_network.id}/subnets/${local.subnet_engineering_public.name}"
}

output "subnet_id_consumption_private" {
  description = "Specifies the private consumption subnet id."
  sensitive   = false
  value       = "${azapi_update_resource.virtual_network.id}/subnets/${local.subnet_consumption_private.name}"
}

output "subnet_id_consumption_public" {
  description = "Specifies the public consumption subnet id."
  sensitive   = false
  value       = "${azapi_update_resource.virtual_network.id}/subnets/${local.subnet_consumption_public.name}"
}

output "subnet_ids_private_endpoint_application" {
  description = "Specifies the application private endpoint subnet ids."
  sensitive   = false
  value = {
    for key, value in var.subnet_cidr_range_applications :
    key => "${azapi_update_resource.virtual_network.id}/subnets/PrivateEndpointSubnet-${key}"
  }
}
