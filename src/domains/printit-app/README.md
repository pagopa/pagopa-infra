## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.47.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.101.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <= 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | <= 2.29.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.47.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.45.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.27.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_api_pdf_engine_api_v1"></a> [apim\_api\_pdf\_engine\_api\_v1](#module\_apim\_api\_pdf\_engine\_api\_v1) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v8.5.0 |
| <a name="module_apim_api_pdf_engine_node_api_v1"></a> [apim\_api\_pdf\_engine\_node\_api\_v1](#module\_apim\_api\_pdf\_engine\_node\_api\_v1) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v8.5.0 |
| <a name="module_apim_notices_service_product"></a> [apim\_notices\_service\_product](#module\_apim\_notices\_service\_product) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v8.5.0 |
| <a name="module_apim_pdf_engine_product"></a> [apim\_pdf\_engine\_product](#module\_apim\_pdf\_engine\_product) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v8.5.0 |
| <a name="module_kubernetes_service_account"></a> [kubernetes\_service\_account](#module\_kubernetes\_service\_account) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_service_account | v8.5.0 |
| <a name="module_pod_identity"></a> [pod\_identity](#module\_pod\_identity) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_pod_identity | v8.5.0 |
| <a name="module_printit_pdf_engine_app_service"></a> [printit\_pdf\_engine\_app\_service](#module\_printit\_pdf\_engine\_app\_service) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service | v8.5.0 |
| <a name="module_printit_pdf_engine_app_service_ha"></a> [printit\_pdf\_engine\_app\_service\_ha](#module\_printit\_pdf\_engine\_app\_service\_ha) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service | v8.5.0 |
| <a name="module_printit_pdf_engine_app_service_java"></a> [printit\_pdf\_engine\_app\_service\_java](#module\_printit\_pdf\_engine\_app\_service\_java) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service | v8.5.0 |
| <a name="module_printit_pdf_engine_app_service_java_ha"></a> [printit\_pdf\_engine\_app\_service\_java\_ha](#module\_printit\_pdf\_engine\_app\_service\_java\_ha) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service | v8.5.0 |
| <a name="module_printit_pdf_engine_app_service_snet"></a> [printit\_pdf\_engine\_app\_service\_snet](#module\_printit\_pdf\_engine\_app\_service\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.3.0 |
| <a name="module_printit_pdf_engine_java_slot_staging"></a> [printit\_pdf\_engine\_java\_slot\_staging](#module\_printit\_pdf\_engine\_java\_slot\_staging) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot | v8.5.0 |
| <a name="module_printit_pdf_engine_java_slot_staging_ha"></a> [printit\_pdf\_engine\_java\_slot\_staging\_ha](#module\_printit\_pdf\_engine\_java\_slot\_staging\_ha) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot | v8.5.0 |
| <a name="module_printit_pdf_engine_slot_staging"></a> [printit\_pdf\_engine\_slot\_staging](#module\_printit\_pdf\_engine\_slot\_staging) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot | v8.5.0 |
| <a name="module_printit_pdf_engine_slot_staging_ha"></a> [printit\_pdf\_engine\_slot\_staging\_ha](#module\_printit\_pdf\_engine\_slot\_staging\_ha) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot | v8.5.0 |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | git::https://github.com/pagopa/terraform-azurerm-v3.git//tls_checker | v8.5.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_version_set.api_pdf_engine_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_pdf_engine_node_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_autoscale_setting.autoscale_app_service_printit_pdf_engine_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.autoscale_app_service_printit_pdf_engine_autoscale_ha](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.autoscale_app_service_printit_pdf_engine_java_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.autoscale_app_service_printit_pdf_engine_java_autoscale_ha](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_resource_group.printit_pdf_engine_app_service_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [helm_release.cert_mounter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.namespace_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.elastic_otel_token_header](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pdf_engine_node_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | ## Aks | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tls_cert_check_helm"></a> [tls\_cert\_check\_helm](#input\_tls\_cert\_check\_helm) | tls cert helm chart configuration | <pre>object({<br>    chart_version = string,<br>    image_name    = string,<br>    image_tag     = string<br>  })</pre> | n/a | yes |
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_app_service_pdf_engine_always_on"></a> [app\_service\_pdf\_engine\_always\_on](#input\_app\_service\_pdf\_engine\_always\_on) | Always on property | `bool` | `true` | no |
| <a name="input_app_service_pdf_engine_autoscale_enabled"></a> [app\_service\_pdf\_engine\_autoscale\_enabled](#input\_app\_service\_pdf\_engine\_autoscale\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_app_service_pdf_engine_sku_name"></a> [app\_service\_pdf\_engine\_sku\_name](#input\_app\_service\_pdf\_engine\_sku\_name) | app service plan size | `string` | `"S1"` | no |
| <a name="input_app_service_pdf_engine_sku_name_java"></a> [app\_service\_pdf\_engine\_sku\_name\_java](#input\_app\_service\_pdf\_engine\_sku\_name\_java) | app service plan size | `string` | `"S1"` | no |
| <a name="input_cidr_subnet_pdf_engine_app_service"></a> [cidr\_subnet\_pdf\_engine\_app\_service](#input\_cidr\_subnet\_pdf\_engine\_app\_service) | CIDR subnet for App Service | `list(string)` | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The wallet dns subdomain. | `string` | `null` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_io_backend_base_path"></a> [io\_backend\_base\_path](#input\_io\_backend\_base\_path) | io backend api base path | `string` | `null` | no |
| <a name="input_is_feature_enabled"></a> [is\_feature\_enabled](#input\_is\_feature\_enabled) | n/a | <pre>object({<br>    pdf_engine    = bool<br>    pdf_engine_ha = bool<br>  })</pre> | <pre>{<br>  "pdf_engine": false,<br>  "pdf_engine_ha": false<br>}</pre> | no |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_payment_wallet_migrations_enabled"></a> [payment\_wallet\_migrations\_enabled](#input\_payment\_wallet\_migrations\_enabled) | Payment wallet migrations enabled | `bool` | `false` | no |
| <a name="input_payment_wallet_with_pm_enabled"></a> [payment\_wallet\_with\_pm\_enabled](#input\_payment\_wallet\_with\_pm\_enabled) | payment wallet using Payment Manager | `bool` | `false` | no |
| <a name="input_pdv_api_base_path"></a> [pdv\_api\_base\_path](#input\_pdv\_api\_base\_path) | Personal data vault api base path | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.47.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <= 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | <= 2.30.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | 4ac32cd6fb7d56e7be3b1c0dbcbf251f5b0cd199 |
| <a name="module_apim_api_pdf_engine_api_v1"></a> [apim\_api\_pdf\_engine\_api\_v1](#module\_apim\_api\_pdf\_engine\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_pdf_engine_node_api_v1"></a> [apim\_api\_pdf\_engine\_node\_api\_v1](#module\_apim\_api\_pdf\_engine\_node\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_notices_blob_api_v1"></a> [apim\_notices\_blob\_api\_v1](#module\_apim\_notices\_blob\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_notices_blob_product"></a> [apim\_notices\_blob\_product](#module\_apim\_notices\_blob\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_notices_generator_product"></a> [apim\_notices\_generator\_product](#module\_apim\_notices\_generator\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_notices_service_product_external"></a> [apim\_notices\_service\_product\_external](#module\_apim\_notices\_service\_product\_external) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_notices_service_product_internal"></a> [apim\_notices\_service\_product\_internal](#module\_apim\_notices\_service\_product\_internal) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_pdf_engine_product"></a> [apim\_pdf\_engine\_product](#module\_apim\_pdf\_engine\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_cert_mounter"></a> [cert\_mounter](#module\_cert\_mounter) | ./.terraform/modules/__v3__/cert_mounter | n/a |
| <a name="module_gh_runner_job"></a> [gh\_runner\_job](#module\_gh\_runner\_job) | ./.terraform/modules/__v3__/gh_runner_container_app_job_domain_setup | n/a |
| <a name="module_kubernetes_service_account"></a> [kubernetes\_service\_account](#module\_kubernetes\_service\_account) | ./.terraform/modules/__v3__/kubernetes_service_account | n/a |
| <a name="module_printit_pdf_engine_app_service"></a> [printit\_pdf\_engine\_app\_service](#module\_printit\_pdf\_engine\_app\_service) | ./.terraform/modules/__v3__/app_service | n/a |
| <a name="module_printit_pdf_engine_app_service_java"></a> [printit\_pdf\_engine\_app\_service\_java](#module\_printit\_pdf\_engine\_app\_service\_java) | ./.terraform/modules/__v3__/app_service | n/a |
| <a name="module_printit_pdf_engine_java_slot_staging"></a> [printit\_pdf\_engine\_java\_slot\_staging](#module\_printit\_pdf\_engine\_java\_slot\_staging) | ./.terraform/modules/__v3__/app_service_slot | n/a |
| <a name="module_printit_pdf_engine_slot_staging"></a> [printit\_pdf\_engine\_slot\_staging](#module\_printit\_pdf\_engine\_slot\_staging) | ./.terraform/modules/__v3__/app_service_slot | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | ./.terraform/modules/__v3__/tls_checker | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v3__/kubernetes_workload_identity_configuration | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_version_set.api_pdf_engine_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_pdf_engine_node_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_notices_blob_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_subscription.api_config_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.generator_for_service_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.pdf_engine_node_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.pdf_engine_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.api_config_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.application_insights_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_notice_complete_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_notice_complete_jaas_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_notice_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_notice_errors_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_notice_errors_jaas_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_notice_jaas_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.generator_for_service_subkey_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.institutions_storage_account_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.institutions_storage_account_pkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.notices_mongo_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.notices_mongo_primary_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.notices_storage_account_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.notices_storage_account_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.notices_storage_account_pkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pdf_engine_node_subkey_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pdf_engine_subkey_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.templates_storage_account_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.templates_storage_account_pkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.tenant_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_autoscale_setting.autoscale_app_service_printit_pdf_engine_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.autoscale_app_service_printit_pdf_engine_java_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.generate-pdf-engine-generate-responsetime](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pagopa-pdf-engine-pdf-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pagopa-print-payment-notice-generator-responsetime-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pagopa-print-payment-notice-generator-rest-availability-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pagopa-print-payment-notice-service-responsetime-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pagopa-print-payment-notice-service-rest-availability-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pdf-engine-fun-error-alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.print-generator-retry-save-error-alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.print-generator-save-error-alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.print-notice-compress-fn-error-alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.print-notice-retry-fn-error-alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_resource_group.printit_pdf_engine_app_service_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.namespace_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_pod_disruption_budget_v1.pay_wallet](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_disruption_budget_v1) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_api_management_product.apim_api_config_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_application_insights.application_insights_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_cosmosdb_account.notices_cosmos_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_eventhub_authorization_rule.notices_evt_authorization_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.notices_evt_complete_authorization_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.notices_evt_errors_authorization_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.elastic_otel_token_header](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_italy_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.institutions_storage_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.notices_storage_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.templates_storage_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.apim_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.printit_pdf_engine_app_service_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_app_service_ip_restriction_default_action"></a> [app\_service\_ip\_restriction\_default\_action](#input\_app\_service\_ip\_restriction\_default\_action) | (Optional) The Default action for traffic that does not match any ip\_restriction rule. possible values include Allow and Deny. Defaults to Allow. | `string` | `"Allow"` | no |
| <a name="input_app_service_pdf_engine_always_on"></a> [app\_service\_pdf\_engine\_always\_on](#input\_app\_service\_pdf\_engine\_always\_on) | Always on property | `bool` | n/a | yes |
| <a name="input_app_service_pdf_engine_autoscale_enabled"></a> [app\_service\_pdf\_engine\_autoscale\_enabled](#input\_app\_service\_pdf\_engine\_autoscale\_enabled) | APP Service PDF | `bool` | n/a | yes |
| <a name="input_app_service_pdf_engine_sku_name"></a> [app\_service\_pdf\_engine\_sku\_name](#input\_app\_service\_pdf\_engine\_sku\_name) | app service plan size | `string` | n/a | yes |
| <a name="input_app_service_pdf_engine_sku_name_java"></a> [app\_service\_pdf\_engine\_sku\_name\_java](#input\_app\_service\_pdf\_engine\_sku\_name\_java) | app service plan size | `string` | n/a | yes |
| <a name="input_app_service_pdf_engine_sku_name_java_zone_balancing_enabled"></a> [app\_service\_pdf\_engine\_sku\_name\_java\_zone\_balancing\_enabled](#input\_app\_service\_pdf\_engine\_sku\_name\_java\_zone\_balancing\_enabled) | Enable HA multi az balancing | `bool` | n/a | yes |
| <a name="input_app_service_pdf_engine_zone_balancing_enabled"></a> [app\_service\_pdf\_engine\_zone\_balancing\_enabled](#input\_app\_service\_pdf\_engine\_zone\_balancing\_enabled) | n/a | `bool` | n/a | yes |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The wallet dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | ## Aks | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_io_backend_base_path"></a> [io\_backend\_base\_path](#input\_io\_backend\_base\_path) | io backend api base path | `string` | `null` | no |
| <a name="input_is_feature_enabled"></a> [is\_feature\_enabled](#input\_is\_feature\_enabled) | n/a | <pre>object({<br>    pdf_engine = bool<br>    printit    = bool<br>  })</pre> | <pre>{<br>  "pdf_engine": false,<br>  "printit": false<br>}</pre> | no |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_italy_workspace_name"></a> [log\_analytics\_italy\_workspace\_name](#input\_log\_analytics\_italy\_workspace\_name) | Specifies the name of the Log Analytics Workspace Italy. | `string` | n/a | yes |
| <a name="input_log_analytics_italy_workspace_resource_group_name"></a> [log\_analytics\_italy\_workspace\_resource\_group\_name](#input\_log\_analytics\_italy\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace Italy is located in. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_italy_resource_group_name"></a> [monitor\_italy\_resource\_group\_name](#input\_monitor\_italy\_resource\_group\_name) | Monitor Italy resource group name | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_payment_wallet_migrations_enabled"></a> [payment\_wallet\_migrations\_enabled](#input\_payment\_wallet\_migrations\_enabled) | Payment wallet migrations enabled | `bool` | `false` | no |
| <a name="input_payment_wallet_with_pm_enabled"></a> [payment\_wallet\_with\_pm\_enabled](#input\_payment\_wallet\_with\_pm\_enabled) | payment wallet using Payment Manager | `bool` | `false` | no |
| <a name="input_pdv_api_base_path"></a> [pdv\_api\_base\_path](#input\_pdv\_api\_base\_path) | Personal data vault api base path | `string` | `null` | no |
| <a name="input_pod_disruption_budgets"></a> [pod\_disruption\_budgets](#input\_pod\_disruption\_budgets) | Pod disruption budget for domain namespace | <pre>map(object({<br>    name         = optional(string, null)<br>    minAvailable = optional(number, null)<br>    matchLabels  = optional(map(any), {})<br>  }))</pre> | `{}` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
