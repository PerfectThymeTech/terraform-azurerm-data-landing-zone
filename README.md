<!-- BEGIN_TF_DOCS -->
# CloudScaleAnalytics v2 - Data Landing Zone

This project revisits the Cloud Scale Analytics data platform reference architecture for Microsoft Azure. While the core principles of the architecture design have not changed, the next generation of the design will and enhance and introduce many new capabilities that will simplify the overall management, onboarding and significantly reduce the time to market.

Over the last couple of years, numerous data platforms have been built on the basis of Cloud Scale Analytics which resulted in a ton of learnings and insights. In addition to that, new services and features have been introduced, reached a GA status and common requirements have drifted. All these data points have been used to build this next iteration of the reference architecture for scalable data platforms on Azure.

The Cloud Scale Analytics reference architecture consists of the following core building blocks:

1. The *Data Management Zone* is the core data governance entity of on organization. In this Azure subscription, an organization places all data management solution including their data catalog, the data lineage solution, the master data management tool and other data governance capabilities. Placing these tools inside a single subscription ensures a resusable data management framework that can be applied to all *Data Landing Zones* and other data sources across an organization.

2. The *Data Landing Zone* is used for data retention and processing. A *Data Landing Zone* maps to a single Azure Subscription, but organizations are encouraged to have multiple of these for scaling purposes. Within a *Data Landing Zone* an orgnaization may implement one or multiple data applications.

3. A *Data Application* environment is a bounded context within a *Data Landing Zone*. A *Data Application* is concerned with consuming, processing and producing data as an output. These outputs should no longer be treated as byproducts but rather be managed as a full product that has a defined service-level-agreement.

