# mock-common

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.53 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.116 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <= 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | <= 2.30.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | d0a0b3a81963169bdc974f79eba31e41e918e63d |
| <a name="module_apim_mock_ec_api"></a> [apim\_mock\_ec\_api](#module\_apim\_mock\_ec\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_mock_ec_forwarder_api"></a> [apim\_mock\_ec\_forwarder\_api](#module\_apim\_mock\_ec\_forwarder\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_mock_ec_nexi_api"></a> [apim\_mock\_ec\_nexi\_api](#module\_apim\_mock\_ec\_nexi\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_mock_ec_nexi_product"></a> [apim\_mock\_ec\_nexi\_product](#module\_apim\_mock\_ec\_nexi\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_ec_product"></a> [apim\_mock\_ec\_product](#module\_apim\_mock\_ec\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_payment_gateway_api"></a> [apim\_mock\_payment\_gateway\_api](#module\_apim\_mock\_payment\_gateway\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_mock_payment_gateway_mng_api"></a> [apim\_mock\_payment\_gateway\_mng\_api](#module\_apim\_mock\_payment\_gateway\_mng\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_mock_payment_gateway_product"></a> [apim\_mock\_payment\_gateway\_product](#module\_apim\_mock\_payment\_gateway\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_pm_nexi_api"></a> [apim\_mock\_pm\_nexi\_api](#module\_apim\_mock\_pm\_nexi\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_mock_pm_nexi_product"></a> [apim\_mock\_pm\_nexi\_product](#module\_apim\_mock\_pm\_nexi\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_psp_nexi_api"></a> [apim\_mock\_psp\_nexi\_api](#module\_apim\_mock\_psp\_nexi\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_mock_psp_nexi_product"></a> [apim\_mock\_psp\_nexi\_product](#module\_apim\_mock\_psp\_nexi\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_psp_service_api"></a> [apim\_mock\_psp\_service\_api](#module\_apim\_mock\_psp\_service\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_mock_psp_service_api_secondary"></a> [apim\_mock\_psp\_service\_api\_secondary](#module\_apim\_mock\_psp\_service\_api\_secondary) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_mock_psp_service_product"></a> [apim\_mock\_psp\_service\_product](#module\_apim\_mock\_psp\_service\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_psp_service_product_secondary"></a> [apim\_mock\_psp\_service\_product\_secondary](#module\_apim\_mock\_psp\_service\_product\_secondary) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_receipt_pdf"></a> [apim\_mock\_receipt\_pdf](#module\_apim\_mock\_receipt\_pdf) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mocker_config_product"></a> [apim\_mocker\_config\_product](#module\_apim\_mocker\_config\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mocker_core_api_v1"></a> [apim\_mocker\_core\_api\_v1](#module\_apim\_mocker\_core\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_mocker_core_product"></a> [apim\_mocker\_core\_product](#module\_apim\_mocker\_core\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_receipt_pdf_api"></a> [apim\_receipt\_pdf\_api](#module\_apim\_receipt\_pdf\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_secondary_mock_ec_api"></a> [apim\_secondary\_mock\_ec\_api](#module\_apim\_secondary\_mock\_ec\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_secondary_mock_ec_product"></a> [apim\_secondary\_mock\_ec\_product](#module\_apim\_secondary\_mock\_ec\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_gh_runner_job"></a> [gh\_runner\_job](#module\_gh\_runner\_job) | ./.terraform/modules/__v3__/gh_runner_container_app_job_domain_setup | n/a |
| <a name="module_letsencrypt_mock"></a> [letsencrypt\_mock](#module\_letsencrypt\_mock) | ./.terraform/modules/__v3__/letsencrypt_credential | n/a |
| <a name="module_pod_identity"></a> [pod\_identity](#module\_pod\_identity) | ./.terraform/modules/__v3__/kubernetes_pod_identity | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | ./.terraform/modules/__v3__/tls_checker | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v3__/kubernetes_workload_identity_configuration | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_operation_policy.apim_mock_ec_api_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_version_set.mock_ec_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.mock_ec_nexi_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.mock_pm_nexi_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.mock_psp_nexi_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.mock_psp_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.mock_psp_service_api_secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.mock_receipt_pdf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.mocker_core_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.secondary_mock_ec_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.secondary_mock_ec_forwarder_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_group.api_mocker_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_product_group.access_control_developers_for_mocker_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_group) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [helm_release.cert_mounter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.namespace_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_api_management_group.group_developers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_group) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_cidr_subnet_mock_ec"></a> [cidr\_subnet\_mock\_ec](#input\_cidr\_subnet\_mock\_ec) | Address prefixes subnet mock ec | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_mock_payment_gateway"></a> [cidr\_subnet\_mock\_payment\_gateway](#input\_cidr\_subnet\_mock\_payment\_gateway) | Address prefixes subnet mock payment\_gateway | `list(string)` | `null` | no |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | Network | <pre>object({<br/>    id     = string<br/>    enable = bool<br/>  })</pre> | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns internal subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_lb_aks"></a> [lb\_aks](#input\_lb\_aks) | IP load balancer AKS Nexi/SIA | `string` | `"0.0.0.0"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_mock_ec_always_on"></a> [mock\_ec\_always\_on](#input\_mock\_ec\_always\_on) | Mock EC always on property | `bool` | `false` | no |
| <a name="input_mock_ec_enabled"></a> [mock\_ec\_enabled](#input\_mock\_ec\_enabled) | Mock EC enabled | `bool` | `false` | no |
| <a name="input_mock_ec_secondary_enabled"></a> [mock\_ec\_secondary\_enabled](#input\_mock\_ec\_secondary\_enabled) | Mock Secondary EC enabled | `bool` | `false` | no |
| <a name="input_mock_ec_size"></a> [mock\_ec\_size](#input\_mock\_ec\_size) | Mock EC Plan size | `string` | `"S1"` | no |
| <a name="input_mock_ec_tier"></a> [mock\_ec\_tier](#input\_mock\_ec\_tier) | Mock EC Plan tier | `string` | `"Standard"` | no |
| <a name="input_mock_enabled"></a> [mock\_enabled](#input\_mock\_enabled) | mock enabled on this environment | `bool` | `false` | no |
| <a name="input_mock_payment_gateway_always_on"></a> [mock\_payment\_gateway\_always\_on](#input\_mock\_payment\_gateway\_always\_on) | Mock payment gateway always on property | `bool` | `false` | no |
| <a name="input_mock_payment_gateway_enabled"></a> [mock\_payment\_gateway\_enabled](#input\_mock\_payment\_gateway\_enabled) | Mock payment gateway enabled | `bool` | `false` | no |
| <a name="input_mock_payment_gateway_size"></a> [mock\_payment\_gateway\_size](#input\_mock\_payment\_gateway\_size) | Mock payment gateway Plan size | `string` | `"S1"` | no |
| <a name="input_mock_payment_gateway_tier"></a> [mock\_payment\_gateway\_tier](#input\_mock\_payment\_gateway\_tier) | Mock payment gateway Plan tier | `string` | `"Standard"` | no |
| <a name="input_mock_psp_secondary_service_enabled"></a> [mock\_psp\_secondary\_service\_enabled](#input\_mock\_psp\_secondary\_service\_enabled) | Mock Secondary PSP service Nexi | `bool` | `false` | no |
| <a name="input_mock_psp_service_enabled"></a> [mock\_psp\_service\_enabled](#input\_mock\_psp\_service\_enabled) | Mock PSP service Nexi | `bool` | `false` | no |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tls_cert_check_helm"></a> [tls\_cert\_check\_helm](#input\_tls\_cert\_check\_helm) | tls cert helm chart configuration | <pre>object({<br/>    chart_version = string,<br/>    image_name    = string,<br/>    image_tag     = string<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
