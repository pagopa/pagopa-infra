<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.30.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | <= 5.12.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <= 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | <= 2.30.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | d0a0b3a81963169bdc974f79eba31e41e918e63d |
| <a name="module_apim_anonymizer_product"></a> [apim\_anonymizer\_product](#module\_apim\_anonymizer\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_api_authorizer_api_v1"></a> [apim\_api\_authorizer\_api\_v1](#module\_apim\_api\_authorizer\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_authorizer_config_api_v1"></a> [apim\_api\_authorizer\_config\_api\_v1](#module\_apim\_api\_authorizer\_config\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_enrolled_orgs_api_v1"></a> [apim\_api\_enrolled\_orgs\_api\_v1](#module\_apim\_api\_enrolled\_orgs\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_influxdb_api_v1"></a> [apim\_api\_influxdb\_api\_v1](#module\_apim\_api\_influxdb\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_influxdb_api_v2"></a> [apim\_api\_influxdb\_api\_v2](#module\_apim\_api\_influxdb\_api\_v2) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_pdf_engine_api_v1"></a> [apim\_api\_pdf\_engine\_api\_v1](#module\_apim\_api\_pdf\_engine\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_pdf_engine_node_api_v1"></a> [apim\_api\_pdf\_engine\_node\_api\_v1](#module\_apim\_api\_pdf\_engine\_node\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_poc_api_v1"></a> [apim\_api\_poc\_api\_v1](#module\_apim\_api\_poc\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_statuspage_api_v1"></a> [apim\_api\_statuspage\_api\_v1](#module\_apim\_api\_statuspage\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_statuspage_nodopagamenti_api_v1"></a> [apim\_api\_statuspage\_nodopagamenti\_api\_v1](#module\_apim\_api\_statuspage\_nodopagamenti\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_taxonomy_api_v1"></a> [apim\_api\_taxonomy\_api\_v1](#module\_apim\_api\_taxonomy\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_authorizer_config_product"></a> [apim\_authorizer\_config\_product](#module\_apim\_authorizer\_config\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_authorizer_product"></a> [apim\_authorizer\_product](#module\_apim\_authorizer\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_enrolled_orgs_product"></a> [apim\_enrolled\_orgs\_product](#module\_apim\_enrolled\_orgs\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_influxdb_product"></a> [apim\_influxdb\_product](#module\_apim\_influxdb\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_pagopa_platform_statuspage_product"></a> [apim\_pagopa\_platform\_statuspage\_product](#module\_apim\_pagopa\_platform\_statuspage\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_pdf_engine_product"></a> [apim\_pdf\_engine\_product](#module\_apim\_pdf\_engine\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_poc_product"></a> [apim\_poc\_product](#module\_apim\_poc\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_session_wallet_api_v1"></a> [apim\_session\_wallet\_api\_v1](#module\_apim\_session\_wallet\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_session_wallet_product"></a> [apim\_session\_wallet\_product](#module\_apim\_session\_wallet\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_statuspage_nodo_pagamenti"></a> [apim\_statuspage\_nodo\_pagamenti](#module\_apim\_statuspage\_nodo\_pagamenti) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_statuspage_product"></a> [apim\_statuspage\_product](#module\_apim\_statuspage\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_taxonomy_product"></a> [apim\_taxonomy\_product](#module\_apim\_taxonomy\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_technical_support_product"></a> [apim\_technical\_support\_product](#module\_apim\_technical\_support\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_gh_runner_job"></a> [gh\_runner\_job](#module\_gh\_runner\_job) | ./.terraform/modules/__v3__/gh_runner_container_app_job_domain_setup | n/a |
| <a name="module_pagopa_shared_toolbox_cdn"></a> [pagopa\_shared\_toolbox\_cdn](#module\_pagopa\_shared\_toolbox\_cdn) | ./.terraform/modules/__v3__/cdn | n/a |
| <a name="module_pod_identity"></a> [pod\_identity](#module\_pod\_identity) | ./.terraform/modules/__v3__/kubernetes_pod_identity | n/a |
| <a name="module_shared_pdf_engine_app_service"></a> [shared\_pdf\_engine\_app\_service](#module\_shared\_pdf\_engine\_app\_service) | ./.terraform/modules/__v3__/app_service | n/a |
| <a name="module_shared_pdf_engine_app_service_java"></a> [shared\_pdf\_engine\_app\_service\_java](#module\_shared\_pdf\_engine\_app\_service\_java) | ./.terraform/modules/__v3__/app_service | n/a |
| <a name="module_shared_pdf_engine_app_service_snet"></a> [shared\_pdf\_engine\_app\_service\_snet](#module\_shared\_pdf\_engine\_app\_service\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_shared_pdf_engine_java_slot_staging"></a> [shared\_pdf\_engine\_java\_slot\_staging](#module\_shared\_pdf\_engine\_java\_slot\_staging) | ./.terraform/modules/__v3__/app_service_slot | n/a |
| <a name="module_shared_pdf_engine_slot_staging"></a> [shared\_pdf\_engine\_slot\_staging](#module\_shared\_pdf\_engine\_slot\_staging) | ./.terraform/modules/__v3__/app_service_slot | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_taxonomy_function"></a> [taxonomy\_function](#module\_taxonomy\_function) | ./.terraform/modules/__v3__/function_app | n/a |
| <a name="module_taxonomy_function_slot_staging"></a> [taxonomy\_function\_slot\_staging](#module\_taxonomy\_function\_slot\_staging) | ./.terraform/modules/__v3__/function_app_slot | n/a |
| <a name="module_taxonomy_function_snet"></a> [taxonomy\_function\_snet](#module\_taxonomy\_function\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | ./.terraform/modules/__v3__/tls_checker | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v3__/kubernetes_workload_identity_configuration | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.authorizer_fragment](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.fragment_chk_jwt_session_token](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_api_management_api.apim_session_wallet_api_mock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_policy.apim_session_wallet_api_mock_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_version_set.api_authorizer_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_authorizer_config_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_enrolled_orgs_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_influxdb2_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_influxdb_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_pdf_engine_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_pdf_engine_node_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_poc_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_statuspage_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_statuspage_nodopagamenti_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_taxonomy_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.session_wallet_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.session_wallet_api_mock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_group.technical_support_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_named_value.pagopa-wallet-jwt-signing-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wallet-jwt-signing-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wallet_personal_data_vault_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_product_group.technical_support_group_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_group) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pagopa_shared_toolbox_storage_account_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pagopa_shared_toolbox_web_storage_blob_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_autoscale_setting.autoscale_app_service_shared_pdf_engine_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.autoscale_app_service_shared_pdf_engine_java_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.taxonomy_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_generate-pdf-engine-generate-responsetime](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-anonymizer-rest-availability-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-anonymizer-rest-responsetime-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-pdf-engine-pdf-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-platform-authorizer-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-platform-authorizer-config-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-platform-authorizer-responsetime](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pagopa-platform-authorizer-exceptions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pdf-engine-fun-error-alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.taxonomy_appexception](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.taxonomy_blobstorageexception](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.taxonomy_genericerror](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_resource_group.pagopa_shared_toolbox_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.shared_pdf_engine_app_service_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [helm_release.cert_mounter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.influxdb](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.influxdb2](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.system_domain_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_pod_disruption_budget_v1.shared](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_disruption_budget_v1) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [terraform_data.sha256_authorizer_fragment](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_fragment_chk_jwt_session_token](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_api_management_product.apim_pn_integration_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_function_app.canone_unico](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/function_app) | data source |
| [azurerm_function_app.reporting_analysis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/function_app) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.apiconfig_selfcare_integration_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.apiconfig_selfcare_integration_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.authorizer_cosmos_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.authorizer_cosmos_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.authorizer_cosmos_uri](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.authorizer_refresh_configuration_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.elastic_otel_token_header](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pdf_engine_node_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.personal_data_vault_api_key_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.wallet_jwt_signing_key_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_linux_function_app.mockec](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_web_app.pdf_engine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_web_app) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.taxonomy_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.pagopa_apiconfig_fe_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.pagopa_selfcare_fe_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.taxonomy_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.apim_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_app_service_pdf_engine_always_on"></a> [app\_service\_pdf\_engine\_always\_on](#input\_app\_service\_pdf\_engine\_always\_on) | Always on property | `bool` | `true` | no |
| <a name="input_app_service_pdf_engine_autoscale_enabled"></a> [app\_service\_pdf\_engine\_autoscale\_enabled](#input\_app\_service\_pdf\_engine\_autoscale\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_app_service_pdf_engine_sku_name"></a> [app\_service\_pdf\_engine\_sku\_name](#input\_app\_service\_pdf\_engine\_sku\_name) | app service plan size | `string` | `"S1"` | no |
| <a name="input_app_service_pdf_engine_sku_name_java"></a> [app\_service\_pdf\_engine\_sku\_name\_java](#input\_app\_service\_pdf\_engine\_sku\_name\_java) | app service plan size | `string` | `"S1"` | no |
| <a name="input_authorizer_function_always_on"></a> [authorizer\_function\_always\_on](#input\_authorizer\_function\_always\_on) | Should authorizer-functions app be always on? | `bool` | n/a | yes |
| <a name="input_authorizer_functions_app_image_tag"></a> [authorizer\_functions\_app\_image\_tag](#input\_authorizer\_functions\_app\_image\_tag) | Authorizer functions app docker image tag. Defaults to 'latest' | `string` | `"latest"` | no |
| <a name="input_authorizer_functions_app_sku"></a> [authorizer\_functions\_app\_sku](#input\_authorizer\_functions\_app\_sku) | Authorizer functions app plan SKU | <pre>object({<br/>    kind     = string<br/>    sku_size = string<br/>  })</pre> | n/a | yes |
| <a name="input_authorizer_functions_autoscale"></a> [authorizer\_functions\_autoscale](#input\_authorizer\_functions\_autoscale) | Authorizer functions autoscaling parameters | <pre>object({<br/>    default = number<br/>    minimum = number<br/>    maximum = number<br/>  })</pre> | n/a | yes |
| <a name="input_cdn_storage_account_replication_type"></a> [cdn\_storage\_account\_replication\_type](#input\_cdn\_storage\_account\_replication\_type) | (Optional) Cdn storage account replication type | `string` | `"GRS"` | no |
| <a name="input_cidr_subnet_authorizer_functions"></a> [cidr\_subnet\_authorizer\_functions](#input\_cidr\_subnet\_authorizer\_functions) | CIDR subnet for Authorizer functions | `string` | n/a | yes |
| <a name="input_cidr_subnet_pdf_engine_app_service"></a> [cidr\_subnet\_pdf\_engine\_app\_service](#input\_cidr\_subnet\_pdf\_engine\_app\_service) | CIDR subnet for App Service | `list(string)` | `null` | no |
| <a name="input_cname_record_name"></a> [cname\_record\_name](#input\_cname\_record\_name) | n/a | `string` | `"shared"` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_function_app_ip_restriction_default_action"></a> [function\_app\_ip\_restriction\_default\_action](#input\_function\_app\_ip\_restriction\_default\_action) | (Optional) The Default action for traffic that does not match any ip\_restriction rule. possible values include Allow and Deny. Defaults to Allow. | `string` | `"Allow"` | no |
| <a name="input_function_app_storage_account_replication_type"></a> [function\_app\_storage\_account\_replication\_type](#input\_function\_app\_storage\_account\_replication\_type) | (Optional) Storage account replication type used for function apps | `string` | `"ZRS"` | no |
| <a name="input_gh_runner_job_location"></a> [gh\_runner\_job\_location](#input\_gh\_runner\_job\_location) | (Optional) The GH runner container app job location. Consistent with the container app environment location | `string` | `"westeurope"` | no |
| <a name="input_influxdb2_helm"></a> [influxdb2\_helm](#input\_influxdb2\_helm) | influxdb2 helm chart configuration | <pre>object({<br/>    chart_version = string,<br/>    image = object({<br/>      name = string,<br/>      tag  = string<br/>    })<br/>  })</pre> | <pre>{<br/>  "chart_version": "2.1.0",<br/>  "image": {<br/>    "name": "influxdb",<br/>    "tag": "2.2.0-alpine@sha256:f3b54d91cae591fc3fde20299bd0b262f6f6d9a1f73b98d623b501e82c49d5fb"<br/>  }<br/>}</pre> | no |
| <a name="input_influxdb_helm"></a> [influxdb\_helm](#input\_influxdb\_helm) | influxdb helm chart configuration | <pre>object({<br/>    chart_version = string,<br/>    image = object({<br/>      name = string,<br/>      tag  = string<br/>    })<br/>  })</pre> | <pre>{<br/>  "chart_version": "4.12.0",<br/>  "image": {<br/>    "name": "influxdb",<br/>    "tag": "1.8.10-alpine@sha256:c436689dc135f204734d63b82fd03044fa3a5205127cb2d1fa7398ff224936b1"<br/>  }<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_io_backend_base_path"></a> [io\_backend\_base\_path](#input\_io\_backend\_base\_path) | io backend api base path | `string` | `null` | no |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_pagopa_shared_toolbox_enabled"></a> [pagopa\_shared\_toolbox\_enabled](#input\_pagopa\_shared\_toolbox\_enabled) | pagoPA Shared Toolbox enabled | `bool` | `true` | no |
| <a name="input_pagopa_shared_toolbox_singlepageapp"></a> [pagopa\_shared\_toolbox\_singlepageapp](#input\_pagopa\_shared\_toolbox\_singlepageapp) | Single Page Applications root directories | `list(string)` | <pre>[<br/>  "ui"<br/>]</pre> | no |
| <a name="input_pdv_api_base_path"></a> [pdv\_api\_base\_path](#input\_pdv\_api\_base\_path) | Personal data vault api base path | `string` | `null` | no |
| <a name="input_pod_disruption_budgets"></a> [pod\_disruption\_budgets](#input\_pod\_disruption\_budgets) | Pod disruption budget for domain namespace | <pre>map(object({<br/>    name         = optional(string, null)<br/>    minAvailable = optional(number, null)<br/>    matchLabels  = optional(map(any), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_robots_indexed_paths"></a> [robots\_indexed\_paths](#input\_robots\_indexed\_paths) | List of cdn paths to allow robots index | `list(string)` | n/a | yes |
| <a name="input_taxonomy_function"></a> [taxonomy\_function](#input\_taxonomy\_function) | Taxonomy function | <pre>object({<br/>    always_on                    = bool<br/>    kind                         = string<br/>    sku_size                     = string<br/>    maximum_elastic_worker_count = number<br/>  })</pre> | n/a | yes |
| <a name="input_taxonomy_function_app_image_tag"></a> [taxonomy\_function\_app\_image\_tag](#input\_taxonomy\_function\_app\_image\_tag) | Taxonomy function app docker image tag. Defaults to 'latest' | `string` | `"latest"` | no |
| <a name="input_taxonomy_function_autoscale"></a> [taxonomy\_function\_autoscale](#input\_taxonomy\_function\_autoscale) | Taxonomy function autoscaling parameters | <pre>object({<br/>    default = number<br/>    minimum = number<br/>    maximum = number<br/>  })</pre> | n/a | yes |
| <a name="input_taxonomy_function_network_policies_enabled"></a> [taxonomy\_function\_network\_policies\_enabled](#input\_taxonomy\_function\_network\_policies\_enabled) | Network policies enabled | `bool` | `false` | no |
| <a name="input_taxonomy_function_subnet"></a> [taxonomy\_function\_subnet](#input\_taxonomy\_function\_subnet) | Address prefixes subnet | `list(string)` | `null` | no |
| <a name="input_tls_cert_check_helm"></a> [tls\_cert\_check\_helm](#input\_tls\_cert\_check\_helm) | tls cert helm chart configuration | <pre>object({<br/>    chart_version = string,<br/>    image_name    = string,<br/>    image_tag     = string<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
