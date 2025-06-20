resource "azurerm_data_factory_integration_runtime_azure" "data_factory_integration_runtime_azure" {
  count = var.data_factory_details.enabled ? 1 : 0

  name            = local.data_factory_default_integration_runtime_name
  data_factory_id = one(module.data_factory[*].data_factory_id)
  location        = "AutoResolve"

  cleanup_enabled         = true
  compute_type            = "General"
  core_count              = 8
  description             = "Integration Runtime provided by platform."
  time_to_live_min        = 0
  virtual_network_enabled = true
}
