# synthetic monitoring

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
| <a name="module___v4__"></a> [\_\_v4\_\_](#module\_\_\_v4\_\_) | git::https://github.com/pagopa/terraform-azurerm-v4 | ea24c24f7bcbf2ed5148d5971e625a620ce1368a |
| <a name="module_app_service_snet"></a> [app\_service\_snet](#module\_app\_service\_snet) | ./.terraform/modules/__v4__/IDH/subnet | n/a |
| <a name="module_metabase_app_service"></a> [metabase\_app\_service](#module\_metabase\_app\_service) | ./.terraform/modules/__v4__/IDH/app_service_webapp | n/a |
| <a name="module_metabase_postgres_db"></a> [metabase\_postgres\_db](#module\_metabase\_postgres\_db) | ./.terraform/modules/__v4__/IDH/postgres_flexible_server | n/a |
| <a name="module_postgres_flexible_snet"></a> [postgres\_flexible\_snet](#module\_postgres\_flexible\_snet) | ./.terraform/modules/__v4__/IDH/subnet | n/a |
| <a name="module_secret_core"></a> [secret\_core](#module\_secret\_core) | ./.terraform/modules/__v4__/key_vault_secrets_query | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../tag_config | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.metabase_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_log_analytics_workspace.log_analytics_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_private_dns_zone.azurewebsites](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.rg_vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.private_endpoint_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.vpn_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_metabase_db_idh_tier"></a> [metabase\_db\_idh\_tier](#input\_metabase\_db\_idh\_tier) | (Required) IDH tier for Metabase Postgres Flexible Server | `string` | `"pgflex2"` | no |
| <a name="input_metabase_pgflex_custom_metric_alerts"></a> [metabase\_pgflex\_custom\_metric\_alerts](#input\_metabase\_pgflex\_custom\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br/>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br/>    aggregation = string<br/>    metric_name = string<br/>    # "Insights.Container/pods" "Insights.Container/nodes"<br/>    metric_namespace = string<br/>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br/>    operator  = string<br/>    threshold = number<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br/>    frequency = string<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br/>    window_size = string<br/>    # severity: The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3.<br/>    severity = number<br/>  }))</pre> | <pre>{<br/>  "active_connections": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "active_connections",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "connections_failed": {<br/>    "aggregation": "Total",<br/>    "frequency": "PT5M",<br/>    "metric_name": "connections_failed",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "cpu_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "cpu_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 4500,<br/>    "window_size": "PT30M"<br/>  },<br/>  "memory_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "memory_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "storage_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "storage_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  }<br/>}</pre> | no |
| <a name="input_metabase_pgflex_params"></a> [metabase\_pgflex\_params](#input\_metabase\_pgflex\_params) | n/a | <pre>object({<br/>    idh_tier                               = string<br/>    db_version                             = string<br/>    storage_mb                             = string<br/>    pgres_flex_diagnostic_settings_enabled = bool<br/>    alerts_enabled                         = bool<br/>    private_dns_registration_enabled       = bool<br/>  })</pre> | n/a | yes |
| <a name="input_metabase_plan_idh_tier"></a> [metabase\_plan\_idh\_tier](#input\_metabase\_plan\_idh\_tier) | IDH resource tier for metabase app service | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
