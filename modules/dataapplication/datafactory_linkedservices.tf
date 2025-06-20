# Key vault linked services
resource "azurerm_data_factory_linked_service_key_vault" "data_factory_linked_service_key_vault" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "KeyVault"

  additional_properties = {}
  annotations           = []
  description           = "Key Vault for app."
  integration_runtime_name = one(azurerm_data_factory_integration_runtime_azure.data_factory_integration_runtime_azure[*].id)
  key_vault_id = module.key_vault.key_vault_id
  parameters   = {}

  lifecycle {
    ignore_changes = [ integration_runtime_name ]
  }
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

  lifecycle {
    ignore_changes = [ integration_runtime_name ]
  }
}

# Blob storage linked services
resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_provider" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "BlobStorageProvider"

  additional_properties = {}
  annotations           = []
  description           = "Blob storage connection for provider storage account."
  integration_runtime_name = one(azurerm_data_factory_integration_runtime_azure.data_factory_integration_runtime_azure[*].id)
  parameters           = {}
  storage_kind         = "StorageV2"
  service_endpoint     = "https://${split("/", var.storage_account_ids.provider)[8]}.blob.core.windows.net/"
  use_managed_identity = true

  lifecycle {
    ignore_changes = [ integration_runtime_name ]
  }
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_raw" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "BlobStorageRaw"

  additional_properties = {}
  annotations           = []
  description           = "Blob storage connection for raw storage account."
  integration_runtime_name = one(azurerm_data_factory_integration_runtime_azure.data_factory_integration_runtime_azure[*].id)
  parameters           = {}
  storage_kind         = "StorageV2"
  service_endpoint     = "https://${split("/", var.storage_account_ids.raw)[8]}.blob.core.windows.net/"
  use_managed_identity = true

  lifecycle {
    ignore_changes = [ integration_runtime_name ]
  }
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_enriched" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "BlobStorageEnriched"

  additional_properties = {}
  annotations           = []
  description           = "Blob storage connection for enriched storage account."
  integration_runtime_name = one(azurerm_data_factory_integration_runtime_azure.data_factory_integration_runtime_azure[*].id)
  parameters           = {}
  storage_kind         = "StorageV2"
  service_endpoint     = "https://${split("/", var.storage_account_ids.enriched)[8]}.blob.core.windows.net/"
  use_managed_identity = true

  lifecycle {
    ignore_changes = [ integration_runtime_name ]
  }
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_curated" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "BlobStorageCurated"

  additional_properties = {}
  annotations           = []
  description           = "Blob storage connection for curated storage account."
  integration_runtime_name = one(azurerm_data_factory_integration_runtime_azure.data_factory_integration_runtime_azure[*].id)
  parameters           = {}
  storage_kind         = "StorageV2"
  service_endpoint     = "https://${split("/", var.storage_account_ids.curated)[8]}.blob.core.windows.net/"
  use_managed_identity = true

  lifecycle {
    ignore_changes = [ integration_runtime_name ]
  }
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "data_factory_linked_service_azure_blob_storage_workspace" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "BlobStorageWorkspace"

  additional_properties = {}
  annotations           = []
  description           = "Blob storage connection for workspace storage account."
  integration_runtime_name = one(azurerm_data_factory_integration_runtime_azure.data_factory_integration_runtime_azure[*].id)
  parameters           = {}
  storage_kind         = "StorageV2"
  service_endpoint     = "https://${split("/", var.storage_account_ids.workspace)[8]}.blob.core.windows.net/"
  use_managed_identity = true

  lifecycle {
    ignore_changes = [ integration_runtime_name ]
  }
}

# Datalake storage linked services
resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_provider" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "DatalakeStorageProvider"

  additional_properties = {}
  annotations           = []
  description           = "Datalake storage connection for provider storage account."
  integration_runtime_name = one(azurerm_data_factory_integration_runtime_azure.data_factory_integration_runtime_azure[*].id)
  parameters           = {}
  url                  = "https://${split("/", var.storage_account_ids.provider)[8]}.dfs.core.windows.net/"
  use_managed_identity = true

  lifecycle {
    ignore_changes = [ integration_runtime_name ]
  }
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_raw" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "DatalakeStorageRaw"

  additional_properties = {}
  annotations           = []
  description           = "Datalake storage connection for raw storage account."
  integration_runtime_name = one(azurerm_data_factory_integration_runtime_azure.data_factory_integration_runtime_azure[*].id)
  parameters           = {}
  url                  = "https://${split("/", var.storage_account_ids.provider)[8]}.dfs.core.windows.net/"
  use_managed_identity = true

  lifecycle {
    ignore_changes = [ integration_runtime_name ]
  }
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_enriched" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "DatalakeStorageEnriched"

  additional_properties = {}
  annotations           = []
  description           = "Datalake storage connection for enriched storage account."
  integration_runtime_name = one(azurerm_data_factory_integration_runtime_azure.data_factory_integration_runtime_azure[*].id)
  parameters           = {}
  url                  = "https://${split("/", var.storage_account_ids.enriched)[8]}.dfs.core.windows.net/"
  use_managed_identity = true

  lifecycle {
    ignore_changes = [ integration_runtime_name ]
  }
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_curated" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "DatalakeStorageCurated"

  additional_properties = {}
  annotations           = []
  description           = "Datalake storage connection for curated storage account."
  integration_runtime_name = one(azurerm_data_factory_integration_runtime_azure.data_factory_integration_runtime_azure[*].id)
  parameters           = {}
  url                  = "https://${split("/", var.storage_account_ids.curated)[8]}.dfs.core.windows.net/"
  use_managed_identity = true

  lifecycle {
    ignore_changes = [ integration_runtime_name ]
  }
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "data_factory_linked_service_data_lake_storage_gen2_workspace" {
  count = var.data_factory_details.enabled ? 1 : 0

  data_factory_id = one(module.data_factory[*].data_factory_id)
  name            = "DatalakeStorageWorkspace"

  additional_properties = {}
  annotations           = []
  description           = "Datalake storage connection for workspace storage account."
  integration_runtime_name = one(azurerm_data_factory_integration_runtime_azure.data_factory_integration_runtime_azure[*].id)
  parameters           = {}
  url                  = "https://${split("/", var.storage_account_ids.workspace)[8]}.dfs.core.windows.net/"
  use_managed_identity = true

  lifecycle {
    ignore_changes = [ integration_runtime_name ]
  }
}
