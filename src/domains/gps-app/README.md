# gps-app

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 3.0.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <= 2.16.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | <= 2.30.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | f97230b8a5838fe3c616b5aa01bef8caeff8bc6b |
| <a name="module_apim_aca_integration_product"></a> [apim\_aca\_integration\_product](#module\_apim\_aca\_integration\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_api_debt_positions_api_v1"></a> [apim\_api\_debt\_positions\_api\_v1](#module\_apim\_api\_debt\_positions\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_debt_positions_api_v2"></a> [apim\_api\_debt\_positions\_api\_v2](#module\_apim\_api\_debt\_positions\_api\_v2) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_debt_positions_api_v3"></a> [apim\_api\_debt\_positions\_api\_v3](#module\_apim\_api\_debt\_positions\_api\_v3) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_gpd_api"></a> [apim\_api\_gpd\_api](#module\_apim\_api\_gpd\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_gpd_api_v2"></a> [apim\_api\_gpd\_api\_v2](#module\_apim\_api\_gpd\_api\_v2) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_gpd_debezium_api"></a> [apim\_api\_gpd\_debezium\_api](#module\_apim\_api\_gpd\_debezium\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_gpd_enrollment_api_v1"></a> [apim\_api\_gpd\_enrollment\_api\_v1](#module\_apim\_api\_gpd\_enrollment\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_gpd_payments_rest_external_api_v1"></a> [apim\_api\_gpd\_payments\_rest\_external\_api\_v1](#module\_apim\_api\_gpd\_payments\_rest\_external\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_gpd_reporting_analysis_api"></a> [apim\_api\_gpd\_reporting\_analysis\_api](#module\_apim\_api\_gpd\_reporting\_analysis\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_gps_donation_api_v1"></a> [apim\_api\_gps\_donation\_api\_v1](#module\_apim\_api\_gps\_donation\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_gps_enrollments_api_v1"></a> [apim\_api\_gps\_enrollments\_api\_v1](#module\_apim\_api\_gps\_enrollments\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_pn_integration_gpd_api_v1"></a> [apim\_api\_pn\_integration\_gpd\_api\_v1](#module\_apim\_api\_pn\_integration\_gpd\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_debt_positions_product"></a> [apim\_debt\_positions\_product](#module\_apim\_debt\_positions\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gpd_debezium_product"></a> [apim\_gpd\_debezium\_product](#module\_apim\_gpd\_debezium\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gpd_enrollment_product"></a> [apim\_gpd\_enrollment\_product](#module\_apim\_gpd\_enrollment\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gpd_integration_product"></a> [apim\_gpd\_integration\_product](#module\_apim\_gpd\_integration\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gpd_payments_pull_product"></a> [apim\_gpd\_payments\_pull\_product](#module\_apim\_gpd\_payments\_pull\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gpd_payments_pull_product_and_debt_positions_product_test"></a> [apim\_gpd\_payments\_pull\_product\_and\_debt\_positions\_product\_test](#module\_apim\_gpd\_payments\_pull\_product\_and\_debt\_positions\_product\_test) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gpd_payments_rest_external_product"></a> [apim\_gpd\_payments\_rest\_external\_product](#module\_apim\_gpd\_payments\_rest\_external\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gpd_payments_soap_product"></a> [apim\_gpd\_payments\_soap\_product](#module\_apim\_gpd\_payments\_soap\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gpd_product"></a> [apim\_gpd\_product](#module\_apim\_gpd\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gpd_reporting_analysis_product"></a> [apim\_gpd\_reporting\_analysis\_product](#module\_apim\_gpd\_reporting\_analysis\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gpd_upload_api_v1"></a> [apim\_gpd\_upload\_api\_v1](#module\_apim\_gpd\_upload\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_gps_donation_product"></a> [apim\_gps\_donation\_product](#module\_apim\_gps\_donation\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gps_enrollments_product"></a> [apim\_gps\_enrollments\_product](#module\_apim\_gps\_enrollments\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gps_product"></a> [apim\_gps\_product](#module\_apim\_gps\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gps_rtp_product"></a> [apim\_gps\_rtp\_product](#module\_apim\_gps\_rtp\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_gps_spontaneous_payments_services_product"></a> [apim\_gps\_spontaneous\_payments\_services\_product](#module\_apim\_gps\_spontaneous\_payments\_services\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_pn_integration_product"></a> [apim\_pn\_integration\_product](#module\_apim\_pn\_integration\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_cert_mounter"></a> [cert\_mounter](#module\_cert\_mounter) | ./.terraform/modules/__v3__/cert_mounter | n/a |
| <a name="module_gh_runner_job"></a> [gh\_runner\_job](#module\_gh\_runner\_job) | ./.terraform/modules/__v3__/gh_runner_container_app_job_domain_setup | n/a |
| <a name="module_pod_identity"></a> [pod\_identity](#module\_pod\_identity) | ./.terraform/modules/__v3__/kubernetes_pod_identity | n/a |
| <a name="module_reporting_analysis_function"></a> [reporting\_analysis\_function](#module\_reporting\_analysis\_function) | ./.terraform/modules/__v3__/function_app | n/a |
| <a name="module_reporting_analysis_function_slot_staging"></a> [reporting\_analysis\_function\_slot\_staging](#module\_reporting\_analysis\_function\_slot\_staging) | ./.terraform/modules/__v3__/function_app_slot | n/a |
| <a name="module_reporting_batch_function"></a> [reporting\_batch\_function](#module\_reporting\_batch\_function) | ./.terraform/modules/__v3__/function_app | n/a |
| <a name="module_reporting_batch_function_slot_staging"></a> [reporting\_batch\_function\_slot\_staging](#module\_reporting\_batch\_function\_slot\_staging) | ./.terraform/modules/__v3__/function_app_slot | n/a |
| <a name="module_reporting_function_snet"></a> [reporting\_function\_snet](#module\_reporting\_function\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_reporting_service_function"></a> [reporting\_service\_function](#module\_reporting\_service\_function) | ./.terraform/modules/__v3__/function_app | n/a |
| <a name="module_reporting_service_function_slot_staging"></a> [reporting\_service\_function\_slot\_staging](#module\_reporting\_service\_function\_slot\_staging) | ./.terraform/modules/__v3__/function_app_slot | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | ./.terraform/modules/__v3__/tls_checker | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v3__/kubernetes_workload_identity_configuration | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.segregation_codes_fragment](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.service_type_set_fragment](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_api_management_api.apim_api_gpd_payments_soap_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_diagnostic.apim_logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_diagnostic) | resource |
| [azurerm_api_management_api_operation_policy.create_debt_position_v1_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.create_debt_position_v2_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.paSendRT_v2_wisp_api_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_version_set.api_debt_positions_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_gpd_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_gpd_debezium_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_gpd_enrollment_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_gpd_payments_rest_external_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_gpd_payments_soap_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_gpd_reporting_analysis_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_gps_donation_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_gps_enrollments_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_pn_integration_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_gpd_upload_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_named_value.afm_pn_sub_key_test_apim_nv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_product_api.apim_api_gpd_payments_soap_product_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_api_gpd_payments_soap_product_nodo_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_subscription.afm_pn_subkey_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.gpd_integration_qa_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.gps_spontaneous_payments_services_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.iuv_generator_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.test_gpd_payments_pull_and_debt_positions_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_app_service_plan.gpd_reporting_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_qa_integration_testing_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gps_mbd_service_integration_test_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.iuv_generator_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.test_gpd_payments_pull_and_debt_positions_subkey_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_autoscale_setting.reporting_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.gpd-ingestion-manager-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.gpd-ingestion-manager-error-alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.gpd-ingestion-manager-error-generic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.gpd-ingestion-manager-error-json](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.gpd-ingestion-manager-error-pdv-tokenizer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.gpd-ingestion-manager-error-unexpected-pdv-tokenizer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.gpd-rtp-error-generic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.gpd-rtp-error-message-sent-to-dead-letter](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.gpd-rtp-error-redis-cache-not-updated](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.gpd-rtp-error-rtp-message-not-sent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.gpd-rtp-opt-in-refresh-error](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-core-external-availability-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-core-external-responsetime-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-core-internal-availability-lock-exception](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-core-internal-availability-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-core-internal-responsetime-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-payments-pull-rest-availability-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-payments-pull-rest-responsetime-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-payments-rest-availability-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-payments-rest-responsetime-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-payments-soap-availability-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-payments-soap-responsetime-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-send-communication-exception](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-upload-rest-availability-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-upload-rest-responsetime-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-upload-service-function-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-gpd-upload-validation-function-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.reporting_nodo_chiedi_elenco_flussi_rendicontazione_error](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.reporting_nodo_chiedi_flusso_rendicontazione_error](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.reporting_update_option_error](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_resource_group.gpd_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.strimzi-kafka-operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.debezium-ingress](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.debezium-network-policy](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.debezium_role](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.debezium_secrets](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.debezoum_rbac](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.healthchecker-config-map](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.healthchecker-cron](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.kafka_connect](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.postgres_connector](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.namespace_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_pod_disruption_budget_v1.gps](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_disruption_budget_v1) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [null_resource.wait_kafka_connect](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.wait_postgres_connector](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [terraform_data.sha256_create_debt_position_v1_policy](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_create_debt_position_v2_policy](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_segregation_codes_fragment](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_service_type_set_fragment](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_api_management_product.apim_gpd_integration_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_api_management_product.apim_gps_spontaneous_payments_services_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_api_management_product.apim_iuv_generator_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_api_management_user.apim_qa_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_user) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_eventhub_namespace_authorization_rule.cdc_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_namespace_authorization_rule) | data source |
| [azurerm_key_vault.gps_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.config_cache_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.flows_sa_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.gpd_db_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.gpd_db_usr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.gpd_paa_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_slack_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.otel_headers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pgres_gpd_cdc_login](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pgres_gpd_cdc_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack_pagopa_pagamenti_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.smo_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.canoneunico_function_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_apim_logger_resource_id"></a> [apim\_logger\_resource\_id](#input\_apim\_logger\_resource\_id) | Resource id for the APIM logger | `string` | `null` | no |
| <a name="input_cidr_subnet_gpd"></a> [cidr\_subnet\_gpd](#input\_cidr\_subnet\_gpd) | Address prefixes subnet gpd service | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_reporting_functions"></a> [cidr\_subnet\_reporting\_functions](#input\_cidr\_subnet\_reporting\_functions) | Address prefixes subnet reporting\_common function | `list(string)` | `null` | no |
| <a name="input_cname_record_name"></a> [cname\_record\_name](#input\_cname\_record\_name) | n/a | `string` | n/a | yes |
| <a name="input_container_cusmtom_image"></a> [container\_cusmtom\_image](#input\_container\_cusmtom\_image) | Job Container configuration | <pre>object({<br/>    cpu    = number<br/>    memory = string<br/>    image  = string<br/>  })</pre> | <pre>{<br/>  "cpu": 0.5,<br/>  "image": "ghcr.io/pagopa/github-self-hosted-runner-azure:beta-add-docker-compose",<br/>  "memory": "1Gi"<br/>}</pre> | no |
| <a name="input_container_registry"></a> [container\_registry](#input\_container\_registry) | Container Registry | `string` | n/a | yes |
| <a name="input_create_wisp_converter"></a> [create\_wisp\_converter](#input\_create\_wisp\_converter) | CREATE WISP dismantling system infra | `bool` | `false` | no |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | Network | <pre>object({<br/>    id     = string<br/>    enable = bool<br/>  })</pre> | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_client_retry"></a> [enable\_client\_retry](#input\_enable\_client\_retry) | Enable client retry | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_flag_responsetime_alert"></a> [flag\_responsetime\_alert](#input\_flag\_responsetime\_alert) | Flag to enable if payments-pull response time alert is available | `number` | `0` | no |
| <a name="input_fn_app_storage_account_info"></a> [fn\_app\_storage\_account\_info](#input\_fn\_app\_storage\_account\_info) | n/a | <pre>object({<br/>    account_kind                      = optional(string, "StorageV2")<br/>    account_tier                      = optional(string, "Standard")<br/>    account_replication_type          = optional(string, "LRS")<br/>    advanced_threat_protection_enable = optional(bool, true)<br/>    access_tier                       = optional(string, "Hot")<br/>    public_network_access_enabled     = optional(bool, false)<br/>    use_legacy_defender_version       = optional(bool, false)<br/>  })</pre> | <pre>{<br/>  "access_tier": "Hot",<br/>  "account_kind": "StorageV2",<br/>  "account_replication_type": "LRS",<br/>  "account_tier": "Standard",<br/>  "advanced_threat_protection_enable": true,<br/>  "public_network_access_enabled": false,<br/>  "use_legacy_defender_version": true<br/>}</pre> | no |
| <a name="input_gh_runner_job_location"></a> [gh\_runner\_job\_location](#input\_gh\_runner\_job\_location) | (Optional) The GH runner container app job location. Consistent with the container app environment location | `string` | `"westeurope"` | no |
| <a name="input_gpd_always_on"></a> [gpd\_always\_on](#input\_gpd\_always\_on) | Always on property | `bool` | `true` | no |
| <a name="input_gpd_autoscale_default"></a> [gpd\_autoscale\_default](#input\_gpd\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_gpd_autoscale_maximum"></a> [gpd\_autoscale\_maximum](#input\_gpd\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_gpd_autoscale_minimum"></a> [gpd\_autoscale\_minimum](#input\_gpd\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_gpd_cache_path"></a> [gpd\_cache\_path](#input\_gpd\_cache\_path) | Api-Config cache path | `string` | `"/cache?keys=creditorInstitutionStations,stations"` | no |
| <a name="input_gpd_cdc_enabled"></a> [gpd\_cdc\_enabled](#input\_gpd\_cdc\_enabled) | Enable CDC for GDP | `bool` | `false` | no |
| <a name="input_gpd_cron_job_enable"></a> [gpd\_cron\_job\_enable](#input\_gpd\_cron\_job\_enable) | GPD cron job enable | `bool` | `false` | no |
| <a name="input_gpd_cron_schedule_expired_to"></a> [gpd\_cron\_schedule\_expired\_to](#input\_gpd\_cron\_schedule\_expired\_to) | GDP cron scheduling (NCRON example '*/55 * * * * *') | `string` | `null` | no |
| <a name="input_gpd_cron_schedule_valid_to"></a> [gpd\_cron\_schedule\_valid\_to](#input\_gpd\_cron\_schedule\_valid\_to) | GPD cron scheduling (NCRON example '*/35 * * * * *') | `string` | `null` | no |
| <a name="input_gpd_db_name"></a> [gpd\_db\_name](#input\_gpd\_db\_name) | Name of the DB to connect to | `string` | `"apd"` | no |
| <a name="input_gpd_dbms_port"></a> [gpd\_dbms\_port](#input\_gpd\_dbms\_port) | Port number of the DBMS | `number` | `5432` | no |
| <a name="input_gpd_max_retry_queuing"></a> [gpd\_max\_retry\_queuing](#input\_gpd\_max\_retry\_queuing) | Max retry queuing when the node calling fails. | `number` | `5` | no |
| <a name="input_gpd_paa_id_intermediario"></a> [gpd\_paa\_id\_intermediario](#input\_gpd\_paa\_id\_intermediario) | PagoPA Broker ID | `string` | `false` | no |
| <a name="input_gpd_paa_stazione_int"></a> [gpd\_paa\_stazione\_int](#input\_gpd\_paa\_stazione\_int) | PagoPA Station ID | `string` | `false` | no |
| <a name="input_gpd_plan_kind"></a> [gpd\_plan\_kind](#input\_gpd\_plan\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_gpd_plan_sku_size"></a> [gpd\_plan\_sku\_size](#input\_gpd\_plan\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_gpd_plan_sku_tier"></a> [gpd\_plan\_sku\_tier](#input\_gpd\_plan\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_gpd_queue_delay_sec"></a> [gpd\_queue\_delay\_sec](#input\_gpd\_queue\_delay\_sec) | The length of time during which the message will be invisible, starting when it is added to the queue. | `number` | `3600` | no |
| <a name="input_gpd_queue_retention_sec"></a> [gpd\_queue\_retention\_sec](#input\_gpd\_queue\_retention\_sec) | The maximum time to allow the message to be in the queue. | `number` | `86400` | no |
| <a name="input_gpd_reporting_schedule_batch"></a> [gpd\_reporting\_schedule\_batch](#input\_gpd\_reporting\_schedule\_batch) | Cron scheduling (every day 1 o'clock every day UTC-0) {second} {minute} {hour} {day} {month} {day-of-week} | `string` | `"0 0 1 * * *"` | no |
| <a name="input_initial_interval_millis"></a> [initial\_interval\_millis](#input\_initial\_interval\_millis) | The initial interval in milliseconds | `number` | `500` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_limits_cpu"></a> [limits\_cpu](#input\_limits\_cpu) | Connect Limit CPU | `string` | `"0.5"` | no |
| <a name="input_limits_memory"></a> [limits\_memory](#input\_limits\_memory) | Connect Limit Memory | `string` | `"512mi"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_max_elapsed_time_millis"></a> [max\_elapsed\_time\_millis](#input\_max\_elapsed\_time\_millis) | The maximum elapsed time in milliseconds | `number` | `1000` | no |
| <a name="input_max_interval_millis"></a> [max\_interval\_millis](#input\_max\_interval\_millis) | The maximum interval in milliseconds | `number` | `1000` | no |
| <a name="input_max_threads"></a> [max\_threads](#input\_max\_threads) | Number of max\_threads | `number` | `1` | no |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | `"pagopa-p-monitor-rg"` | no |
| <a name="input_multiplier"></a> [multiplier](#input\_multiplier) | Multiplier for the client backoff procedure | `number` | `1.5` | no |
| <a name="input_pgbouncer_enabled"></a> [pgbouncer\_enabled](#input\_pgbouncer\_enabled) | Built-in connection pooling solution | `bool` | `false` | no |
| <a name="input_pod_disruption_budgets"></a> [pod\_disruption\_budgets](#input\_pod\_disruption\_budgets) | Pod disruption budget for domain namespace | <pre>map(object({<br/>    name         = optional(string, null)<br/>    minAvailable = optional(number, null)<br/>    matchLabels  = optional(map(any), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_postgres_db_name"></a> [postgres\_db\_name](#input\_postgres\_db\_name) | Postgres Database Name | `string` | `"apd"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_randomization_factor"></a> [randomization\_factor](#input\_randomization\_factor) | Randomization factor for the backoff procedure | `number` | `0.5` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | Number of replicas in cluster | `number` | `1` | no |
| <a name="input_reporting_analysis_dotnet_version"></a> [reporting\_analysis\_dotnet\_version](#input\_reporting\_analysis\_dotnet\_version) | n/a | `string` | `null` | no |
| <a name="input_reporting_analysis_function_always_on"></a> [reporting\_analysis\_function\_always\_on](#input\_reporting\_analysis\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_reporting_analysis_function_client_certificate_mode"></a> [reporting\_analysis\_function\_client\_certificate\_mode](#input\_reporting\_analysis\_function\_client\_certificate\_mode) | client\_certificate\_mode property | `string` | `"Required"` | no |
| <a name="input_reporting_analysis_image"></a> [reporting\_analysis\_image](#input\_reporting\_analysis\_image) | reporting\_analysis\_function docker image | `string` | `""` | no |
| <a name="input_reporting_batch_dotnet_version"></a> [reporting\_batch\_dotnet\_version](#input\_reporting\_batch\_dotnet\_version) | Function app Framework choice | `string` | `null` | no |
| <a name="input_reporting_batch_function_always_on"></a> [reporting\_batch\_function\_always\_on](#input\_reporting\_batch\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_reporting_batch_image"></a> [reporting\_batch\_image](#input\_reporting\_batch\_image) | reporting\_batch\_function docker image | `string` | `""` | no |
| <a name="input_reporting_function"></a> [reporting\_function](#input\_reporting\_function) | Enable reporting\_function | `bool` | n/a | yes |
| <a name="input_reporting_function_autoscale_default"></a> [reporting\_function\_autoscale\_default](#input\_reporting\_function\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `5` | no |
| <a name="input_reporting_function_autoscale_maximum"></a> [reporting\_function\_autoscale\_maximum](#input\_reporting\_function\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `10` | no |
| <a name="input_reporting_function_autoscale_minimum"></a> [reporting\_function\_autoscale\_minimum](#input\_reporting\_function\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_reporting_functions_app_sku"></a> [reporting\_functions\_app\_sku](#input\_reporting\_functions\_app\_sku) | Reporting functions app plan SKU | <pre>object({<br/>    kind     = string<br/>    sku_tier = string<br/>    sku_size = string<br/>  })</pre> | n/a | yes |
| <a name="input_reporting_service_dotnet_version"></a> [reporting\_service\_dotnet\_version](#input\_reporting\_service\_dotnet\_version) | n/a | `string` | `null` | no |
| <a name="input_reporting_service_function_always_on"></a> [reporting\_service\_function\_always\_on](#input\_reporting\_service\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_reporting_service_image"></a> [reporting\_service\_image](#input\_reporting\_service\_image) | reporting\_service\_function docker image | `string` | `""` | no |
| <a name="input_request_cpu"></a> [request\_cpu](#input\_request\_cpu) | Connect Request CPU | `string` | `"0.5"` | no |
| <a name="input_request_memory"></a> [request\_memory](#input\_request\_memory) | Connect Request Memory | `string` | `"512m"` | no |
| <a name="input_tasks_max"></a> [tasks\_max](#input\_tasks\_max) | Number of tasks | `string` | `"1"` | no |
| <a name="input_tls_cert_check_helm"></a> [tls\_cert\_check\_helm](#input\_tls\_cert\_check\_helm) | tls cert helm chart configuration | <pre>object({<br/>    chart_version = string,<br/>    image_name    = string,<br/>    image_tag     = string<br/>  })</pre> | n/a | yes |
| <a name="input_zookeeper_jvm_xms"></a> [zookeeper\_jvm\_xms](#input\_zookeeper\_jvm\_xms) | Zookeeper Jvm Xms | `string` | `"512mi"` | no |
| <a name="input_zookeeper_jvm_xmx"></a> [zookeeper\_jvm\_xmx](#input\_zookeeper\_jvm\_xmx) | Zookeeper Jvm Xmx | `string` | `"512mi"` | no |
| <a name="input_zookeeper_limits_cpu"></a> [zookeeper\_limits\_cpu](#input\_zookeeper\_limits\_cpu) | Zookeeper Limit CPU | `string` | `"0.5"` | no |
| <a name="input_zookeeper_limits_memory"></a> [zookeeper\_limits\_memory](#input\_zookeeper\_limits\_memory) | Zookeeper Limit Memory | `string` | `"512mi"` | no |
| <a name="input_zookeeper_replicas"></a> [zookeeper\_replicas](#input\_zookeeper\_replicas) | Zookeeper Replicas | `number` | `1` | no |
| <a name="input_zookeeper_request_cpu"></a> [zookeeper\_request\_cpu](#input\_zookeeper\_request\_cpu) | Zookeeper Request CPU | `string` | `"0.5"` | no |
| <a name="input_zookeeper_request_memory"></a> [zookeeper\_request\_memory](#input\_zookeeper\_request\_memory) | Zookeeper Request Memory | `string` | `"512m"` | no |
| <a name="input_zookeeper_storage_size"></a> [zookeeper\_storage\_size](#input\_zookeeper\_storage\_size) | Zookeeper Storage Size | `string` | `"100Gi"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
