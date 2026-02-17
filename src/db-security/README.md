# DB security


## Setup DB access VDI

After creating the VM, login as admin user and follow these instructions:
- disable "Network Level Authentication":
  ```
  Control panel ->  System and Security -> System / Allow remote access -> uncheck "Allow network connections only from computer running remote desktop with network level authentication"
  ```

- Configure auto-logoff inactive sessions
  ```
  Start -> Group policy editor -> Local Computer Policy 
   =>  Computer Configuration 
     =>  Administrative Templates 
	      =>  Windows Components 
          =>  Remote Desktop Services 
            =>  Remote Desktop Session Host 
              =>  Session Time Limits
  ```
  - Enable and set "Set time limit for active for disconnected sessions" to 1 minute
  - Enable and set "Set time limit for active but idle Remote Desktop Services sessions" to 1 minute

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
| <a name="module___v4__"></a> [\_\_v4\_\_](#module\_\_\_v4\_\_) | git::https://github.com/pagopa/terraform-azurerm-v4 | a8779d9a41e1afb803cacbcfd778acb2e86e9a0a |
| <a name="module_app_service_snet"></a> [app\_service\_snet](#module\_app\_service\_snet) | ./.terraform/modules/__v4__/IDH/subnet | n/a |
| <a name="module_metabase_app_service"></a> [metabase\_app\_service](#module\_metabase\_app\_service) | ./.terraform/modules/__v4__/IDH/app_service_webapp | n/a |
| <a name="module_metabase_postgres_db"></a> [metabase\_postgres\_db](#module\_metabase\_postgres\_db) | ./.terraform/modules/__v4__/IDH/postgres_flexible_server | n/a |
| <a name="module_postgres_flexible_snet"></a> [postgres\_flexible\_snet](#module\_postgres\_flexible\_snet) | ./.terraform/modules/__v4__/IDH/subnet | n/a |
| <a name="module_route_table_app_service_snet"></a> [route\_table\_app\_service\_snet](#module\_route\_table\_app\_service\_snet) | ./.terraform/modules/__v4__/route_table | n/a |
| <a name="module_secret_core"></a> [secret\_core](#module\_secret\_core) | ./.terraform/modules/__v4__/key_vault_secrets_query | n/a |
| <a name="module_secret_core_itn"></a> [secret\_core\_itn](#module\_secret\_core\_itn) | ./.terraform/modules/__v4__/key_vault_secrets_query | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../tag_config | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_dev_test_global_vm_shutdown_schedule.auto_shutdown](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dev_test_global_vm_shutdown_schedule) | resource |
| [azurerm_network_interface.vdi_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_private_dns_zone.private_dns_vdi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.private_dns_vdi_global](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vdi_global_to_core_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vdi_local_to_core_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.host_pool_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.workspace_global_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.workspace_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.metabase_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.vdi_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.assign_power_on_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.vdi_login](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.vdi_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_virtual_desktop_application_group.application_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_application_group) | resource |
| [azurerm_virtual_desktop_host_pool.vdi_host_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool) | resource |
| [azurerm_virtual_desktop_host_pool_registration_info.host_pool_registration_info](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool_registration_info) | resource |
| [azurerm_virtual_desktop_workspace.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_workspace) | resource |
| [azurerm_virtual_desktop_workspace_application_group_association.application_group_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_workspace_application_group_association) | resource |
| [azurerm_virtual_machine_extension.aad_join_extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.host_pool_join](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.db_vdi_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [azuread_group.admin_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_log_analytics_workspace.log_analytics_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_private_dns_zone.azurewebsites](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.rg_vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.private_endpoint_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.tools_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.vpn_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_vdi_settings"></a> [db\_vdi\_settings](#input\_db\_vdi\_settings) | n/a | <pre>object({<br/>    location              = optional(string, "westeurope")<br/>    location_short        = optional(string, "weu")<br/>    size                  = string<br/>    auto_shutdown_enabled = bool<br/>    auto_shutdown_time    = optional(string, "1900")<br/>    session_limit         = optional(number, 1)<br/>    host_pool_type        = optional(string, "Pooled")<br/>  })</pre> | <pre>{<br/>  "auto_shutdown_enabled": true,<br/>  "auto_shutdown_time": "1900",<br/>  "host_pool_type": "Pooled",<br/>  "location": "westeurope",<br/>  "location_short": "weu",<br/>  "session_limit": 1,<br/>  "size": "Standard_B4ms"<br/>}</pre> | no |
| <a name="input_enabled_features"></a> [enabled\_features](#input\_enabled\_features) | (Required) A map of enabled features in the environment | <pre>object({<br/>    db_vdi = optional(bool, false)<br/>  })</pre> | <pre>{<br/>  "db_vdi": false<br/>}</pre> | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_metabase_pgflex_custom_metric_alerts"></a> [metabase\_pgflex\_custom\_metric\_alerts](#input\_metabase\_pgflex\_custom\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br/>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br/>    aggregation = string<br/>    metric_name = string<br/>    # "Insights.Container/pods" "Insights.Container/nodes"<br/>    metric_namespace = string<br/>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br/>    operator  = string<br/>    threshold = number<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br/>    frequency = string<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br/>    window_size = string<br/>    # severity: The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3.<br/>    severity = number<br/>  }))</pre> | <pre>{<br/>  "active_connections": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "active_connections",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "connections_failed": {<br/>    "aggregation": "Total",<br/>    "frequency": "PT5M",<br/>    "metric_name": "connections_failed",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "cpu_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "cpu_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 4500,<br/>    "window_size": "PT30M"<br/>  },<br/>  "memory_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "memory_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "storage_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "storage_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  }<br/>}</pre> | no |
| <a name="input_metabase_pgflex_params"></a> [metabase\_pgflex\_params](#input\_metabase\_pgflex\_params) | n/a | <pre>object({<br/>    idh_tier                               = string<br/>    db_version                             = string<br/>    storage_mb                             = string<br/>    pgres_flex_diagnostic_settings_enabled = bool<br/>    alerts_enabled                         = bool<br/>    private_dns_registration_enabled       = bool<br/>  })</pre> | n/a | yes |
| <a name="input_metabase_plan_idh_tier"></a> [metabase\_plan\_idh\_tier](#input\_metabase\_plan\_idh\_tier) | IDH resource tier for metabase app service | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_route_table_routes"></a> [route\_table\_routes](#input\_route\_table\_routes) | n/a | <pre>list(object({<br/>    name                   = string<br/>    address_prefix         = string<br/>    next_hop_type          = string<br/>    next_hop_in_ip_address = string<br/>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
