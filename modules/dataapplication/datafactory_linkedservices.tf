# Key vault linked services
resource "azurerm_data_factory_linked_service_key_vault" "data_factory_linked_service_key_vault" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "KeyVault"

  additional_properties = {}
  annotations           = []
  description           = "Key Vault for app."
  # integration_runtime_name = local.data_factory_default_integration_runtime_name
  key_vault_id = module.key_vault.key_vault_id
  parameters   = {}
}

# Databricks linked services
resource "azurerm_data_factory_linked_service_azure_databricks" "data_factory_linked_service_azure_databricks" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "Databricks"

  adb_domain            = "https://${var.databricks_workspace_details["engineering"].workspace_url}"
  additional_properties = {}
  annotations           = []
  description           = "Databricks workspace connection."
  existing_cluster_id   = "@linkedService().clusterId"
  # integration_runtime_name   = local.data_factory_default_integration_runtime_name
  msi_work_space_resource_id = var.databricks_workspace_details["engineering"].id
  parameters = {
    clusterId = ""
  }
}

# Blob storage linked services
resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_provider" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "BlobStorageExternal"

  additional_properties = {}
  annotations           = []
  description           = "Blob storage connection for external storage account."
  # integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters           = {}
  storage_kind         = "StorageV2"
  service_endpoint     = "https://${split("/", var.storage_account_ids.external)[8]}.blob.core.windows.net/"
  use_managed_identity = true
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_raw" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "BlobStorageRaw"

  additional_properties = {}
  annotations           = []
  description           = "Blob storage connection for raw storage account."
  # integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters           = {}
  storage_kind         = "StorageV2"
  service_endpoint     = "https://${split("/", var.storage_account_ids.raw)[8]}.blob.core.windows.net/"
  use_managed_identity = true
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_enriched" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "BlobStorageEnriched"

  additional_properties = {}
  annotations           = []
  description           = "Blob storage connection for enriched storage account."
  # integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters           = {}
  storage_kind         = "StorageV2"
  service_endpoint     = "https://${split("/", var.storage_account_ids.enriched)[8]}.blob.core.windows.net/"
  use_managed_identity = true
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_curated" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "BlobStorageCurated"

  additional_properties = {}
  annotations           = []
  description           = "Blob storage connection for curated storage account."
  # integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters           = {}
  storage_kind         = "StorageV2"
  service_endpoint     = "https://${split("/", var.storage_account_ids.curated)[8]}.blob.core.windows.net/"
  use_managed_identity = true
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_workspace" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "BlobStorageWorkspace"

  additional_properties = {}
  annotations           = []
  description           = "Blob storage connection for workspace storage account."
  # integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters           = {}
  storage_kind         = "StorageV2"
  service_endpoint     = "https://${split("/", var.storage_account_ids.workspace)[8]}.blob.core.windows.net/"
  use_managed_identity = true
}

# Datalake storage linked services
resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_provider" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "DatalakeStorageExternal"

  additional_properties = {}
  annotations           = []
  description           = "Datalake storage connection for external storage account."
  # integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters           = {}
  url                  = "https://${split("/", var.storage_account_ids.external)[8]}.dfs.core.windows.net/"
  use_managed_identity = true
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_raw" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "DatalakeStorageRaw"

  additional_properties = {}
  annotations           = []
  description           = "Datalake storage connection for raw storage account."
  # integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters           = {}
  url                  = "https://${split("/", var.storage_account_ids.external)[8]}.dfs.core.windows.net/"
  use_managed_identity = true
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_enriched" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "DatalakeStorageEnriched"

  additional_properties = {}
  annotations           = []
  description           = "Datalake storage connection for enriched storage account."
  # integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters           = {}
  url                  = "https://${split("/", var.storage_account_ids.enriched)[8]}.dfs.core.windows.net/"
  use_managed_identity = true
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_curated" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "DatalakeStorageCurated"

  additional_properties = {}
  annotations           = []
  description           = "Datalake storage connection for curated storage account."
  # integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters           = {}
  url                  = "https://${split("/", var.storage_account_ids.curated)[8]}.dfs.core.windows.net/"
  use_managed_identity = true
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_workspace" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "DatalakeStorageWorkspace"

  additional_properties = {}
  annotations           = []
  description           = "Datalake storage connection for workspace storage account."
  # integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters           = {}
  url                  = "https://${split("/", var.storage_account_ids.workspace)[8]}.dfs.core.windows.net/"
  use_managed_identity = true
}
