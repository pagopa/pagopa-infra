# synthetic monitoring

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.11.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 4.0.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | af5980583baf38b7d796a7afa3b82ced1fe369d2 |
| <a name="module_monitoring_function"></a> [monitoring\_function](#module\_monitoring\_function) | ./.terraform/modules/__v3__/monitoring_function | n/a |
| <a name="module_secret_core"></a> [secret\_core](#module\_secret\_core) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v8.54.0 |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../tag_config | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.synthetic_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_app_environment.tools_cae](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_app_environment) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.infra_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.storage_account_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_public_ip.appgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip) | data source |
| [azurerm_resource_group.rg_vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.tools_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.private_endpoint_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_check_position_body"></a> [check\_position\_body](#input\_check\_position\_body) | (Required) fiscal code and notice number to be used in synthetic checkposition request body | <pre>object({<br/>    fiscal_code   = string<br/>    notice_number = string<br/>  })</pre> | n/a | yes |
| <a name="input_enabled_resource"></a> [enabled\_resource](#input\_enabled\_resource) | Feature flags | <pre>object({<br/>    container_app_tools_cae = optional(bool, false),<br/>  })</pre> | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_law_daily_quota_gb"></a> [law\_daily\_quota\_gb](#input\_law\_daily\_quota\_gb) | The workspace daily quota for ingestion in GB. | `number` | `-1` | no |
| <a name="input_law_retention_in_days"></a> [law\_retention\_in\_days](#input\_law\_retention\_in\_days) | The workspace data retention in days | `number` | `30` | no |
| <a name="input_law_sku"></a> [law\_sku](#input\_law\_sku) | Sku of the Log Analytics Workspace | `string` | `"PerGB2018"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_nexi_ndp_host"></a> [nexi\_ndp\_host](#input\_nexi\_ndp\_host) | Nodo Pagamenti Nexi ip | `string` | n/a | yes |
| <a name="input_nexi_node_ip"></a> [nexi\_node\_ip](#input\_nexi\_node\_ip) | Nodo Pagamenti Nexi ip | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_self_alert_enabled"></a> [self\_alert\_enabled](#input\_self\_alert\_enabled) | (Optional) enables the alert on the function itself | `bool` | `true` | no |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | (Required) table storage replication type | `string` | n/a | yes |
| <a name="input_synthetic_alerts_enabled"></a> [synthetic\_alerts\_enabled](#input\_synthetic\_alerts\_enabled) | (Optional) Enables alerts generated by the synthetic monitoring probe | `bool` | `false` | no |
| <a name="input_use_private_endpoint"></a> [use\_private\_endpoint](#input\_use\_private\_endpoint) | (Required) if true enables the usage of private endpoint | `bool` | n/a | yes |
| <a name="input_verify_payment_internal_expected_outcome"></a> [verify\_payment\_internal\_expected\_outcome](#input\_verify\_payment\_internal\_expected\_outcome) | (Required) Expected outcome for verify payment notice internal | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
