# apiconfig-app

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.53 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.116 |
| <a name="requirement_github"></a> [github](#requirement\_github) | <= 5.12.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <= 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.36.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | f97230b8a5838fe3c616b5aa01bef8caeff8bc6b |
| <a name="module_api_config_fe_cdn"></a> [api\_config\_fe\_cdn](#module\_api\_config\_fe\_cdn) | ./.terraform/modules/__v3__/cdn | n/a |
| <a name="module_api_config_snet"></a> [api\_config\_snet](#module\_api\_config\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_apim_api_apiconfig_cache_node_api_v1_o"></a> [apim\_api\_apiconfig\_cache\_node\_api\_v1\_o](#module\_apim\_api\_apiconfig\_cache\_node\_api\_v1\_o) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_apiconfig_cache_node_api_v1_p"></a> [apim\_api\_apiconfig\_cache\_node\_api\_v1\_p](#module\_apim\_api\_apiconfig\_cache\_node\_api\_v1\_p) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_apiconfig_cache_node_nexi_api_dev_v1"></a> [apim\_api\_apiconfig\_cache\_node\_nexi\_api\_dev\_v1](#module\_apim\_api\_apiconfig\_cache\_node\_nexi\_api\_dev\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_apiconfig_cache_replica_node_api_v1_o"></a> [apim\_api\_apiconfig\_cache\_replica\_node\_api\_v1\_o](#module\_apim\_api\_apiconfig\_cache\_replica\_node\_api\_v1\_o) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_apiconfig_cache_replica_node_api_v1_p"></a> [apim\_api\_apiconfig\_cache\_replica\_node\_api\_v1\_p](#module\_apim\_api\_apiconfig\_cache\_replica\_node\_api\_v1\_p) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_config_api"></a> [apim\_api\_config\_api](#module\_apim\_api\_config\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_config_auth_api"></a> [apim\_api\_config\_auth\_api](#module\_apim\_api\_config\_auth\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_config_auth_product"></a> [apim\_api\_config\_auth\_product](#module\_apim\_api\_config\_auth\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_api_config_product"></a> [apim\_api\_config\_product](#module\_apim\_api\_config\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_apiconfig_cache_export_product"></a> [apim\_apiconfig\_cache\_export\_product](#module\_apim\_apiconfig\_cache\_export\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_apiconfig_cache_product"></a> [apim\_apiconfig\_cache\_product](#module\_apim\_apiconfig\_cache\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_apiconfig_selfcare_integration_product"></a> [apim\_apiconfig\_selfcare\_integration\_product](#module\_apim\_apiconfig\_selfcare\_integration\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_cert_mounter"></a> [cert\_mounter](#module\_cert\_mounter) | ./.terraform/modules/__v3__/cert_mounter | n/a |
| <a name="module_gh_runner_job"></a> [gh\_runner\_job](#module\_gh\_runner\_job) | ./.terraform/modules/__v3__/gh_runner_container_app_job_domain_setup | n/a |
| <a name="module_pod_identity"></a> [pod\_identity](#module\_pod\_identity) | ./.terraform/modules/__v3__/kubernetes_pod_identity | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | ./.terraform/modules/__v3__/tls_checker | n/a |
| <a name="module_workload_identity_configuration"></a> [workload\_identity\_configuration](#module\_workload\_identity\_configuration) | ./.terraform/modules/__v3__/kubernetes_workload_identity_configuration | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_version_set.api_apiconfig_cache_node_api_o](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_apiconfig_cache_node_api_p](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_apiconfig_cache_node_nexi_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_apiconfig_cache_replica_node_api_o](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_apiconfig_cache_replica_node_api_p](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_config_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_config_auth_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_authorization_server.apiconfig-oauth2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_authorization_server) | resource |
| [azurerm_api_management_product_group.access_control_developers_for_cache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_group) | resource |
| [azurerm_api_management_product_group.access_control_developers_for_cache_export](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_group) | resource |
| [azurerm_api_management_product_group.access_control_developers_for_selfcare_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_group) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.db_nodo_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.db_nodo_usr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.storage_account_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.apiconfig_cache_generation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.apiconfig_cache_jdbc_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.apiconfig_cache_out_of_memory](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.apiconfig_cache_write_on_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.apiconfig_db_healthcheck](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.apiconfig_jdbc_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_private_dns_cname_record.config_platform_dns_private_cname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_resource_group.api_config_fe_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.api_config_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.status_app](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.namespace_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_pod_disruption_budget_v1.api_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_disruption_budget_v1) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [azuread_application.apiconfig-be](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
| [azuread_application.apiconfig-fe](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_api_management_group.group_developers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_group) | data source |
| [azurerm_api_management_group.group_guests](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_group) | data source |
| [azurerm_api_management_product.apim_aca_integration_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_api_management_product.technical_support_api_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_key_vault.core_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.apiconfig_afm_marketplace_subscription_key_data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.apiconfig_afm_utils_subscription_key_data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.apiconfig_ica_sa_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.opsgenie_webhook_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_a_record) | data source |
| [azurerm_private_dns_zone.db_nodo_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_config_always_on"></a> [api\_config\_always\_on](#input\_api\_config\_always\_on) | Api Config always on property | `bool` | `true` | no |
| <a name="input_api_config_fe_enabled"></a> [api\_config\_fe\_enabled](#input\_api\_config\_fe\_enabled) | Api Config FE enabled | `bool` | `true` | no |
| <a name="input_apiconfig_logging_level"></a> [apiconfig\_logging\_level](#input\_apiconfig\_logging\_level) | Logging level of Api Config | `string` | `"INFO"` | no |
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_cdn_storage_account_replication_type"></a> [cdn\_storage\_account\_replication\_type](#input\_cdn\_storage\_account\_replication\_type) | (Optional) Cdn storage account replication type | `string` | `"GRS"` | no |
| <a name="input_cidr_subnet_api_config"></a> [cidr\_subnet\_api\_config](#input\_cidr\_subnet\_api\_config) | Address prefixes subnet api config | `list(string)` | `null` | no |
| <a name="input_cname_record_name"></a> [cname\_record\_name](#input\_cname\_record\_name) | n/a | `string` | `"config"` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Port number of the DB | `number` | `1521` | no |
| <a name="input_db_service_name"></a> [db\_service\_name](#input\_db\_service\_name) | Service Name of DB | `string` | `null` | no |
| <a name="input_dns_default_ttl_sec"></a> [dns\_default\_ttl\_sec](#input\_dns\_default\_ttl\_sec) | value | `number` | `3600` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_gh_runner_job_location"></a> [gh\_runner\_job\_location](#input\_gh\_runner\_job\_location) | (Optional) The GH runner container app job location. Consistent with the container app environment location | `string` | `"westeurope"` | no |
| <a name="input_github"></a> [github](#input\_github) | n/a | <pre>object({<br/>    org = string<br/>  })</pre> | <pre>{<br/>  "org": "pagopa"<br/>}</pre> | no |
| <a name="input_ica_cron_job_enable"></a> [ica\_cron\_job\_enable](#input\_ica\_cron\_job\_enable) | ICA cron job enable | `bool` | `false` | no |
| <a name="input_ica_cron_schedule"></a> [ica\_cron\_schedule](#input\_ica\_cron\_schedule) | ICA cron scheduling (NCRON example '*/35 * * * * *') | `string` | `"0 0 0 * * *"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_pod_disruption_budgets"></a> [pod\_disruption\_budgets](#input\_pod\_disruption\_budgets) | Pod disruption budget for domain namespace | <pre>map(object({<br/>    name         = optional(string, null)<br/>    minAvailable = optional(number, null)<br/>    matchLabels  = optional(map(any), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_private_dns_zone_db_nodo_pagamenti"></a> [private\_dns\_zone\_db\_nodo\_pagamenti](#input\_private\_dns\_zone\_db\_nodo\_pagamenti) | n/a | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | n/a | `string` | `"S1"` | no |
| <a name="input_tls_cert_check_helm"></a> [tls\_cert\_check\_helm](#input\_tls\_cert\_check\_helm) | tls cert helm chart configuration | <pre>object({<br/>    chart_version = string,<br/>    image_name    = string,<br/>    image_tag     = string<br/>  })</pre> | n/a | yes |
| <a name="input_xsd_cdi"></a> [xsd\_cdi](#input\_xsd\_cdi) | XML Schema of Catalogo Dati Informativi | `string` | `"https://raw.githubusercontent.com/pagopa/pagopa-api/SANP3.2.0/xsd/CatalogoDatiInformativiPSP.xsd"` | no |
| <a name="input_xsd_counterpart"></a> [xsd\_counterpart](#input\_xsd\_counterpart) | XML Schema of Tabelle delle Controparti | `string` | `"https://raw.githubusercontent.com/pagopa/pagopa-api/SANP3.2.0/xsd/TabellaDelleControparti_1_0_8.xsd"` | no |
| <a name="input_xsd_ica"></a> [xsd\_ica](#input\_xsd\_ica) | XML Schema of Informatica Conto Accredito | `string` | `"https://raw.githubusercontent.com/pagopa/pagopa-api/SANP3.2.0/xsd/InformativaContoAccredito_1_2_1.xsd"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pa"></a> [pa](#output\_pa) | n/a |
<!-- END_TF_DOCS -->
