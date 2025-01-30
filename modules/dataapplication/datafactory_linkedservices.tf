# Key vault linked services
resource "azurerm_data_factory_linked_service_key_vault" "data_factory_linked_service_key_vault" {
  data_factory_id = module.data_factory.data_factory_id
  name            = "KeyVault"

  additional_properties    = {}
  annotations              = []
  description              = "Key Vault for app."
  integration_runtime_name = local.data_factory_default_integration_runtime_name
  key_vault_id             = module.key_vault.key_vault_id
  parameters               = {}
}

# Databricks linked services
resource "azurerm_data_factory_linked_service_azure_databricks" "data_factory_linked_service_azure_databricks" {
  data_factory_id = module.data_factory.data_factory_id
  name            = "Databricks"

  adb_domain                 = var.databricks_workspace_details["engineering"].workspace_url
  additional_properties      = {}
  annotations                = []
  description                = "Databricks workspace connection."
  existing_cluster_id        = "@linkedService().clusterId"
  integration_runtime_name   = local.data_factory_default_integration_runtime_name
  msi_work_space_resource_id = var.databricks_workspace_details["engineering"].id
  parameters = {
    clusterId = ""
  }
}

# Blob storage linked services
resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_external" {
  data_factory_id = module.data_factory.data_factory_id
  name            = "BlobStorageExternal"

  additional_properties    = {}
  annotations              = []
  description              = "Blob storage connection for external storage account."
  integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters               = {}
  storage_kind             = "StorageV2"
  service_endpoint         = "https://${split("/", var.storage_account_ids.external)[7]}.blob.core.windows.net/"
  use_managed_identity     = true
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_raw" {
  data_factory_id = module.data_factory.data_factory_id
  name            = "BlobStorageRaw"

  additional_properties    = {}
  annotations              = []
  description              = "Blob storage connection for raw storage account."
  integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters               = {}
  storage_kind             = "StorageV2"
  service_endpoint         = "https://${split("/", var.storage_account_ids.raw)[7]}.blob.core.windows.net/"
  use_managed_identity     = true
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_enriched" {
  data_factory_id = module.data_factory.data_factory_id
  name            = "BlobStorageEnriched"

  additional_properties    = {}
  annotations              = []
  description              = "Blob storage connection for enriched storage account."
  integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters               = {}
  storage_kind             = "StorageV2"
  service_endpoint         = "https://${split("/", var.storage_account_ids.enriched)[7]}.blob.core.windows.net/"
  use_managed_identity     = true
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_curated" {
  data_factory_id = module.data_factory.data_factory_id
  name            = "BlobStorageCurated"

  additional_properties    = {}
  annotations              = []
  description              = "Blob storage connection for curated storage account."
  integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters               = {}
  storage_kind             = "StorageV2"
  service_endpoint         = "https://${split("/", var.storage_account_ids.curated)[7]}.blob.core.windows.net/"
  use_managed_identity     = true
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_workspace" {
  data_factory_id = module.data_factory.data_factory_id
  name            = "BlobStorageWorkspace"

  additional_properties    = {}
  annotations              = []
  description              = "Blob storage connection for workspace storage account."
  integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters               = {}
  storage_kind             = "StorageV2"
  service_endpoint         = "https://${split("/", var.storage_account_ids.workspace)[7]}.blob.core.windows.net/"
  use_managed_identity     = true
}

# Datalake storage linked services
resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_external" {
  data_factory_id = module.data_factory.data_factory_id
  name            = "DatalakeStorageExternal"

  additional_properties    = {}
  annotations              = []
  description              = "Datalake storage connection for external storage account."
  integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters               = {}
  url                      = "https://${split("/", var.storage_account_ids.external)[7]}.dfs.core.windows.net/"
  use_managed_identity     = true
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_raw" {
  data_factory_id = module.data_factory.data_factory_id
  name            = "DatalakeStorageRaw"

  additional_properties    = {}
  annotations              = []
  description              = "Datalake storage connection for raw storage account."
  integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters               = {}
  url                      = "https://${split("/", var.storage_account_ids.external)[7]}.dfs.core.windows.net/"
  use_managed_identity     = true
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_enriched" {
  data_factory_id = module.data_factory.data_factory_id
  name            = "DatalakeStorageEnriched"

  additional_properties    = {}
  annotations              = []
  description              = "Datalake storage connection for enriched storage account."
  integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters               = {}
  url                      = "https://${split("/", var.storage_account_ids.enriched)[7]}.dfs.core.windows.net/"
  use_managed_identity     = true
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_curated" {
  data_factory_id = module.data_factory.data_factory_id
  name            = "DatalakeStorageCurated"

  additional_properties    = {}
  annotations              = []
  description              = "Datalake storage connection for curated storage account."
  integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters               = {}
  url                      = "https://${split("/", var.storage_account_ids.curated)[7]}.dfs.core.windows.net/"
  use_managed_identity     = true
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_workspace" {
  data_factory_id = module.data_factory.data_factory_id
  name            = "DatalakeStorageWorkspace"

  additional_properties    = {}
  annotations              = []
  description              = "Datalake storage connection for workspace storage account."
  integration_runtime_name = local.data_factory_default_integration_runtime_name
  parameters               = {}
  url                      = "https://${split("/", var.storage_account_ids.workspace)[7]}.dfs.core.windows.net/"
  use_managed_identity     = true
}