![Cloud-scale Analytics v2](https://raw.githubusercontent.com/PerfectThymeTech/terraform-azurerm-data-landing-zone/main/docs/media/CloudScaleAnalyticsv2.gif)

## Architecture

The following architecture will be deployed by this module, whereby the module expects that the Vnet, Route Table and NSG already exists within the Azure Landing Zone and respective resource IDs are provided as input:

![Data Landing Zone Architecture](https://raw.githubusercontent.com/PerfectThymeTech/terraform-azurerm-data-landing-zone/main/docs/media/DataLandingZoneArchitecture.png)

## Prerequisites

- An Azure subscription. If you don't have an Azure subscription, [create your Azure free account today](https://azure.microsoft.com/free/).
- (1) [Contributor](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#contributor) and [User Access Administrator](https://learn.microsoft.com/azure/role-based-access-control/built-in-roles#user-access-administrator) or (2) [Owner](https://learn.microsoft.com/azure/role-based-access-control/built-in-roles#owner) access to the subscription to be able to create resources and role assignments.
- `CREATE_CATALOG` and `CREATE_EXTERNAL_LOCATION` [privileges on the Databricks Unity Catalog](https://learn.microsoft.com/en-us/azure/databricks/data-governance/unity-catalog/manage-privileges/) if you want to configure the Databricks Unity catalog and connect it to your Data Landing Zone.
- A [GitHub self-hosted runner](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners) or an [Azure DevOps self-hosted agent](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/linux-agent?view=azure-devops) to be able to access the data-plane of services.

## Usage

We recommend starting with the following configuration in your root module to learn what resources are created by the module and how it works.

```hcl
# Configure Terraform to set the required AzureRM provider version and features{} block.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.57.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "1.6.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.17.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.39.0"
    }
  }
}

data "azurerm_client_config" "current" {}

provider "azurerm" {
  features {}
}

provider "azapi" {}

provider "azuread" {
  tenant_id = data.azurerm_client_config.current.tenant_id
}

provider "databricks" {
  alias      = "account"
  host       = "https://accounts.azuredatabricks.net"
  account_id = "<my-account-id>"
}

# Declare locals for the module
locals {
  resource_providers = [
    "Microsoft.PowerPlatform"
  ]

  location       = "northeurope"
  prefix         = "<my-prefix>"
  vnet_id        = "/subscriptions/<my-subscription-id>/resourceGroups/<my-rg-name>/providers/Microsoft.Network/virtualNetworks/<my-vnet-name>"
  nsg_id         = "/subscriptions/<my-subscription-id>/resourceGroups/<my-rg-name>/providers/Microsoft.Network/networkSecurityGroups/<my-nsg-name>"
  route_table_id = "/subscriptions/<my-subscription-id>/resourceGroups/<my-rg-name>/providers/Microsoft.Network/routeTables/<my-rt-name>"

  # If DNS A-records are deployed via Policy then you can also set these to an empty string (e.g. "") or remove them entirely
  private_dns_zone_id_blob                = "/subscriptions/<my-subscription-id>/resourceGroups/<my-rg-name>/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
  private_dns_zone_id_dfs                 = "/subscriptions/<my-subscription-id>/resourceGroups/<my-rg-name>/providers/Microsoft.Network/privateDnsZones/privatelink.dfs.core.windows.net"
  private_dns_zone_id_queue               = "/subscriptions/<my-subscription-id>/resourceGroups/<my-rg-name>/providers/Microsoft.Network/privateDnsZones/privatelink.queue.core.windows.net"
  private_dns_zone_id_table               = "/subscriptions/<my-subscription-id>/resourceGroups/<my-rg-name>/providers/Microsoft.Network/privateDnsZones/privatelink.table.core.windows.net"
  private_dns_zone_id_key_vault           = "/subscriptions/<my-subscription-id>/resourceGroups/<my-rg-name>/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
  private_dns_zone_id_data_factory        = "/subscriptions/<my-subscription-id>/resourceGroups/<my-rg-name>/providers/Microsoft.Network/privateDnsZones/privatelink.datafactory.azure.net"
  private_dns_zone_id_data_factory_portal = "/subscriptions/<my-subscription-id>/resourceGroups/<my-rg-name>/providers/Microsoft.Network/privateDnsZones/privatelink.adf.azure.com"
  private_dns_zone_id_databricks          = "/subscriptions/<my-subscription-id>/resourceGroups/<my-rg-name>/providers/Microsoft.Network/privateDnsZones/privatelink.azuredatabricks.net"
}

# Declare the Data Landing Zone Terraform module and provide a base configuration.
module "data_landing_zone" {
  source  = "PerfectThymeTech/data-landing-zone/azurerm"
  version = "0.1.0"
  providers = {
    azurerm            = azurerm
    azapi              = azapi
    azuread            = azuread
    databricks.account = databricks.account
  }

  location                                = var.location
  prefix                                  = var.prefix
  vnet_id                                 = local.vnet_id
  nsg_id                                  = local.nsg_id
  route_table_id                          = local.route_table_id
  private_dns_zone_id_blob                = local.private_dns_zone_id_blob
  private_dns_zone_id_dfs                 = local.private_dns_zone_id_dfs
  private_dns_zone_id_queue               = local.private_dns_zone_id_queue
  private_dns_zone_id_table               = local.private_dns_zone_id_table
  private_dns_zone_id_key_vault           = local.private_dns_zone_id_key_vault
  private_dns_zone_id_data_factory        = local.private_dns_zone_id_data_factory
  private_dns_zone_id_data_factory_portal = local.private_dns_zone_id_data_factory_portal
  private_dns_zone_id_databricks          = local.private_dns_zone_id_databricks
}
```

## Documentation
<!-- markdownlint-disable MD033 -->

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>=0.12)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (~> 2.0)

- <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) (~> 3.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

- <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) (~> 1.58)

- <a name="requirement_null"></a> [null](#requirement\_null) (~> 3.2)

- <a name="requirement_time"></a> [time](#requirement\_time) (~> 0.9)

## Modules

The following Modules are called:

### <a name="module_core"></a> [core](#module\_core)

Source: ./modules/core

Version:

### <a name="module_data_application"></a> [data\_application](#module\_data\_application)

Source: ./modules/dataapplication

Version:

### <a name="module_databricks_account_configuration"></a> [databricks\_account\_configuration](#module\_databricks\_account\_configuration)

Source: ./modules/databricksaccountconfiguration

Version:

### <a name="module_databricks_workspace_configuration"></a> [databricks\_workspace\_configuration](#module\_databricks\_workspace\_configuration)

Source: ./modules/databricksworkspaceconfiguration

Version:

### <a name="module_databricksworkspaceapplication"></a> [databricksworkspaceapplication](#module\_databricksworkspaceapplication)

Source: ./modules/databricksworkspaceapplication

Version:

### <a name="module_platform"></a> [platform](#module\_platform)

Source: ./modules/platform

Version:

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD034 -->
## Required Inputs

The following input variables are required:

### <a name="input_databricks_account_id"></a> [databricks\_account\_id](#input\_databricks\_account\_id)

Description: Specifies the databricks account id.

Type: `string`

### <a name="input_location"></a> [location](#input\_location)

Description: Specifies the location for all Azure resources.

Type: `string`

### <a name="input_nsg_id"></a> [nsg\_id](#input\_nsg\_id)

Description: Specifies the resource ID of the default network security group for the Data Landing Zone.

Type: `string`

### <a name="input_prefix"></a> [prefix](#input\_prefix)

Description: Specifies the prefix for all resources created in this deployment.

Type: `string`

### <a name="input_route_table_id"></a> [route\_table\_id](#input\_route\_table\_id)

Description: Specifies the resource ID of the default route table for the Data Landing Zone.

Type: `string`

### <a name="input_subnet_cidr_ranges"></a> [subnet\_cidr\_ranges](#input\_subnet\_cidr\_ranges)

Description: Specifies the cidr ranges of the subnets used for the Data Management Zone. If not specified, the module will automatically define the right subnet cidr ranges. For this to work, the provided vnet must have no subnets.

Type:

```hcl
object(
    {
      storage_subnet                        = string
      fabric_subnet                         = string
      databricks_engineering_private_subnet = string
      databricks_engineering_public_subnet  = string
      databricks_consumption_private_subnet = string
      databricks_consumption_public_subnet  = string
    }
  )
```

### <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id)

Description: Specifies the resource ID of the Vnet used for the Data Landing Zone.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key)

Description: Specifies the customer managed key configurations.

Type:

```hcl
object({
    key_vault_id                     = string,
    key_vault_key_versionless_id     = string,
    user_assigned_identity_id        = string,
    user_assigned_identity_client_id = string,
  })
```

Default: `null`

### <a name="input_data_application_file_variables"></a> [data\_application\_file\_variables](#input\_data\_application\_file\_variables)

Description: If specified, provides the ability to define custom template variables used when reading in data product template files from the library path.

Type: `any`

Default: `{}`

### <a name="input_data_application_library_path"></a> [data\_application\_library\_path](#input\_data\_application\_library\_path)

Description: If specified, sets the path to a custom library folder for apllication artefacts.

Type: `string`

Default: `""`

### <a name="input_data_platform_subscription_ids"></a> [data\_platform\_subscription\_ids](#input\_data\_platform\_subscription\_ids)

Description: Specifies the list of subscription IDs of your data platform.

Type: `set(string)`

Default: `[]`

### <a name="input_databricks_cluster_policy_file_variables"></a> [databricks\_cluster\_policy\_file\_variables](#input\_databricks\_cluster\_policy\_file\_variables)

Description: Specifies custom template variables used when reading in databricks policy template files from the library path.

Type: `any`

Default: `{}`

### <a name="input_databricks_cluster_policy_library_path"></a> [databricks\_cluster\_policy\_library\_path](#input\_databricks\_cluster\_policy\_library\_path)

Description: Specifies the databricks cluster policy library path.

Type: `string`

Default: `""`

### <a name="input_environment"></a> [environment](#input\_environment)

Description: Specifies the environment of the deployment.

Type: `string`

Default: `"dev"`

### <a name="input_private_dns_zone_id_blob"></a> [private\_dns\_zone\_id\_blob](#input\_private\_dns\_zone\_id\_blob)

Description: Specifies the resource ID of the private DNS zone for Azure Storage blob endpoints. Not required if DNS A-records get created via Azue Policy.

Type: `string`

Default: `""`

### <a name="input_private_dns_zone_id_databricks"></a> [private\_dns\_zone\_id\_databricks](#input\_private\_dns\_zone\_id\_databricks)

Description: Specifies the resource ID of the private DNS zone for Azure Databricks UI endpoints. Not required if DNS A-records get created via Azue Policy.

Type: `string`

Default: `""`

### <a name="input_private_dns_zone_id_dfs"></a> [private\_dns\_zone\_id\_dfs](#input\_private\_dns\_zone\_id\_dfs)

Description: Specifies the resource ID of the private DNS zone for Azure Storage dfs endpoints. Not required if DNS A-records get created via Azue Policy.

Type: `string`

Default: `""`

### <a name="input_private_dns_zone_id_vault"></a> [private\_dns\_zone\_id\_vault](#input\_private\_dns\_zone\_id\_vault)

Description: Specifies the resource ID of the private DNS zone for Azure Key Vault. Not required if DNS A-records get created via Azure Policy.

Type: `string`

Default: `""`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Specifies the tags that you want to apply to all resources.

Type: `map(string)`

Default: `{}`

### <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled)

Description: Specifies whether zone-redundancy should be enabled for all resources.

Type: `bool`

Default: `true`

## Outputs

No outputs.

<!-- markdownlint-enable -->
## License

[MIT License](/LICENSE)

## Contributing

This project accepts public contributions. Please use issues, pull requests and the discussins feature in case you have any questions or want to enhance this module.
<!-- END_TF_DOCS -->