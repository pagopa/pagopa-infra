# packer

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.10.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.36.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azdoa_custom_image"></a> [azdoa\_custom\_image](#module\_azdoa\_custom\_image) | git::https://github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent_custom_image | v8.14.0 |
| <a name="module_dns_forwarder_image"></a> [dns\_forwarder\_image](#module\_dns\_forwarder\_image) | git::https://github.com/pagopa/terraform-azurerm-v3.git//dns_forwarder_vm_image | v8.14.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.36.0/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.36.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/3.36.0/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.36.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/3.36.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azdo_agent_image_version"></a> [azdo\_agent\_image\_version](#input\_azdo\_agent\_image\_version) | Version string to allow to force the creation of the image | `string` | n/a | yes |
| <a name="input_dns_forwarder_backup_image_version"></a> [dns\_forwarder\_backup\_image\_version](#input\_dns\_forwarder\_backup\_image\_version) | Version string to allow to force the creation of the image | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | Location short like eg: neu, weu.. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"dvopla"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
