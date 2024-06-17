# apiconfig-app

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.30.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.38.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 5.12.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | = 2.5.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | = 2.11.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_api_fdr_api_v1_internal"></a> [apim\_api\_fdr\_api\_v1\_internal](#module\_apim\_api\_fdr\_api\_v1\_internal) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v6.3.0 |
| <a name="module_apim_api_fdr_api_v1_org"></a> [apim\_api\_fdr\_api\_v1\_org](#module\_apim\_api\_fdr\_api\_v1\_org) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v6.3.0 |
| <a name="module_apim_api_fdr_api_v1_psp"></a> [apim\_api\_fdr\_api\_v1\_psp](#module\_apim\_api\_fdr\_api\_v1\_psp) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v6.3.0 |
| <a name="module_apim_api_fdr_json_to_xml_api_v1"></a> [apim\_api\_fdr\_json\_to\_xml\_api\_v1](#module\_apim\_api\_fdr\_json\_to\_xml\_api\_v1) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v6.3.0 |
| <a name="module_apim_api_fdr_legacy_api_v1_internal"></a> [apim\_api\_fdr\_legacy\_api\_v1\_internal](#module\_apim\_api\_fdr\_legacy\_api\_v1\_internal) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v6.3.0 |
| <a name="module_apim_api_fdr_xml_to_json_api_v1"></a> [apim\_api\_fdr\_xml\_to\_json\_api\_v1](#module\_apim\_api\_fdr\_xml\_to\_json\_api\_v1) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v6.3.0 |
| <a name="module_apim_fdr_json_to_xml_product"></a> [apim\_fdr\_json\_to\_xml\_product](#module\_apim\_fdr\_json\_to\_xml\_product) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v6.3.0 |
| <a name="module_apim_fdr_nodo_dei_pagamenti_legacy_product"></a> [apim\_fdr\_nodo\_dei\_pagamenti\_legacy\_product](#module\_apim\_fdr\_nodo\_dei\_pagamenti\_legacy\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_fdr_product_internal"></a> [apim\_fdr\_product\_internal](#module\_apim\_fdr\_product\_internal) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v6.3.0 |
| <a name="module_apim_fdr_product_org"></a> [apim\_fdr\_product\_org](#module\_apim\_fdr\_product\_org) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v6.3.0 |
| <a name="module_apim_fdr_product_psp"></a> [apim\_fdr\_product\_psp](#module\_apim\_fdr\_product\_psp) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v6.3.0 |
| <a name="module_apim_fdr_xml_to_json_product"></a> [apim\_fdr\_xml\_to\_json\_product](#module\_apim\_fdr\_xml\_to\_json\_product) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v6.3.0 |
| <a name="module_fdr_json_to_xml_function"></a> [fdr\_json\_to\_xml\_function](#module\_fdr\_json\_to\_xml\_function) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app | v6.20.0 |
| <a name="module_fdr_json_to_xml_function_slot_staging"></a> [fdr\_json\_to\_xml\_function\_slot\_staging](#module\_fdr\_json\_to\_xml\_function\_slot\_staging) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot | v6.9.0 |
| <a name="module_fdr_json_to_xml_function_snet"></a> [fdr\_json\_to\_xml\_function\_snet](#module\_fdr\_json\_to\_xml\_function\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.4.1 |
| <a name="module_fdr_re_function"></a> [fdr\_re\_function](#module\_fdr\_re\_function) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app | v6.20.2 |
| <a name="module_fdr_re_function_slot_staging"></a> [fdr\_re\_function\_slot\_staging](#module\_fdr\_re\_function\_slot\_staging) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot | v6.9.0 |
| <a name="module_fdr_re_function_snet"></a> [fdr\_re\_function\_snet](#module\_fdr\_re\_function\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.4.1 |
| <a name="module_fdr_xml_to_json_function"></a> [fdr\_xml\_to\_json\_function](#module\_fdr\_xml\_to\_json\_function) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app | v6.20.0 |
| <a name="module_fdr_xml_to_json_function_slot_staging"></a> [fdr\_xml\_to\_json\_function\_slot\_staging](#module\_fdr\_xml\_to\_json\_function\_slot\_staging) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot | v6.9.0 |
| <a name="module_fdr_xml_to_json_function_snet"></a> [fdr\_xml\_to\_json\_function\_snet](#module\_fdr\_xml\_to\_json\_function\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.4.1 |
| <a name="module_pod_identity"></a> [pod\_identity](#module\_pod\_identity) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_pod_identity | v4.1.17 |
| <a name="module_reporting_fdr_function"></a> [reporting\_fdr\_function](#module\_reporting\_fdr\_function) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app | v6.17.0 |
| <a name="module_reporting_fdr_function_snet"></a> [reporting\_fdr\_function\_snet](#module\_reporting\_fdr\_function\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.17.0 |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | git::https://github.com/pagopa/terraform-azurerm-v3.git//tls_checker | v6.2.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api.apim_fdr_per_pa_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_operation_policy.fdr_pagopa_policy_nodoChiediElencoFlussiRendicontazione](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.fdr_pagopa_policy_nodoChiediElencoFlussiRendicontazione_auth](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.fdr_pagopa_policy_nodoChiediElencoFlussiRendicontazione_auth_eng](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.fdr_pagopa_policy_nodoChiediFlussoRendicontazione](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.fdr_pagopa_policy_nodoChiediFlussoRendicontazione_auth](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.fdr_pagopa_policy_nodoChiediFlussoRendicontazione_auth_eng](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.fdr_pagopa_policy_nodoInviaFlussoRendicontazione](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.fdr_pagopa_policy_nodoInviaFlussoRendicontazione_auth](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.fdr_pagopa_policy_nodoInviaFlussoRendicontazione_auth_eng](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_policy.apim_fdr_per_pa_policy](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_version_set.api_fdr_api_internal](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_fdr_api_org](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_fdr_api_psp](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_fdr_json_to_xml_api](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_fdr_legacy_api_internal](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_fdr_xml_to_json_api](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.fdr_per_pa_api](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_named_value.fdrcontainername](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.fdrsaname](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ftp_organization](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_product_api.apim_fdr_nodo_dei_pagamenti_product_api](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/api_management_product_api) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_autoscale_setting.fdr_json_to_xml_function](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.fdr_re_to_datastore_function](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.fdr_xml_to_json_function](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.reporting_fdr_function](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert-fdr-nodo-error](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert_fdr_internal_availability](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert_fdr_jsontoxml_appexception](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert_fdr_jsontoxml_appexception_lastretry](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert_fdr_org_availability](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert_fdr_psp_availability](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert_fdr_xmltojson_appexception](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert_fdr_xmltojson_appexception_lastretry](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_resource_group.reporting_fdr_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/resource_group) | resource |
| [helm_release.cert_mounter](https://registry.terraform.io/providers/hashicorp/helm/2.5.1/docs/resources/release) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/2.5.1/docs/resources/release) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace) | resource |
| [kubernetes_namespace.namespace_system](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace) | resource |
| [kubernetes_pod_disruption_budget_v1.fdr](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/pod_disruption_budget_v1) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/role_binding) | resource |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/service_account) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/api_management) | data source |
| [azurerm_api_management_api.apim_node_for_pa_api_v1_auth](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/api_management_api) | data source |
| [azurerm_api_management_api.apim_node_for_psp_api_v1_auth](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/api_management_api) | data source |
| [azurerm_api_management_api.apim_nodo_per_pa_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/api_management_api) | data source |
| [azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/api_management_api) | data source |
| [azurerm_api_management_api.apim_nodo_per_psp_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/api_management_api) | data source |
| [azurerm_api_management_api.apim_nodo_per_psp_api_v1_auth](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/api_management_api) | data source |
| [azurerm_api_management_group.group_developers](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/api_management_group) | data source |
| [azurerm_api_management_group.group_guests](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/api_management_group) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.common-acr](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/container_registry) | data source |
| [azurerm_container_registry.login_server](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/container_registry) | data source |
| [azurerm_cosmosdb_account.mongo_fdr_re_account](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_cosmosdb_mongo_database.fdr_re](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/cosmosdb_mongo_database) | data source |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/dns_zone) | data source |
| [azurerm_eventhub_authorization_rule.events](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.events_03](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns01_fdr-re_fdr-re-rx](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns03_fdr-re_fdr-re-rx](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_namespace.event_hub01_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/eventhub_namespace) | data source |
| [azurerm_eventhub_namespace.event_hub03_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/eventhub_namespace) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.fdr_internal_product_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.container_registry_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.fdr_re_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.fdr_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.msg_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.fdr_flows_sa](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.fdr_re_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.fdr_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/storage_account) | data source |
| [azurerm_storage_container.fdr_rend_flow](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/storage_container) | data source |
| [azurerm_storage_container.fdr_rend_flow_out](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/storage_container) | data source |
| [azurerm_subnet.apim_snet](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/subnet) | data source |
| [azurerm_subnet.apim_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/virtual_network) | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_apim_fdr_nodo_pagopa_enable"></a> [apim\_fdr\_nodo\_pagopa\_enable](#input\_apim\_fdr\_nodo\_pagopa\_enable) | Enable Fdr Service Nodo pagoPA side | `bool` | `false` | no |
| <a name="input_app_service_plan_info"></a> [app\_service\_plan\_info](#input\_app\_service\_plan\_info) | Allows to configurate the internal service plan | <pre>object({<br>    kind                         = string # The kind of the App Service Plan to create. Possible values are Windows (also available as App), Linux, elastic (for Premium Consumption) and FunctionApp (for a Consumption Plan).<br>    sku_size                     = string # Specifies the plan's instance size.<br>    maximum_elastic_worker_count = number # The maximum number of total workers allowed for this ElasticScaleEnabled App Service Plan.<br>    worker_count                 = number # The number of Workers (instances) to be allocated.<br>    zone_balancing_enabled       = bool   # Should the Service Plan balance across Availability Zones in the region. Changing this forces a new resource to be created.<br>  })</pre> | <pre>{<br>  "kind": "Linux",<br>  "maximum_elastic_worker_count": 0,<br>  "sku_size": "P1v3",<br>  "worker_count": 0,<br>  "zone_balancing_enabled": false<br>}</pre> | no |
| <a name="input_cidr_subnet_reporting_fdr"></a> [cidr\_subnet\_reporting\_fdr](#input\_cidr\_subnet\_reporting\_fdr) | Address prefixes subnet reporting\_fdr function | `list(string)` | `null` | no |
| <a name="input_cname_record_name"></a> [cname\_record\_name](#input\_cname\_record\_name) | n/a | `string` | `"config"` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enabled_features"></a> [enabled\_features](#input\_enabled\_features) | Features enabled in this domain | <pre>object({<br>    eventhub_ha_rx = bool<br>  })</pre> | <pre>{<br>  "eventhub_ha_rx": false<br>}</pre> | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_event_name"></a> [event\_name](#input\_event\_name) | Event name related to an EventHub | `string` | `null` | no |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | EventHub name | `string` | `null` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_fdr_json_to_xml_function"></a> [fdr\_json\_to\_xml\_function](#input\_fdr\_json\_to\_xml\_function) | FdR JSON to XML function | <pre>object({<br>    always_on                    = bool<br>    kind                         = string<br>    sku_size                     = string<br>    sku_tier                     = string<br>    maximum_elastic_worker_count = number<br>  })</pre> | <pre>{<br>  "always_on": true,<br>  "kind": "Linux",<br>  "maximum_elastic_worker_count": 1,<br>  "sku_size": "B1",<br>  "sku_tier": "Basic"<br>}</pre> | no |
| <a name="input_fdr_json_to_xml_function_app_image_tag"></a> [fdr\_json\_to\_xml\_function\_app\_image\_tag](#input\_fdr\_json\_to\_xml\_function\_app\_image\_tag) | FdR JSON to XML function app docker image tag. Defaults to 'latest' | `string` | `"latest"` | no |
| <a name="input_fdr_json_to_xml_function_autoscale"></a> [fdr\_json\_to\_xml\_function\_autoscale](#input\_fdr\_json\_to\_xml\_function\_autoscale) | FdR JSON to XML function autoscaling parameters | <pre>object({<br>    default = number<br>    minimum = number<br>    maximum = number<br>  })</pre> | n/a | yes |
| <a name="input_fdr_json_to_xml_function_network_policies_enabled"></a> [fdr\_json\_to\_xml\_function\_network\_policies\_enabled](#input\_fdr\_json\_to\_xml\_function\_network\_policies\_enabled) | Network policies enabled | `bool` | `false` | no |
| <a name="input_fdr_json_to_xml_function_subnet"></a> [fdr\_json\_to\_xml\_function\_subnet](#input\_fdr\_json\_to\_xml\_function\_subnet) | Address prefixes subnet | `list(string)` | `null` | no |
| <a name="input_fdr_re_function"></a> [fdr\_re\_function](#input\_fdr\_re\_function) | FdR RE function | <pre>object({<br>    always_on = bool<br>    kind      = string<br>    sku_size  = string<br>    #    sku_tier                     = string<br>    maximum_elastic_worker_count = number<br>  })</pre> | <pre>{<br>  "always_on": true,<br>  "kind": "Linux",<br>  "maximum_elastic_worker_count": 1,<br>  "sku_size": "B1"<br>}</pre> | no |
| <a name="input_fdr_re_function_app_image_tag"></a> [fdr\_re\_function\_app\_image\_tag](#input\_fdr\_re\_function\_app\_image\_tag) | FdR RE to Datastore function app docker image tag. Defaults to 'latest' | `string` | `"latest"` | no |
| <a name="input_fdr_re_function_autoscale"></a> [fdr\_re\_function\_autoscale](#input\_fdr\_re\_function\_autoscale) | FdR function autoscaling parameters | <pre>object({<br>    default = number<br>    minimum = number<br>    maximum = number<br>  })</pre> | n/a | yes |
| <a name="input_fdr_re_function_network_policies_enabled"></a> [fdr\_re\_function\_network\_policies\_enabled](#input\_fdr\_re\_function\_network\_policies\_enabled) | Network policies enabled | `bool` | `false` | no |
| <a name="input_fdr_re_function_subnet"></a> [fdr\_re\_function\_subnet](#input\_fdr\_re\_function\_subnet) | Address prefixes subnet | `list(string)` | `null` | no |
| <a name="input_fdr_xml_to_json_function"></a> [fdr\_xml\_to\_json\_function](#input\_fdr\_xml\_to\_json\_function) | FdR XML to JSON function | <pre>object({<br>    always_on                    = bool<br>    kind                         = string<br>    sku_size                     = string<br>    sku_tier                     = string<br>    maximum_elastic_worker_count = number<br>  })</pre> | <pre>{<br>  "always_on": true,<br>  "kind": "Linux",<br>  "maximum_elastic_worker_count": 1,<br>  "sku_size": "B1",<br>  "sku_tier": "Basic"<br>}</pre> | no |
| <a name="input_fdr_xml_to_json_function_app_image_tag"></a> [fdr\_xml\_to\_json\_function\_app\_image\_tag](#input\_fdr\_xml\_to\_json\_function\_app\_image\_tag) | FdR XML to JSON function app docker image tag. Defaults to 'latest' | `string` | `"latest"` | no |
| <a name="input_fdr_xml_to_json_function_autoscale"></a> [fdr\_xml\_to\_json\_function\_autoscale](#input\_fdr\_xml\_to\_json\_function\_autoscale) | FdR function autoscaling parameters | <pre>object({<br>    default = number<br>    minimum = number<br>    maximum = number<br>  })</pre> | n/a | yes |
| <a name="input_fdr_xml_to_json_function_network_policies_enabled"></a> [fdr\_xml\_to\_json\_function\_network\_policies\_enabled](#input\_fdr\_xml\_to\_json\_function\_network\_policies\_enabled) | Network policies enabled | `bool` | `false` | no |
| <a name="input_fdr_xml_to_json_function_subnet"></a> [fdr\_xml\_to\_json\_function\_subnet](#input\_fdr\_xml\_to\_json\_function\_subnet) | Address prefixes subnet | `list(string)` | `null` | no |
| <a name="input_fn_app_runtime_version"></a> [fn\_app\_runtime\_version](#input\_fn\_app\_runtime\_version) | Function app runtime version. | `string` | `"~4"` | no |
| <a name="input_ftp_organization"></a> [ftp\_organization](#input\_ftp\_organization) | Organization configured with FTP | `string` | `null` | no |
| <a name="input_function_app_storage_account_replication_type"></a> [function\_app\_storage\_account\_replication\_type](#input\_function\_app\_storage\_account\_replication\_type) | (Optional) Storage account replication type used for function apps | `string` | `"ZRS"` | no |
| <a name="input_github"></a> [github](#input\_github) | n/a | <pre>object({<br>    org = string<br>  })</pre> | <pre>{<br>  "org": "pagopa"<br>}</pre> | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | The image name to use with a function app | `string` | `null` | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | The image tag to use with a function app | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_nodo_pagamenti_subkey_required"></a> [nodo\_pagamenti\_subkey\_required](#input\_nodo\_pagamenti\_subkey\_required) | Enabled subkeys for nodo dei pagamenti api | `bool` | `false` | no |
| <a name="input_pod_disruption_budgets"></a> [pod\_disruption\_budgets](#input\_pod\_disruption\_budgets) | Pod disruption budget for domain namespace | <pre>map(object({<br>    name         = optional(string, null)<br>    minAvailable = optional(number, null)<br>    matchLabels  = optional(map(any), {})<br>  }))</pre> | `{}` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_private_endpoint_network_policies_enabled"></a> [private\_endpoint\_network\_policies\_enabled](#input\_private\_endpoint\_network\_policies\_enabled) | Enables or network policies for private endpoints in Azure. | `bool` | n/a | yes |
| <a name="input_reporting_fdr_function_always_on"></a> [reporting\_fdr\_function\_always\_on](#input\_reporting\_fdr\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_reporting_fdr_function_autoscale_default"></a> [reporting\_fdr\_function\_autoscale\_default](#input\_reporting\_fdr\_function\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_reporting_fdr_function_autoscale_maximum"></a> [reporting\_fdr\_function\_autoscale\_maximum](#input\_reporting\_fdr\_function\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_reporting_fdr_function_autoscale_minimum"></a> [reporting\_fdr\_function\_autoscale\_minimum](#input\_reporting\_fdr\_function\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_reporting_fdr_function_kind"></a> [reporting\_fdr\_function\_kind](#input\_reporting\_fdr\_function\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_reporting_fdr_function_sku_size"></a> [reporting\_fdr\_function\_sku\_size](#input\_reporting\_fdr\_function\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_reporting_fdr_function_sku_tier"></a> [reporting\_fdr\_function\_sku\_tier](#input\_reporting\_fdr\_function\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_reporting_fdr_storage_account_info"></a> [reporting\_fdr\_storage\_account\_info](#input\_reporting\_fdr\_storage\_account\_info) | Storage account | <pre>object({<br>    account_kind                      = string<br>    account_tier                      = string<br>    account_replication_type          = string<br>    access_tier                       = string<br>    advanced_threat_protection_enable = bool<br>  })</pre> | <pre>{<br>  "access_tier": "Hot",<br>  "account_kind": "StorageV2",<br>  "account_replication_type": "LRS",<br>  "account_tier": "Standard",<br>  "advanced_threat_protection_enable": true<br>}</pre> | no |
| <a name="input_storage_account_info"></a> [storage\_account\_info](#input\_storage\_account\_info) | Storage account | <pre>object({<br>    account_kind                      = string<br>    account_tier                      = string<br>    account_replication_type          = string<br>    access_tier                       = string<br>    advanced_threat_protection_enable = bool<br>  })</pre> | <pre>{<br>  "access_tier": "Hot",<br>  "account_kind": "StorageV2",<br>  "account_replication_type": "LRS",<br>  "account_tier": "Standard",<br>  "advanced_threat_protection_enable": true<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_tls_cert_check_helm"></a> [tls\_cert\_check\_helm](#input\_tls\_cert\_check\_helm) | tls cert helm chart configuration | <pre>object({<br>    chart_version = string,<br>    image_name    = string,<br>    image_tag     = string<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
