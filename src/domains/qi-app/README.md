# qi-app

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.33.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <= 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | = 2.11.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | 3fc1dafaf4354e24ca8673005ec0caf4106343a3 |
| <a name="module_apim_pagopa_qi_fdr_kpi_service_api"></a> [apim\_pagopa\_qi\_fdr\_kpi\_service\_api](#module\_apim\_pagopa\_qi\_fdr\_kpi\_service\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_pagopa_qi_smo_jira_tickets_service_api"></a> [apim\_pagopa\_qi\_smo\_jira\_tickets\_service\_api](#module\_apim\_pagopa\_qi\_smo\_jira\_tickets\_service\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_qi_fdr_product"></a> [apim\_qi\_fdr\_product](#module\_apim\_qi\_fdr\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_qi_product"></a> [apim\_qi\_product](#module\_apim\_qi\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_qi_smo_jira_tickets_product"></a> [apim\_qi\_smo\_jira\_tickets\_product](#module\_apim\_qi\_smo\_jira\_tickets\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_pod_identity"></a> [pod\_identity](#module\_pod\_identity) | ./.terraform/modules/__v3__/kubernetes_pod_identity | n/a |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | ./.terraform/modules/__v3__/tls_checker | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_version_set.pagopa_qi_fdr_kpi_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pagopa_qi_smo_jira_tickets_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_subscription.jira_service_now_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.jira_service_now_subkey_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [helm_release.cert_mounter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace) | resource |
| [kubernetes_namespace.namespace_system](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/role_binding) | resource |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/service_account) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/data-sources/secret) | data source |

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
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br/>  "CreatedBy": "Terraform"<br/>}</pre> | no |
| <a name="input_tls_cert_check_helm"></a> [tls\_cert\_check\_helm](#input\_tls\_cert\_check\_helm) | tls cert helm chart configuration | <pre>object({<br/>    chart_version = string,<br/>    image_name    = string,<br/>    image_tag     = string<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
