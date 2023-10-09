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

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (>= 1.5.0)

- <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) (>= 2.39.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.56.0)

- <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) (>= 1.16.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (>= 3.5.1)

- <a name="requirement_time"></a> [time](#requirement\_time) (>= 0.9.1)

## Modules

The following Modules are called:

### <a name="module_data_products"></a> [data\_products](#module\_data\_products)

Source: ./modules/dataproduct

Version:

### <a name="module_databricks_automation"></a> [databricks\_automation](#module\_databricks\_automation)

Source: ./modules/databricks

Version:

### <a name="module_databricks_automation_configuration"></a> [databricks\_automation\_configuration](#module\_databricks\_automation\_configuration)

Source: ./modules/databricksconfiguration

Version:

### <a name="module_databricks_experimentation"></a> [databricks\_experimentation](#module\_databricks\_experimentation)

Source: ./modules/databricks

Version:

### <a name="module_databricks_experimentation_configuration"></a> [databricks\_experimentation\_configuration](#module\_databricks\_experimentation\_configuration)

Source: ./modules/databricksconfiguration

Version:

### <a name="module_datalake_curated"></a> [datalake\_curated](#module\_datalake\_curated)

Source: ./modules/datalake

Version:

### <a name="module_datalake_enriched"></a> [datalake\_enriched](#module\_datalake\_enriched)

Source: ./modules/datalake

Version:

### <a name="module_datalake_raw"></a> [datalake\_raw](#module\_datalake\_raw)

Source: ./modules/datalake

Version:

### <a name="module_datalake_workspace"></a> [datalake\_workspace](#module\_datalake\_workspace)

Source: ./modules/datalake

Version:

### <a name="module_shir_001"></a> [shir\_001](#module\_shir\_001)

Source: ./modules/selfhostedintegrationruntime

Version:

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD034 -->
## Required Inputs

The following input variables are required:

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

### <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id)

Description: Specifies the resource ID of the Vnet used for the Data Landing Zone.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username)

Description: Specifies the admin username of the VMs used for the Self-hosted Integration Runtimes.

Type: `string`

Default: `"VmMainUser"`

### <a name="input_data_platform_subscription_ids"></a> [data\_platform\_subscription\_ids](#input\_data\_platform\_subscription\_ids)

Description: Specifies the list of subscription IDs of your data platform.

Type: `list(string)`

Default: `[]`

### <a name="input_data_product_library_path"></a> [data\_product\_library\_path](#input\_data\_product\_library\_path)

Description: If specified, sets the path to a custom library folder for archetype artefacts.

Type: `string`

Default: `""`

### <a name="input_data_product_template_file_variables"></a> [data\_product\_template\_file\_variables](#input\_data\_product\_template\_file\_variables)

Description: If specified, provides the ability to define custom template variables used when reading in data product template files from the library path.

Type: `any`

Default: `{}`

### <a name="input_databricks_admin_groupname"></a> [databricks\_admin\_groupname](#input\_databricks\_admin\_groupname)

Description: Specifies the databricks account admin group name (available in https://accounts.azuredatabricks.net/) that should be granted access to the Databricks workspace artifacts. This feature requires you to grant Databricks account admin access to your Service Principal.

Type: `string`

Default: `""`

### <a name="input_databricks_cluster_policies"></a> [databricks\_cluster\_policies](#input\_databricks\_cluster\_policies)

Description: Specifies the databricks cluster policies that should be added to the workspace.

Type: `any`

Default: `{}`

### <a name="input_enable_databricks_auth_private_endpoint"></a> [enable\_databricks\_auth\_private\_endpoint](#input\_enable\_databricks\_auth\_private\_endpoint)

Description: Specifies whether to deploy the private endpoint used for browser authentication. Create one of these per region for all Azure Databricks workspaces as this will be shared.

Type: `bool`

Default: `false`

### <a name="input_environment"></a> [environment](#input\_environment)

Description: Specifies the environment of the deployment.

Type: `string`

Default: `"dev"`

### <a name="input_private_dns_zone_id_blob"></a> [private\_dns\_zone\_id\_blob](#input\_private\_dns\_zone\_id\_blob)

Description: Specifies the resource ID of the private DNS zone for Azure Storage blob endpoints. Not required if DNS A-records get created via Azue Policy.

Type: `string`

Default: `""`

### <a name="input_private_dns_zone_id_data_factory"></a> [private\_dns\_zone\_id\_data\_factory](#input\_private\_dns\_zone\_id\_data\_factory)

Description: Specifies the resource ID of the private DNS zone for Azure Data Factory. Not required if DNS A-records get created via Azue Policy.

Type: `string`

Default: `""`

### <a name="input_private_dns_zone_id_data_factory_portal"></a> [private\_dns\_zone\_id\_data\_factory\_portal](#input\_private\_dns\_zone\_id\_data\_factory\_portal)

Description: Specifies the resource ID of the private DNS zone for Azure Data Factory Portal. Not required if DNS A-records get created via Azue Policy.

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

### <a name="input_private_dns_zone_id_key_vault"></a> [private\_dns\_zone\_id\_key\_vault](#input\_private\_dns\_zone\_id\_key\_vault)

Description: Specifies the resource ID of the private DNS zone for Azure Key Vault. Not required if DNS A-records get created via Azue Policy.

Type: `string`

Default: `""`

### <a name="input_private_dns_zone_id_queue"></a> [private\_dns\_zone\_id\_queue](#input\_private\_dns\_zone\_id\_queue)

Description: Specifies the resource ID of the private DNS zone for Azure Storage queue endpoints. Not required if DNS A-records get created via Azue Policy.

Type: `string`

Default: `""`

### <a name="input_private_dns_zone_id_table"></a> [private\_dns\_zone\_id\_table](#input\_private\_dns\_zone\_id\_table)

Description: Specifies the resource ID of the private DNS zone for Azure Storage table endpoints. Not required if DNS A-records get created via Azue Policy.

Type: `string`

Default: `""`

### <a name="input_purview_id"></a> [purview\_id](#input\_purview\_id)

Description: Specifies the resource ID of the default Purview Account for the Data Landing Zone.

Type: `string`

Default: `""`

### <a name="input_subnet_cidr_ranges"></a> [subnet\_cidr\_ranges](#input\_subnet\_cidr\_ranges)

Description: Specifies the cidr ranges of the subnets used for the Data Management Zone. If not specified, the module will automatically define the right subnet cidr ranges. For this to work, the provided vnet must have no subnets.

Type:

```hcl
object(
    {
      storage_subnet                = optional(string, "")
      runtimes_subnet               = optional(string, "")
      powerbi_subnet                = optional(string, "")
      shared_app_aut_subnet         = optional(string, "")
      shared_app_exp_subnet         = optional(string, "")
      databricks_private_subnet_001 = optional(string, "")
      databricks_public_subnet_001  = optional(string, "")
      databricks_private_subnet_002 = optional(string, "")
      databricks_public_subnet_002  = optional(string, "")
    }
  )
```

Default: `{}`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Specifies the tags that you want to apply to all resources.

Type: `map(string)`

Default: `{}`

### <a name="input_unity_metastore_id"></a> [unity\_metastore\_id](#input\_unity\_metastore\_id)

Description: Specifies the id of the Databricks Unity metastore.

Type: `string`

Default: `""`

### <a name="input_unity_metastore_name"></a> [unity\_metastore\_name](#input\_unity\_metastore\_name)

Description: Specifies the name of the Databricks Unity metastore.

Type: `string`

Default: `""`

## Outputs

No outputs.

<!-- markdownlint-enable -->
## License

[MIT License](/LICENSE)

## Contributing

This project accepts public contributions. Please use issues, pull requests and the discussins feature in case you have any questions or want to enhance this module.

<!-- END_TF_DOCS -->