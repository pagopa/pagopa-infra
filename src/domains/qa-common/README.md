## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.16 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.35 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | ~> 1.21 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.81.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.3 |
| <a name="provider_postgresql"></a> [postgresql](#provider\_postgresql) | 1.21.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v4__"></a> [\_\_v4\_\_](#module\_\_\_v4\_\_) | git::https://github.com/pagopa/terraform-azurerm-v4 | a3fa1dc231a570d3e97c811f01cbe5547adafbdc |
| <a name="module_identity_cd_01"></a> [identity\_cd\_01](#module\_identity\_cd\_01) | ./.terraform/modules/__v4__/github_federated_identity | n/a |
| <a name="module_identity_pr_01"></a> [identity\_pr\_01](#module\_identity\_pr\_01) | ./.terraform/modules/__v4__/github_federated_identity | n/a |
| <a name="module_managed_redis"></a> [managed\_redis](#module\_managed\_redis) | ./.terraform/modules/__v4__/IDH/managed_redis | n/a |
| <a name="module_postgres_flexible_server_qa"></a> [postgres\_flexible\_server\_qa](#module\_postgres\_flexible\_server\_qa) | ./.terraform/modules/__v4__/IDH/postgres_flexible_server | n/a |
| <a name="module_qa_sa_dqf"></a> [qa\_sa\_dqf](#module\_qa\_sa\_dqf) | ./.terraform/modules/__v4__/IDH/storage_account | n/a |
| <a name="module_qa_sa_shared"></a> [qa\_sa\_shared](#module\_qa\_sa\_shared) | ./.terraform/modules/__v4__/IDH/storage_account | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v4__/kubernetes_workload_identity_init | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_federated_identity_credential.mcp_cd_env_secure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_federated_identity_credential.mcp_pr_secure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_key_vault_access_policy.gha_cd_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.gha_pr_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.dqf_data_sas_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.qa_centralhub_redis_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.qachub_pwd_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_resource_group.db_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.qa_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.redis_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.identity_cd_storage_blob_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_blob.mcp_catalog_directories](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_container.dqf_data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.mcp_catalog](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [null_resource.github_runner_app_permissions_to_namespace_cd_01](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.github_runner_app_permissions_to_namespace_pr_01](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [postgresql_role.qachub](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/role) | resource |
| [postgresql_schema.qachub_schema](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/schema) | resource |
| [random_password.qachub_pwd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.domain_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.pgres_flex_admin_login](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pgres_flex_admin_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_lb.internal_lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/lb) | data source |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_blob_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_file_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_redis_azure_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_redis_cache_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resources.aks_load_balancers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resources) | data source |
| [azurerm_storage_account_blob_container_sas.dqf_data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account_blob_container_sas) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.identity_cd_01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.hub_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.spoke_compute_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.spoke_data_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.spoke_security_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.spoke_streaming_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.spoke_tools_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_use_opsgenie"></a> [alert\_use\_opsgenie](#input\_alert\_use\_opsgenie) | Use opsgenie for alerts | `bool` | `true` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | general | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | `"itn"` | no |
| <a name="input_pgres_flex_db_names"></a> [pgres\_flex\_db\_names](#input\_pgres\_flex\_db\_names) | List of database names to be created | `list(string)` | `[]` | no |
| <a name="input_pgres_flex_params"></a> [pgres\_flex\_params](#input\_pgres\_flex\_params) | postgres variables | <pre>object({<br/>    idh_resource_tier                      = string<br/>    pgres_flex_diagnostic_settings_enabled = bool<br/>    db_version                             = string<br/>  })</pre> | n/a | yes |
| <a name="input_postgres_custom_metric_alerts"></a> [postgres\_custom\_metric\_alerts](#input\_postgres\_custom\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br/>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br/>    aggregation = string<br/>    metric_name = string<br/>    # "Insights.Container/pods" "Insights.Container/nodes"<br/>    metric_namespace = string<br/>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br/>    operator  = string<br/>    threshold = number<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br/>    frequency = string<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br/>    window_size = string<br/>    # severity: The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3.<br/>    severity = number<br/>  }))</pre> | <pre>{<br/>  "active_connections": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "active_connections",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "connections_failed": {<br/>    "aggregation": "Total",<br/>    "frequency": "PT5M",<br/>    "metric_name": "connections_failed",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "cpu_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "cpu_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 4500,<br/>    "window_size": "PT30M"<br/>  },<br/>  "memory_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "memory_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "storage_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "storage_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  }<br/>}</pre> | no |
| <a name="input_postgres_dns_registration_enabled"></a> [postgres\_dns\_registration\_enabled](#input\_postgres\_dns\_registration\_enabled) | (Optional) If true, adds a CNAME record for the database FQDN in the db private dns | `bool` | `false` | no |

## Outputs

No outputs.
