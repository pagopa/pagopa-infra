# Network setup

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.16 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v4__"></a> [\_\_v4\_\_](#module\_\_\_v4\_\_) | git::https://github.com/pagopa/terraform-azurerm-v4 | 4a50ddb69cafbc09cf43cd317848a75d61f33050 |
| <a name="module_load_balancer_observ_egress"></a> [load\_balancer\_observ\_egress](#module\_load\_balancer\_observ\_egress) | ./.terraform/modules/__v4__/load_balancer | n/a |
| <a name="module_network_security_group"></a> [network\_security\_group](#module\_network\_security\_group) | ./.terraform/modules/__V4__/network_security_group | n/a |
| <a name="module_network_watcher_storage_account"></a> [network\_watcher\_storage\_account](#module\_network\_watcher\_storage\_account) | ./.terraform/modules/__V4__/IDH/storage_account | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../tag_config | n/a |
| <a name="module_vmss_pls_snet"></a> [vmss\_pls\_snet](#module\_vmss\_pls\_snet) | ./.terraform/modules/__v4__/IDH/subnet | n/a |
| <a name="module_vmss_snet"></a> [vmss\_snet](#module\_vmss\_snet) | ./.terraform/modules/__v4__/IDH/subnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.database_map_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_linux_virtual_machine_scale_set.vmss-egress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.vmss-scale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_private_link_service.vmss_pls](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_link_service) | resource |
| [azurerm_resource_group.nsg_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.vmss_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_machine_scale_set_extension.vmss-extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.kv_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.vmss_admin_login](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.vmss_admin_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled_features"></a> [enabled\_features](#input\_enabled\_features) | (Optional) Enable/Disable features | <pre>object({<br/>    nsg_metabase             = optional(bool, false)<br/>    data_factory_proxy       = optional(bool, false)<br/>    vpn_database_access      = optional(bool, true)<br/>    nsg                      = optional(bool, true)<br/>    db_replica_nsg           = optional(bool, false)<br/>    all_vnet_database_access = optional(bool, false)<br/>  })</pre> | <pre>{<br/>  "all_vnet_database_access": false,<br/>  "data_factory_proxy": false,<br/>  "db_replica_nsg": false,<br/>  "nsg": true,<br/>  "nsg_metabase": false,<br/>  "vpn_database_access": true<br/>}</pre> | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | general | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_nsg_network_watcher_enabled"></a> [nsg\_network\_watcher\_enabled](#input\_nsg\_network\_watcher\_enabled) | (Optional) Enable Network Watcher for all NSG (subnet associated to nsg) | `bool` | `false` | no |
| <a name="input_nsg_regions"></a> [nsg\_regions](#input\_nsg\_regions) | (Optional) Regions where NSG must be created | `list(string)` | <pre>[<br/>  "westeurope"<br/>]</pre> | no |
| <a name="input_vpn_gateway_address_space"></a> [vpn\_gateway\_address\_space](#input\_vpn\_gateway\_address\_space) | n/a | `string` | `"172.16.1.0/24"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
