# selc-app

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.30.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.39.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | = 2.5.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | = 2.11.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_selfcare_backoffice_external_ec_product"></a> [apim\_selfcare\_backoffice\_external\_ec\_product](#module\_apim\_selfcare\_backoffice\_external\_ec\_product) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v6.7.0 |
| <a name="module_apim_selfcare_backoffice_external_psp_product"></a> [apim\_selfcare\_backoffice\_external\_psp\_product](#module\_apim\_selfcare\_backoffice\_external\_psp\_product) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v6.7.0 |
| <a name="module_apim_selfcare_backoffice_helpdesk_product"></a> [apim\_selfcare\_backoffice\_helpdesk\_product](#module\_apim\_selfcare\_backoffice\_helpdesk\_product) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v6.7.0 |
| <a name="module_apim_selfcare_product"></a> [apim\_selfcare\_product](#module\_apim\_selfcare\_product) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v6.7.0 |
| <a name="module_pod_identity"></a> [pod\_identity](#module\_pod\_identity) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_pod_identity | v6.7.0 |
| <a name="module_selfcare_cdn"></a> [selfcare\_cdn](#module\_selfcare\_cdn) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cdn | v6.7.0 |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | git::https://github.com/pagopa/terraform-azurerm-v3.git//tls_checker | v6.7.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api.pagopa_token_exchange](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_operation.pagopa_token_exchange](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/api_management_api_operation) | resource |
| [azurerm_api_management_api_operation_policy.pagopa_token_exchange_policy](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_certificate.pagopa_token_exchange_cert_jwt](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/api_management_certificate) | resource |
| [azurerm_key_vault_certificate.pagopa_jwt_signing_cert](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/key_vault_certificate) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.jwt_pub_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selfcare_web_storage_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selfcare_web_storage_blob_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selfcare_web_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert-pagopa-backoffice-availability](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_resource_group.selfcare_fe_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/resource_group) | resource |
| [azurerm_storage_container.pagopa_oidc_config](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/resources/storage_container) | resource |
| [helm_release.cert_mounter](https://registry.terraform.io/providers/hashicorp/helm/2.5.1/docs/resources/release) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/2.5.1/docs/resources/release) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace) | resource |
| [kubernetes_namespace.namespace_system](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace) | resource |
| [kubernetes_pod_disruption_budget_v1.selfcare](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/pod_disruption_budget_v1) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/role_binding) | resource |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/service_account) | resource |
| [local_file.oidc_configuration_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.upload_oidc_configuration](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/api_management) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_certificate_data.pagopa_token_exchange_cert_jwt_public](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/key_vault_certificate_data) | data source |
| [azurerm_key_vault_secret.cdn_storage_access_secret](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.39.0/docs/data-sources/virtual_network) | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/data-sources/secret) | data source |
| [tls_public_key.private_key_pem](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/public_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_pod_disruption_budgets"></a> [pod\_disruption\_budgets](#input\_pod\_disruption\_budgets) | Pod disruption budget for domain namespace | <pre>map(object({<br>    name         = optional(string, null)<br>    minAvailable = optional(number, null)<br>    matchLabels  = optional(map(any), {})<br>  }))</pre> | `{}` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_robots_indexed_paths"></a> [robots\_indexed\_paths](#input\_robots\_indexed\_paths) | List of cdn paths to allow robots index | `list(string)` | n/a | yes |
| <a name="input_selfcare_fe_enabled"></a> [selfcare\_fe\_enabled](#input\_selfcare\_fe\_enabled) | selfcare FE enabled | `bool` | `false` | no |
| <a name="input_selfcare_storage_replication_type"></a> [selfcare\_storage\_replication\_type](#input\_selfcare\_storage\_replication\_type) | (Optional) Selfcare cdn storage account replication type | `string` | `"GRS"` | no |
| <a name="input_spa"></a> [spa](#input\_spa) | spa root dirs | `list(string)` | <pre>[<br>  "ui"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_tls_cert_check_helm"></a> [tls\_cert\_check\_helm](#input\_tls\_cert\_check\_helm) | tls cert helm chart configuration | <pre>object({<br>    chart_version = string,<br>    image_name    = string,<br>    image_tag     = string<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
