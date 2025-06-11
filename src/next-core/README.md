<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.47.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.85.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <= 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | <= 2.25.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim"></a> [apim](#module\_apim) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management | v8.23.0 |
| <a name="module_apim_monitor"></a> [apim\_monitor](#module\_apim\_monitor) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v8.8.0 |
| <a name="module_apim_snet"></a> [apim\_snet](#module\_apim\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v8.23.0 |
| <a name="module_app_gw"></a> [app\_gw](#module\_app\_gw) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_gateway | v8.8.0 |
| <a name="module_app_gw_integration"></a> [app\_gw\_integration](#module\_app\_gw\_integration) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_gateway | v8.93.1 |
| <a name="module_appgateway_snet"></a> [appgateway\_snet](#module\_appgateway\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v8.8.0 |
| <a name="module_assets_cdn_platform"></a> [assets\_cdn\_platform](#module\_assets\_cdn\_platform) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cdn | v7.50.0 |
| <a name="module_azdoa_li_app"></a> [azdoa\_li\_app](#module\_azdoa\_li\_app) | git::https://github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent | v8.13.0 |
| <a name="module_azdoa_li_infra"></a> [azdoa\_li\_infra](#module\_azdoa\_li\_infra) | git::https://github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent | v8.13.0 |
| <a name="module_azdoa_loadtest_li"></a> [azdoa\_loadtest\_li](#module\_azdoa\_loadtest\_li) | git::https://github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent | v8.13.0 |
| <a name="module_azdoa_snet"></a> [azdoa\_snet](#module\_azdoa\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v8.13.0 |
| <a name="module_backupstorage"></a> [backupstorage](#module\_backupstorage) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v8.2.0 |
| <a name="module_common_private_endpoint_snet"></a> [common\_private\_endpoint\_snet](#module\_common\_private\_endpoint\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.62.0 |
| <a name="module_container_registry"></a> [container\_registry](#module\_container\_registry) | git::https://github.com/pagopa/terraform-azurerm-v3.git//container_registry | v8.22.0 |
| <a name="module_dns_forwarder"></a> [dns\_forwarder](#module\_dns\_forwarder) | git::https://github.com/pagopa/terraform-azurerm-v3.git//dns_forwarder | v8.22.0 |
| <a name="module_dns_forwarder_backup_snet"></a> [dns\_forwarder\_backup\_snet](#module\_dns\_forwarder\_backup\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.76.0 |
| <a name="module_dns_forwarder_backup_vmss_li"></a> [dns\_forwarder\_backup\_vmss\_li](#module\_dns\_forwarder\_backup\_vmss\_li) | git::https://github.com/pagopa/terraform-azurerm-v3.git//dns_forwarder_scale_set_vm | v7.76.0 |
| <a name="module_dns_forwarder_snet"></a> [dns\_forwarder\_snet](#module\_dns\_forwarder\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.76.0 |
| <a name="module_domain_key_vault_secrets_query"></a> [domain\_key\_vault\_secrets\_query](#module\_domain\_key\_vault\_secrets\_query) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v7.50.0 |
| <a name="module_event_hub03"></a> [event\_hub03](#module\_event\_hub03) | git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub | v7.62.0 |
| <a name="module_event_hub04"></a> [event\_hub04](#module\_event\_hub04) | git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub | v7.62.0 |
| <a name="module_event_hubprf"></a> [event\_hubprf](#module\_event\_hubprf) | git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub | v7.62.0 |
| <a name="module_eventhub_snet"></a> [eventhub\_snet](#module\_eventhub\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v8.2.0 |
| <a name="module_integration_appgateway_snet"></a> [integration\_appgateway\_snet](#module\_integration\_appgateway\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.0 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault | v8.22.0 |
| <a name="module_loadtest_agent_snet"></a> [loadtest\_agent\_snet](#module\_loadtest\_agent\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v8.13.0 |
| <a name="module_logos_donation_flows_sa"></a> [logos\_donation\_flows\_sa](#module\_logos\_donation\_flows\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.50.0 |
| <a name="module_nat_gw"></a> [nat\_gw](#module\_nat\_gw) | git::https://github.com/pagopa/terraform-azurerm-v3.git//nat_gateway | v8.47.0 |
| <a name="module_node_forwarder_app_service"></a> [node\_forwarder\_app\_service](#module\_node\_forwarder\_app\_service) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service | v8.28.0 |
| <a name="module_node_forwarder_dbg_app_service"></a> [node\_forwarder\_dbg\_app\_service](#module\_node\_forwarder\_dbg\_app\_service) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service | v7.69.1 |
| <a name="module_node_forwarder_dbg_slot_staging"></a> [node\_forwarder\_dbg\_slot\_staging](#module\_node\_forwarder\_dbg\_slot\_staging) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot | v7.60.0 |
| <a name="module_node_forwarder_dbg_snet"></a> [node\_forwarder\_dbg\_snet](#module\_node\_forwarder\_dbg\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.69.1 |
| <a name="module_node_forwarder_ha_snet"></a> [node\_forwarder\_ha\_snet](#module\_node\_forwarder\_ha\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.69.1 |
| <a name="module_node_forwarder_slot_staging"></a> [node\_forwarder\_slot\_staging](#module\_node\_forwarder\_slot\_staging) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot | v8.28.0 |
| <a name="module_node_forwarder_snet"></a> [node\_forwarder\_snet](#module\_node\_forwarder\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.69.1 |
| <a name="module_redis"></a> [redis](#module\_redis) | git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache | v7.50.0 |
| <a name="module_redis_snet"></a> [redis\_snet](#module\_redis\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.0 |
| <a name="module_route_table_peering_nexi"></a> [route\_table\_peering\_nexi](#module\_route\_table\_peering\_nexi) | git::https://github.com/pagopa/terraform-azurerm-v3.git//route_table | v8.33.0 |
| <a name="module_route_table_peering_sia"></a> [route\_table\_peering\_sia](#module\_route\_table\_peering\_sia) | git::https://github.com/pagopa/terraform-azurerm-v3.git//route_table | v7.62.0 |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../tag_config | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network | v7.62.0 |
| <a name="module_vnet_core_peering"></a> [vnet\_core\_peering](#module\_vnet\_core\_peering) | git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering | v8.32.0 |
| <a name="module_vnet_integration"></a> [vnet\_integration](#module\_vnet\_integration) | git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network | v7.62.0 |
| <a name="module_vnet_peering"></a> [vnet\_peering](#module\_vnet\_peering) | git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering | v8.13.0 |
| <a name="module_vnet_replica"></a> [vnet\_replica](#module\_vnet\_replica) | git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network | v7.62.0 |
| <a name="module_vpn"></a> [vpn](#module\_vpn) | git::https://github.com/pagopa/terraform-azurerm-v3.git//vpn_gateway | v8.33.0 |
| <a name="module_vpn_snet"></a> [vpn\_snet](#module\_vpn\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.76.0 |
| <a name="module_web_test_standard"></a> [web\_test\_standard](#module\_web\_test\_standard) | git::https://github.com/pagopa/terraform-azurerm-v3.git//application_insights_standard_web_test | v8.29.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_custom_domain.api_custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_custom_domain) | resource |
| [azurerm_api_management_group.afm_calculator](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.centro_stella](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.checkout_rate_limit_300](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.checkout_rate_no_limit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.client_io](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.ecommerce](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.gps_grp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.pagopa_core_grp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.payment_manager](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.pda](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.piattaforma_notifiche](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.readonly](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group_user.pagopa_core_usr_to_grp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group_user) | resource |
| [azurerm_api_management_named_value.aks_lb_nexi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.apicfg_core_service_path](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.apicfg_selfcare_integ_service_path](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_fatturazione](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_fatturazione_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_oncloud](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_ppt_lmi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_ppt_lmi_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_sync](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_sync_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_web_bo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_web_bo_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_web_bo_history](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_web_bo_history_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_wfesp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_wfesp_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.brokerlist_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.checkout_google_recaptcha_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.checkout_v2_test_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.default_nodo_backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.default_nodo_backend_dev_nexi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.default_nodo_backend_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.default_nodo_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.donazioni_config_name](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.donazioni_config_name_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecblacklist_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.enable_nm3_decoupler_switch](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.enable_routing_decoupler_switch](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_checkout_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_checkout_url_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_mock_services_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.password_pm_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pm_gtw_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pm_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pm_host_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pm_onprem_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.schema_ip_nexi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.user_pm_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.verificatore_api_key_apiconfig](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp2_gov_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp2_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_user.pagopa_core_usr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_user) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_application_insights_web_test.assets_cdn_platform_web_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_web_test) | resource |
| [azurerm_container_app_environment.tools_cae](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment) | resource |
| [azurerm_dns_a_record.dns_a_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_api_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_management](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_management_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_portal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_portal_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_upload](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_wisp2_at](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_caa_record.api_platform_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_caa_record.api_platform_pagopa_it_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_caa_record.wisp2_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_cname_record.statuspage_platform_pagopa_it_cname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_ns_record.dev_pagopa_it_ns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.dev_wisp2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.prf_pagopa_it_ns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.uat_pagopa_it_ns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.uat_wisp2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_dns_zone.public_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_dns_zone.wisp2_public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_security_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.api_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_gateway_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_gateway_public_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_legacy_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azure_cdn_frontdoor_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.certificate_crt_node_forwarder_s](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.certificate_key_node_forwarder_s](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.github_token_read_packages_bot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.newconn_opsgenie_webhook_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.node_forwarder_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.team_core_opsgenie_webhook_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_action_group.cert_pipeline_status](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.error_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.infra_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.mo_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.new_conn_srv_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.pm_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.smo_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_autoscale_setting.node_forwarder_app_service_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.node_forwarder_dbg_app_service_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_diagnostic_setting.activity_log](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_metric_alert.app_service_over_cpu_usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.app_service_over_mem_usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.snat_connection_over_10K](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-node-forwarder-availability-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-node-forwarder-responsetime-upd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_workspace.monitor_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_workspace) | resource |
| [azurerm_network_security_group.apimv2_snet_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.apimv2_snet_nsg_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_private_dns_a_record.platform_dns_a_private_apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.platform_dns_a_private_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo_dr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo_nexi_postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo_nexi_postgres_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo_nexi_postgres_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo_nexi_postgres_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo_nexi_postgres_prf_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo_nexi_postgres_prf_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.appservice_private_dns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.db_nodo_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.internal_platform_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.platform_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.platform_private_dns_zone_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.private_db_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_azurecr_pagopa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_queue_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_redis_cache_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_servicebus_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_table_cosmos_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.prometheus_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.table_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.db_nodo_dns_zone_virtual_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.internal_platform_pagopa_it_private_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.internal_platform_vnetlink_vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.platform_vnetlink_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.platform_vnetlink_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.platform_vnetlink_vnet_integration_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.platform_vnetlink_vnet_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.postgres_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.postgres_vnet_replica](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.private_db_zone_to_core_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_azurewebsite_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_azurewebsite_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_blob_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_blob_azure_com_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_documents_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_documents_azure_com_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_redis_cache_windows_net_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_table_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_table_cosmos_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_table_cosmos_azure_com_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.prometheus_dns_zone_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vnet_core_link_privatelink_servicebus_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vnet_integration_link_privatelink_servicebus_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vnet_integration_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vnet_link_privatelink_queue_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vnet_privatelink_mongo_cosmos_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.backup_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.forwarder_input_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.forwarder_staging_input_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.monitor_workspace_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_public_ip.apim_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.appgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.integration_appgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.nat_ip_03](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.nat_ip_04](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.assets_cdn_platform_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.azdo_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.container_registry_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.default_roleassignment_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.managed_identities_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.msg_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.node_forwarder_dbg_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.node_forwarder_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.tools_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.data_contributor_role_donations](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.iac_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_storage_blob.donation_logo10](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.donation_logo7](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.donation_logo8](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.donation_logo9](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_container.apim_backup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.donation_logo10](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.donation_logo7](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.donation_logo8](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.donation_logo9](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.backups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_subnet.tools_cae_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.nodefw_dbg_snet_nat_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_nat_gateway_association.nodefw_ha_snet_nat_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_network_security_group_association.apim_snet_sg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.rt_sia_for_appgw_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_user_assigned_identity.appgateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.appgateway_public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_virtual_machine_scale_set_extension.custom_script_extension_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension) | resource |
| [azurerm_virtual_machine_scale_set_extension.custom_script_extension_infra](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension) | resource |
| [null_resource.change_auth_donations_blob_container_logo10](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [null_resource.change_auth_donations_blob_container_logo7](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [null_resource.change_auth_donations_blob_container_logo8](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [null_resource.change_auth_donations_blob_container_logo9](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [random_id.dns_forwarder_hash](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [azuread_application.vpn_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_deploy_legacy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_plan_legacy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_key_vault_certificate.app_gw_platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.app_gw_platform_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.app_gw_platform_upload](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.management_platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.portal_platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.wfespgovit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.wisp2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.wisp2govit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_secret.alert_cert_pipeline_status_notification_slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.alert_error_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.alert_error_notification_slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.apim_publisher_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.certificate_crt_node_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.certificate_key_node_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.checkout_v2_test_key_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_buyerbanks_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_checkout_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.google_recaptcha_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.mock_services_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_mo_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_new_conn_srv_webhook_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_slack_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_pm_opsgenie_webhook_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.opsgenie_infra_webhook_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.opsgenie_smo_webhook_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.password_pm_test_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_gtw_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_host_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_onprem_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_storage_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_workspace_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.user_pm_test_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.verificatore_key_secret_apiconfig](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_private_dns_zone.privatelink_blob_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_public_ip.natgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip) | data source |
| [azurerm_subnet.eventhub_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.iac_federated_azdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_user_assigned_identity.public_appgateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apicfg_core_service_path_value"></a> [apicfg\_core\_service\_path\_value](#input\_apicfg\_core\_service\_path\_value) | apicfg core cache path | `string` | n/a | yes |
| <a name="input_apicfg_selfcare_integ_service_path_value"></a> [apicfg\_selfcare\_integ\_service\_path\_value](#input\_apicfg\_selfcare\_integ\_service\_path\_value) | apicfg selfcare integ cache path | `string` | n/a | yes |
| <a name="input_apim_enable_nm3_decoupler_switch"></a> [apim\_enable\_nm3\_decoupler\_switch](#input\_apim\_enable\_nm3\_decoupler\_switch) | Enable switch backend address in NM3 algorithm logic | `bool` | `false` | no |
| <a name="input_apim_enable_routing_decoupler_switch"></a> [apim\_enable\_routing\_decoupler\_switch](#input\_apim\_enable\_routing\_decoupler\_switch) | Enable switch backend address in Routing algorithm logic | `bool` | `false` | no |
| <a name="input_apim_v2_alerts_enabled"></a> [apim\_v2\_alerts\_enabled](#input\_apim\_v2\_alerts\_enabled) | Enable alerts | `bool` | `true` | no |
| <a name="input_apim_v2_autoscale"></a> [apim\_v2\_autoscale](#input\_apim\_v2\_autoscale) | Configure Apim autoscale on capacity metric | <pre>object(<br/>    {<br/>      enabled                       = bool<br/>      default_instances             = number<br/>      minimum_instances             = number<br/>      maximum_instances             = number<br/>      scale_out_capacity_percentage = number<br/>      scale_out_time_window         = string<br/>      scale_out_value               = string<br/>      scale_out_cooldown            = string<br/>      scale_in_capacity_percentage  = number<br/>      scale_in_time_window          = string<br/>      scale_in_value                = string<br/>      scale_in_cooldown             = string<br/>    }<br/>  )</pre> | <pre>{<br/>  "default_instances": 1,<br/>  "enabled": false,<br/>  "maximum_instances": 5,<br/>  "minimum_instances": 1,<br/>  "scale_in_capacity_percentage": 30,<br/>  "scale_in_cooldown": "PT30M",<br/>  "scale_in_time_window": "PT30M",<br/>  "scale_in_value": "1",<br/>  "scale_out_capacity_percentage": 60,<br/>  "scale_out_cooldown": "PT45M",<br/>  "scale_out_time_window": "PT10M",<br/>  "scale_out_value": "2"<br/>}</pre> | no |
| <a name="input_apim_v2_publisher_name"></a> [apim\_v2\_publisher\_name](#input\_apim\_v2\_publisher\_name) | n/a | `string` | n/a | yes |
| <a name="input_apim_v2_sku"></a> [apim\_v2\_sku](#input\_apim\_v2\_sku) | n/a | `string` | n/a | yes |
| <a name="input_apim_v2_subnet_nsg_security_rules"></a> [apim\_v2\_subnet\_nsg\_security\_rules](#input\_apim\_v2\_subnet\_nsg\_security\_rules) | Network security rules for APIM subnet | `list(any)` | n/a | yes |
| <a name="input_apim_v2_zones"></a> [apim\_v2\_zones](#input\_apim\_v2\_zones) | (Optional) Zones in which the apim will be deployed | `list(string)` | <pre>[<br/>  "1"<br/>]</pre> | no |
| <a name="input_app_gateway_alerts_enabled"></a> [app\_gateway\_alerts\_enabled](#input\_app\_gateway\_alerts\_enabled) | Enable alerts | `bool` | `true` | no |
| <a name="input_app_gateway_allowed_fdr_soap_action"></a> [app\_gateway\_allowed\_fdr\_soap\_action](#input\_app\_gateway\_allowed\_fdr\_soap\_action) | Allowed SOAPAction header for upload platform fqdn | `list(string)` | <pre>[<br/>  "nodoInviaFlussoRendicontazione",<br/>  "nodoChiediFlussoRendicontazione",<br/>  "nodoChiediElencoFlussiRendicontazione"<br/>]</pre> | no |
| <a name="input_app_gateway_allowed_paths_pagopa_onprem_only"></a> [app\_gateway\_allowed\_paths\_pagopa\_onprem\_only](#input\_app\_gateway\_allowed\_paths\_pagopa\_onprem\_only) | Allowed paths from pagopa onprem only | <pre>object({<br/>    paths = list(string)<br/>    ips   = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_app_gateway_allowed_paths_upload"></a> [app\_gateway\_allowed\_paths\_upload](#input\_app\_gateway\_allowed\_paths\_upload) | Allowed paths from pagopa for upload platform fqdn | `list(string)` | <pre>[<br/>  "/upload/gpd/.*",<br/>  "/nodo-auth/node-for-psp/.*",<br/>  "/nodo-auth/nodo-per-psp/.*",<br/>  "/nodo/nodo-per-psp/.*",<br/>  "/nodo/nodo-per-pa/.*",<br/>  "/nodo-auth/nodo-per-pa/.*",<br/>  "/nodo-auth/node-for-pa/.*",<br/>  "/nodo/node-for-psp/.*"<br/>]</pre> | no |
| <a name="input_app_gateway_api_certificate_name"></a> [app\_gateway\_api\_certificate\_name](#input\_app\_gateway\_api\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_deny_paths"></a> [app\_gateway\_deny\_paths](#input\_app\_gateway\_deny\_paths) | Deny paths on app gateway | `list(string)` | `[]` | no |
| <a name="input_app_gateway_deny_paths_2"></a> [app\_gateway\_deny\_paths\_2](#input\_app\_gateway\_deny\_paths\_2) | Deny paths on app gateway | `list(string)` | `[]` | no |
| <a name="input_app_gateway_management_certificate_name"></a> [app\_gateway\_management\_certificate\_name](#input\_app\_gateway\_management\_certificate\_name) | Application gateway api management certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_max_capacity"></a> [app\_gateway\_max\_capacity](#input\_app\_gateway\_max\_capacity) | n/a | `number` | `2` | no |
| <a name="input_app_gateway_min_capacity"></a> [app\_gateway\_min\_capacity](#input\_app\_gateway\_min\_capacity) | n/a | `number` | `0` | no |
| <a name="input_app_gateway_portal_certificate_name"></a> [app\_gateway\_portal\_certificate\_name](#input\_app\_gateway\_portal\_certificate\_name) | Application gateway developer portal certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_prf_certificate_name"></a> [app\_gateway\_prf\_certificate\_name](#input\_app\_gateway\_prf\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | `""` | no |
| <a name="input_app_gateway_sku_name"></a> [app\_gateway\_sku\_name](#input\_app\_gateway\_sku\_name) | The Name of the SKU to use for this Application Gateway. Possible values are Standard\_Small, Standard\_Medium, Standard\_Large, Standard\_v2, WAF\_Medium, WAF\_Large, and WAF\_v2 | `string` | n/a | yes |
| <a name="input_app_gateway_sku_tier"></a> [app\_gateway\_sku\_tier](#input\_app\_gateway\_sku\_tier) | The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard\_v2, WAF and WAF\_v2 | `string` | n/a | yes |
| <a name="input_app_gateway_upload_certificate_name"></a> [app\_gateway\_upload\_certificate\_name](#input\_app\_gateway\_upload\_certificate\_name) | Application gateway api certificate name on Key Vault ( 'upload' is used for heavy payload size) | `string` | n/a | yes |
| <a name="input_app_gateway_waf_enabled"></a> [app\_gateway\_waf\_enabled](#input\_app\_gateway\_waf\_enabled) | Enable waf | `bool` | `true` | no |
| <a name="input_app_gateway_wfespgovit_certificate_name"></a> [app\_gateway\_wfespgovit\_certificate\_name](#input\_app\_gateway\_wfespgovit\_certificate\_name) | Application gateway wfespgovit certificate name on Key Vault | `string` | `""` | no |
| <a name="input_app_gateway_wisp2_certificate_name"></a> [app\_gateway\_wisp2\_certificate\_name](#input\_app\_gateway\_wisp2\_certificate\_name) | Application gateway wisp2 certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_wisp2govit_certificate_name"></a> [app\_gateway\_wisp2govit\_certificate\_name](#input\_app\_gateway\_wisp2govit\_certificate\_name) | Application gateway wisp2govit certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_azdo_agent_vm_image_name"></a> [azdo\_agent\_vm\_image\_name](#input\_azdo\_agent\_vm\_image\_name) | (Required) Azure devops agent image name | `string` | n/a | yes |
| <a name="input_azuread_service_principal_azure_cdn_frontdoor_id"></a> [azuread\_service\_principal\_azure\_cdn\_frontdoor\_id](#input\_azuread\_service\_principal\_azure\_cdn\_frontdoor\_id) | Azure CDN Front Door Principal ID | `string` | `"f3b3f72f-4770-47a5-8c1e-aa298003be12"` | no |
| <a name="input_backup_storage_replication_type"></a> [backup\_storage\_replication\_type](#input\_backup\_storage\_replication\_type) | (Optional) Backup storage account replication type | `string` | `"GZRS"` | no |
| <a name="input_base_path_nodo_fatturazione"></a> [base\_path\_nodo\_fatturazione](#input\_base\_path\_nodo\_fatturazione) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_fatturazione_dev"></a> [base\_path\_nodo\_fatturazione\_dev](#input\_base\_path\_nodo\_fatturazione\_dev) | base nodo on cloud | `string` | `"/fatturazione-dev"` | no |
| <a name="input_base_path_nodo_oncloud"></a> [base\_path\_nodo\_oncloud](#input\_base\_path\_nodo\_oncloud) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_ppt_lmi"></a> [base\_path\_nodo\_ppt\_lmi](#input\_base\_path\_nodo\_ppt\_lmi) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_ppt_lmi_dev"></a> [base\_path\_nodo\_ppt\_lmi\_dev](#input\_base\_path\_nodo\_ppt\_lmi\_dev) | base nodo on cloud | `string` | `"/ppt-lmi-dev"` | no |
| <a name="input_base_path_nodo_sync"></a> [base\_path\_nodo\_sync](#input\_base\_path\_nodo\_sync) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_sync_dev"></a> [base\_path\_nodo\_sync\_dev](#input\_base\_path\_nodo\_sync\_dev) | base nodo on cloud | `string` | `"/sync-cron-dev/syncWisp"` | no |
| <a name="input_base_path_nodo_web_bo"></a> [base\_path\_nodo\_web\_bo](#input\_base\_path\_nodo\_web\_bo) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_web_bo_dev"></a> [base\_path\_nodo\_web\_bo\_dev](#input\_base\_path\_nodo\_web\_bo\_dev) | base nodo on cloud | `string` | `"/web-bo-dev"` | no |
| <a name="input_base_path_nodo_web_bo_history"></a> [base\_path\_nodo\_web\_bo\_history](#input\_base\_path\_nodo\_web\_bo\_history) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_web_bo_history_dev"></a> [base\_path\_nodo\_web\_bo\_history\_dev](#input\_base\_path\_nodo\_web\_bo\_history\_dev) | base nodo on cloud | `string` | `"/web-bo-history-dev"` | no |
| <a name="input_base_path_nodo_wfesp"></a> [base\_path\_nodo\_wfesp](#input\_base\_path\_nodo\_wfesp) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_wfesp_dev"></a> [base\_path\_nodo\_wfesp\_dev](#input\_base\_path\_nodo\_wfesp\_dev) | base nodo on cloud | `string` | `"/wfesp-dev"` | no |
| <a name="input_cdn_storage_account_replication_type"></a> [cdn\_storage\_account\_replication\_type](#input\_cdn\_storage\_account\_replication\_type) | (Optional) Cdn storage account replication type | `string` | `"GRS"` | no |
| <a name="input_checkout_enabled"></a> [checkout\_enabled](#input\_checkout\_enabled) | apim named values | `bool` | `true` | no |
| <a name="input_cidr_common_private_endpoint_snet"></a> [cidr\_common\_private\_endpoint\_snet](#input\_cidr\_common\_private\_endpoint\_snet) | Common Private Endpoint network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_apim"></a> [cidr\_subnet\_apim](#input\_cidr\_subnet\_apim) | (Required) APIM v2 subnet cidr | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_appgateway"></a> [cidr\_subnet\_appgateway](#input\_cidr\_subnet\_appgateway) | Application gateway address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_appgateway_integration"></a> [cidr\_subnet\_appgateway\_integration](#input\_cidr\_subnet\_appgateway\_integration) | Address prefixes subnet integration appgateway. | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_azdoa"></a> [cidr\_subnet\_azdoa](#input\_cidr\_subnet\_azdoa) | Azure DevOps agent network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_dns_forwarder"></a> [cidr\_subnet\_dns\_forwarder](#input\_cidr\_subnet\_dns\_forwarder) | DNS Forwarder network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_dns_forwarder_backup"></a> [cidr\_subnet\_dns\_forwarder\_backup](#input\_cidr\_subnet\_dns\_forwarder\_backup) | Address prefixes subnet dns forwarder backup. | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_eventhub"></a> [cidr\_subnet\_eventhub](#input\_cidr\_subnet\_eventhub) | Address prefixes subnet eventhub | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_loadtest_agent"></a> [cidr\_subnet\_loadtest\_agent](#input\_cidr\_subnet\_loadtest\_agent) | LoadTest Agent Pool address space | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_node_forwarder"></a> [cidr\_subnet\_node\_forwarder](#input\_cidr\_subnet\_node\_forwarder) | Address prefixes subnet node forwarder | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_redis"></a> [cidr\_subnet\_redis](#input\_cidr\_subnet\_redis) | Redis network address space. | `list(string)` | <pre>[<br/>  "10.1.163.0/24"<br/>]</pre> | no |
| <a name="input_cidr_subnet_tools_cae"></a> [cidr\_subnet\_tools\_cae](#input\_cidr\_subnet\_tools\_cae) | Tool container app env, network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_vpn"></a> [cidr\_subnet\_vpn](#input\_cidr\_subnet\_vpn) | VPN network address space. | `list(string)` | <pre>[<br/>  ""<br/>]</pre> | no |
| <a name="input_cidr_vnet"></a> [cidr\_vnet](#input\_cidr\_vnet) | Virtual network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_vnet_integration"></a> [cidr\_vnet\_integration](#input\_cidr\_vnet\_integration) | Virtual network to peer with sia subscription. It should host apim | `list(string)` | n/a | yes |
| <a name="input_cidr_vnet_italy"></a> [cidr\_vnet\_italy](#input\_cidr\_vnet\_italy) | Address prefixes for vnet in italy. | `list(string)` | n/a | yes |
| <a name="input_create_redis_multiaz"></a> [create\_redis\_multiaz](#input\_create\_redis\_multiaz) | (Optional) true if a multi az premium instance of redis is required | `bool` | `false` | no |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | Network | <pre>object({<br/>    id     = string<br/>    enable = bool<br/>  })</pre> | `null` | no |
| <a name="input_default_node_id"></a> [default\_node\_id](#input\_default\_node\_id) | Default NodeId according to default base url | `string` | n/a | yes |
| <a name="input_devops_agent_balance_zones"></a> [devops\_agent\_balance\_zones](#input\_devops\_agent\_balance\_zones) | (Optional) True if the devops agent instances must be evenly balanced between the configured zones | `bool` | `false` | no |
| <a name="input_devops_agent_zones"></a> [devops\_agent\_zones](#input\_devops\_agent\_zones) | (Optional) List of zones in which the scale set for azdo agent will be deployed | `list(number)` | `null` | no |
| <a name="input_dns_a_reconds_dbnodo_ips"></a> [dns\_a\_reconds\_dbnodo\_ips](#input\_dns\_a\_reconds\_dbnodo\_ips) | IPs address of DB Nodo | `list(string)` | `[]` | no |
| <a name="input_dns_a_reconds_dbnodo_ips_dr"></a> [dns\_a\_reconds\_dbnodo\_ips\_dr](#input\_dns\_a\_reconds\_dbnodo\_ips\_dr) | IPs address of DB Nodo DR | `list(string)` | `[]` | no |
| <a name="input_dns_a_reconds_dbnodo_prf_ips"></a> [dns\_a\_reconds\_dbnodo\_prf\_ips](#input\_dns\_a\_reconds\_dbnodo\_prf\_ips) | IPs address of DB Nodo | `list(string)` | `[]` | no |
| <a name="input_dns_a_reconds_dbnodonexipostgres_balancer_1_ips"></a> [dns\_a\_reconds\_dbnodonexipostgres\_balancer\_1\_ips](#input\_dns\_a\_reconds\_dbnodonexipostgres\_balancer\_1\_ips) | IPs address of DB Nodo PostgreSQL Nexi | `list(string)` | `[]` | no |
| <a name="input_dns_a_reconds_dbnodonexipostgres_balancer_2_ips"></a> [dns\_a\_reconds\_dbnodonexipostgres\_balancer\_2\_ips](#input\_dns\_a\_reconds\_dbnodonexipostgres\_balancer\_2\_ips) | IPs address of DB Nodo PostgreSQL Nexi | `list(string)` | `[]` | no |
| <a name="input_dns_a_reconds_dbnodonexipostgres_ips"></a> [dns\_a\_reconds\_dbnodonexipostgres\_ips](#input\_dns\_a\_reconds\_dbnodonexipostgres\_ips) | IPs address of DB Nodo PostgreSQL Nexi | `list(string)` | `[]` | no |
| <a name="input_dns_a_reconds_dbnodonexipostgres_prf_balancer_1_ips"></a> [dns\_a\_reconds\_dbnodonexipostgres\_prf\_balancer\_1\_ips](#input\_dns\_a\_reconds\_dbnodonexipostgres\_prf\_balancer\_1\_ips) | IPs address of DB Nodo PostgreSQL Nexi | `list(string)` | `[]` | no |
| <a name="input_dns_a_reconds_dbnodonexipostgres_prf_balancer_2_ips"></a> [dns\_a\_reconds\_dbnodonexipostgres\_prf\_balancer\_2\_ips](#input\_dns\_a\_reconds\_dbnodonexipostgres\_prf\_balancer\_2\_ips) | IPs address of DB Nodo PostgreSQL Nexi | `list(string)` | `[]` | no |
| <a name="input_dns_a_reconds_dbnodonexipostgres_prf_ips"></a> [dns\_a\_reconds\_dbnodonexipostgres\_prf\_ips](#input\_dns\_a\_reconds\_dbnodonexipostgres\_prf\_ips) | IPs address of DB Nodo PostgreSQL Nexi | `list(string)` | `[]` | no |
| <a name="input_dns_default_ttl_sec"></a> [dns\_default\_ttl\_sec](#input\_dns\_default\_ttl\_sec) | value | `number` | `3600` | no |
| <a name="input_dns_forwarder_vm_image_name"></a> [dns\_forwarder\_vm\_image\_name](#input\_dns\_forwarder\_vm\_image\_name) | Image name for dns forwarder | `string` | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix_prf"></a> [dns\_zone\_prefix\_prf](#input\_dns\_zone\_prefix\_prf) | The dns subdomain. | `string` | `""` | no |
| <a name="input_dns_zone_wfesp"></a> [dns\_zone\_wfesp](#input\_dns\_zone\_wfesp) | The wfesp dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_wisp2"></a> [dns\_zone\_wisp2](#input\_dns\_zone\_wisp2) | The wisp2 dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_ehns03_alerts_enabled"></a> [ehns03\_alerts\_enabled](#input\_ehns03\_alerts\_enabled) | Event hub 03 alerts enabled? | `bool` | `false` | no |
| <a name="input_ehns03_metric_alerts"></a> [ehns03\_metric\_alerts](#input\_ehns03\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br/>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br/>    aggregation = string<br/>    metric_name = string<br/>    description = string<br/>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br/>    operator  = string<br/>    threshold = number<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br/>    frequency = string<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br/>    window_size = string<br/><br/>    dimension = list(object(<br/>      {<br/>        name     = string<br/>        operator = string<br/>        values   = list(string)<br/>      }<br/>    ))<br/>  }))</pre> | `{}` | no |
| <a name="input_ehns04_alerts_enabled"></a> [ehns04\_alerts\_enabled](#input\_ehns04\_alerts\_enabled) | Event hub 04 alerts enabled? | `bool` | `false` | no |
| <a name="input_ehns04_metric_alerts"></a> [ehns04\_metric\_alerts](#input\_ehns04\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br/>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br/>    aggregation = string<br/>    metric_name = string<br/>    description = string<br/>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br/>    operator  = string<br/>    threshold = number<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br/>    frequency = string<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br/>    window_size = string<br/><br/>    dimension = list(object(<br/>      {<br/>        name     = string<br/>        operator = string<br/>        values   = list(string)<br/>      }<br/>    ))<br/>  }))</pre> | `{}` | no |
| <a name="input_ehns_auto_inflate_enabled"></a> [ehns\_auto\_inflate\_enabled](#input\_ehns\_auto\_inflate\_enabled) | Is Auto Inflate enabled for the EventHub Namespace? | `bool` | `false` | no |
| <a name="input_ehns_capacity"></a> [ehns\_capacity](#input\_ehns\_capacity) | Specifies the Capacity / Throughput Units for a Standard SKU namespace. | `number` | `null` | no |
| <a name="input_ehns_maximum_throughput_units"></a> [ehns\_maximum\_throughput\_units](#input\_ehns\_maximum\_throughput\_units) | Specifies the maximum number of throughput units when Auto Inflate is Enabled | `number` | `null` | no |
| <a name="input_ehns_public_network_access"></a> [ehns\_public\_network\_access](#input\_ehns\_public\_network\_access) | (Required) enables public network access to the event hubs | `bool` | n/a | yes |
| <a name="input_ehns_sku_name"></a> [ehns\_sku\_name](#input\_ehns\_sku\_name) | Defines which tier to use. | `string` | `"Standard"` | no |
| <a name="input_ehns_zone_redundant"></a> [ehns\_zone\_redundant](#input\_ehns\_zone\_redundant) | Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). | `bool` | `false` | no |
| <a name="input_enable_logos_backup"></a> [enable\_logos\_backup](#input\_enable\_logos\_backup) | (Optional) Enables nodo sftp storage account backup | `bool` | `true` | no |
| <a name="input_enable_node_forwarder_debug_instance"></a> [enable\_node\_forwarder\_debug\_instance](#input\_enable\_node\_forwarder\_debug\_instance) | Enable the creation of a separate 'debug' instance of node forwarder | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_eventhubs_03"></a> [eventhubs\_03](#input\_eventhubs\_03) | A list of event hubs to add to namespace. | <pre>list(object({<br/>    name              = string<br/>    partitions        = number<br/>    message_retention = number<br/>    consumers         = list(string)<br/>    keys = list(object({<br/>      name   = string<br/>      listen = bool<br/>      send   = bool<br/>      manage = bool<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_eventhubs_04"></a> [eventhubs\_04](#input\_eventhubs\_04) | A list of event hubs to add to namespace. | <pre>list(object({<br/>    name              = string<br/>    partitions        = number<br/>    message_retention = number<br/>    consumers         = list(string)<br/>    keys = list(object({<br/>      name   = string<br/>      listen = bool<br/>      send   = bool<br/>      manage = bool<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_eventhubs_prf"></a> [eventhubs\_prf](#input\_eventhubs\_prf) | A list of event hubs to add to namespace. | <pre>list(object({<br/>    name              = string<br/>    partitions        = number<br/>    message_retention = number<br/>    consumers         = list(string)<br/>    keys = list(object({<br/>      name   = string<br/>      listen = bool<br/>      send   = bool<br/>      manage = bool<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `"pagopa.it"` | no |
| <a name="input_geo_replica_cidr_vnet"></a> [geo\_replica\_cidr\_vnet](#input\_geo\_replica\_cidr\_vnet) | (Required) Cidr block for replica vnet address space | `list(string)` | `null` | no |
| <a name="input_geo_replica_ddos_protection_plan"></a> [geo\_replica\_ddos\_protection\_plan](#input\_geo\_replica\_ddos\_protection\_plan) | n/a | <pre>object({<br/>    id     = string<br/>    enable = bool<br/>  })</pre> | `null` | no |
| <a name="input_geo_replica_enabled"></a> [geo\_replica\_enabled](#input\_geo\_replica\_enabled) | (Optional) True if geo replica should be active for key data components i.e. PostgreSQL Flexible servers | `bool` | `false` | no |
| <a name="input_geo_replica_location"></a> [geo\_replica\_location](#input\_geo\_replica\_location) | (Optional) Location of the geo replica | `string` | `"northeurope"` | no |
| <a name="input_geo_replica_location_short"></a> [geo\_replica\_location\_short](#input\_geo\_replica\_location\_short) | (Optional) Short Location of the geo replica | `string` | `"neu"` | no |
| <a name="input_ingress_elk_load_balancer_ip"></a> [ingress\_elk\_load\_balancer\_ip](#input\_ingress\_elk\_load\_balancer\_ip) | n/a | `string` | `"10.1.100.251"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_integration_app_gateway_alerts_enabled"></a> [integration\_app\_gateway\_alerts\_enabled](#input\_integration\_app\_gateway\_alerts\_enabled) | Enable alerts | `bool` | `true` | no |
| <a name="input_integration_app_gateway_api_certificate_name"></a> [integration\_app\_gateway\_api\_certificate\_name](#input\_integration\_app\_gateway\_api\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_integration_app_gateway_management_certificate_name"></a> [integration\_app\_gateway\_management\_certificate\_name](#input\_integration\_app\_gateway\_management\_certificate\_name) | Application gateway api management certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_integration_app_gateway_max_capacity"></a> [integration\_app\_gateway\_max\_capacity](#input\_integration\_app\_gateway\_max\_capacity) | n/a | `number` | `2` | no |
| <a name="input_integration_app_gateway_min_capacity"></a> [integration\_app\_gateway\_min\_capacity](#input\_integration\_app\_gateway\_min\_capacity) | n/a | `number` | `0` | no |
| <a name="input_integration_app_gateway_portal_certificate_name"></a> [integration\_app\_gateway\_portal\_certificate\_name](#input\_integration\_app\_gateway\_portal\_certificate\_name) | Application gateway developer portal certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_integration_app_gateway_prf_certificate_name"></a> [integration\_app\_gateway\_prf\_certificate\_name](#input\_integration\_app\_gateway\_prf\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | `""` | no |
| <a name="input_integration_app_gateway_sku_name"></a> [integration\_app\_gateway\_sku\_name](#input\_integration\_app\_gateway\_sku\_name) | The Name of the SKU to use for this Application Gateway. Possible values are Standard\_Small, Standard\_Medium, Standard\_Large, Standard\_v2, WAF\_Medium, WAF\_Large, and WAF\_v2 | `string` | n/a | yes |
| <a name="input_integration_app_gateway_sku_tier"></a> [integration\_app\_gateway\_sku\_tier](#input\_integration\_app\_gateway\_sku\_tier) | The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard\_v2, WAF and WAF\_v2 | `string` | n/a | yes |
| <a name="input_integration_app_gateway_waf_enabled"></a> [integration\_app\_gateway\_waf\_enabled](#input\_integration\_app\_gateway\_waf\_enabled) | Enable waf | `bool` | `false` | no |
| <a name="input_integration_appgateway_private_ip"></a> [integration\_appgateway\_private\_ip](#input\_integration\_appgateway\_private\_ip) | Integration app gateway private ip | `string` | n/a | yes |
| <a name="input_integration_appgateway_zones"></a> [integration\_appgateway\_zones](#input\_integration\_appgateway\_zones) | Integration app gateway private ip | `list(number)` | n/a | yes |
| <a name="input_is_feature_enabled"></a> [is\_feature\_enabled](#input\_is\_feature\_enabled) | Features enabled in this domain | <pre>object({<br/>    vnet_ita                  = bool,<br/>    container_app_tools_cae   = optional(bool, false),<br/>    node_forwarder_ha_enabled = bool<br/>    vpn                       = optional(bool, false)<br/>    dns_forwarder_lb          = optional(bool, false)<br/>    postgres_private_dns      = bool<br/>    azdoa                     = optional(bool, true)<br/>    apim_core_import          = optional(bool, false)<br/>    use_new_apim              = optional(bool, false)<br/>    azdoa_extension           = optional(bool, false)<br/>  })</pre> | n/a | yes |
| <a name="input_law_daily_quota_gb"></a> [law\_daily\_quota\_gb](#input\_law\_daily\_quota\_gb) | The workspace daily quota for ingestion in GB. | `number` | `-1` | no |
| <a name="input_law_retention_in_days"></a> [law\_retention\_in\_days](#input\_law\_retention\_in\_days) | The workspace data retention in days | `number` | `30` | no |
| <a name="input_law_sku"></a> [law\_sku](#input\_law\_sku) | Sku of the Log Analytics Workspace | `string` | `"PerGB2018"` | no |
| <a name="input_lb_aks"></a> [lb\_aks](#input\_lb\_aks) | IP load balancer AKS Nexi/SIA | `string` | `"0.0.0.0"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_ita"></a> [location\_ita](#input\_location\_ita) | Main location | `string` | `"italynorth"` | no |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_short_ita"></a> [location\_short\_ita](#input\_location\_short\_ita) | Location short for italy: itn | `string` | `"itn"` | no |
| <a name="input_lock_enable"></a> [lock\_enable](#input\_lock\_enable) | Apply locks to block accedentaly deletions. | `bool` | `false` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_logos_backup_retention"></a> [logos\_backup\_retention](#input\_logos\_backup\_retention) | (Optional) Blob backup retention | `number` | `7` | no |
| <a name="input_logos_donations_storage_account_replication_type"></a> [logos\_donations\_storage\_account\_replication\_type](#input\_logos\_donations\_storage\_account\_replication\_type) | (Optional) Logos donations storage account replication type | `string` | `"LRS"` | no |
| <a name="input_monitor_env_test_urls"></a> [monitor\_env\_test\_urls](#input\_monitor\_env\_test\_urls) | (Optional) Environment specific standard web tests urls to be created in addition to locals.test\_urls | <pre>list(object({<br/>    host          = string<br/>    path          = string<br/>    alert_enabled = optional(bool, true)<br/>  }))</pre> | `[]` | no |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_nat_gateway_enabled"></a> [nat\_gateway\_enabled](#input\_nat\_gateway\_enabled) | Nat Gateway enabled | `bool` | `true` | no |
| <a name="input_nat_gateway_public_ips"></a> [nat\_gateway\_public\_ips](#input\_nat\_gateway\_public\_ips) | Number of public outbound ips | `number` | `1` | no |
| <a name="input_node_forwarder_always_on"></a> [node\_forwarder\_always\_on](#input\_node\_forwarder\_always\_on) | Node Forwarder always on property | `bool` | `true` | no |
| <a name="input_node_forwarder_autoscale_enabled"></a> [node\_forwarder\_autoscale\_enabled](#input\_node\_forwarder\_autoscale\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_node_forwarder_logging_level"></a> [node\_forwarder\_logging\_level](#input\_node\_forwarder\_logging\_level) | Logging level of Node Forwarder | `string` | `"INFO"` | no |
| <a name="input_node_forwarder_sku"></a> [node\_forwarder\_sku](#input\_node\_forwarder\_sku) | (Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1. | `string` | `"P3v3"` | no |
| <a name="input_node_forwarder_zone_balancing_enabled"></a> [node\_forwarder\_zone\_balancing\_enabled](#input\_node\_forwarder\_zone\_balancing\_enabled) | (Optional) enables the load balancing for node forwarder app service plan | `bool` | `true` | no |
| <a name="input_node_fw_dbg_snet_cidr"></a> [node\_fw\_dbg\_snet\_cidr](#input\_node\_fw\_dbg\_snet\_cidr) | (Required) node forwarder debug ha subnet cidr block | `list(string)` | `null` | no |
| <a name="input_node_fw_ha_snet_cidr"></a> [node\_fw\_ha\_snet\_cidr](#input\_node\_fw\_ha\_snet\_cidr) | (Required) node forwarder ha subnet cidr block | `list(string)` | `null` | no |
| <a name="input_nodo_pagamenti_ec"></a> [nodo\_pagamenti\_ec](#input\_nodo\_pagamenti\_ec) | EC' black list nodo pagamenti (separate comma list). | `string` | `","` | no |
| <a name="input_nodo_pagamenti_psp"></a> [nodo\_pagamenti\_psp](#input\_nodo\_pagamenti\_psp) | PSP' white list nodo pagamenti (separate comma list) . | `string` | `","` | no |
| <a name="input_platform_private_dns_zone_records"></a> [platform\_private\_dns\_zone\_records](#input\_platform\_private\_dns\_zone\_records) | List of records to add into the platform.pagopa.it dns private | `list(string)` | <pre>[<br/>  "api",<br/>  "portal",<br/>  "management"<br/>]</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_private_dns_zone_db_nodo_pagamenti"></a> [private\_dns\_zone\_db\_nodo\_pagamenti](#input\_private\_dns\_zone\_db\_nodo\_pagamenti) | n/a | `string` | `"dev.db-nodo-pagamenti.com"` | no |
| <a name="input_redis_cache_enabled"></a> [redis\_cache\_enabled](#input\_redis\_cache\_enabled) | redis cache enabled | `bool` | `false` | no |
| <a name="input_redis_cache_params"></a> [redis\_cache\_params](#input\_redis\_cache\_params) | # Redis cache | <pre>object({<br/>    public_access = bool<br/>    capacity      = number<br/>    sku_name      = string<br/>    family        = string<br/>  })</pre> | <pre>{<br/>  "capacity": 1,<br/>  "family": "C",<br/>  "public_access": false,<br/>  "sku_name": "Basic"<br/>}</pre> | no |
| <a name="input_redis_private_endpoint_enabled"></a> [redis\_private\_endpoint\_enabled](#input\_redis\_private\_endpoint\_enabled) | Enable private endpoints for redis instances? | `bool` | `true` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | The version of Redis to use: 4 (deprecated) or 6 | `string` | `"6"` | no |
| <a name="input_redis_zones"></a> [redis\_zones](#input\_redis\_zones) | (Optional) Zone list where redis will be deployed | `list(string)` | <pre>[<br/>  "1"<br/>]</pre> | no |
| <a name="input_route_table_peering_sia_additional_routes"></a> [route\_table\_peering\_sia\_additional\_routes](#input\_route\_table\_peering\_sia\_additional\_routes) | (Optional) additional routes for route table peering sia | <pre>list(object({<br/>    address_prefix         = string<br/>    name                   = string<br/>    next_hop_in_ip_address = string<br/>    next_hop_type          = string<br/>    }<br/>  ))</pre> | `[]` | no |
| <a name="input_route_tools"></a> [route\_tools](#input\_route\_tools) | AKS routing table | <pre>list(object({<br/>    name                   = string<br/>    address_prefix         = string<br/>    next_hop_type          = string<br/>    next_hop_in_ip_address = string<br/>  }))</pre> | n/a | yes |
| <a name="input_schema_ip_nexi"></a> [schema\_ip\_nexi](#input\_schema\_ip\_nexi) | Nodo Pagamenti Nexi schema://ip | `string` | n/a | yes |
| <a name="input_storage_queue_private_endpoint_enabled"></a> [storage\_queue\_private\_endpoint\_enabled](#input\_storage\_queue\_private\_endpoint\_enabled) | Whether private endpoint for Azure Storage Queues is enabled | `bool` | `true` | no |
| <a name="input_upload_endpoint_enabled"></a> [upload\_endpoint\_enabled](#input\_upload\_endpoint\_enabled) | Enable upload for heavy payload size on appgw | `bool` | `true` | no |
| <a name="input_vnet_ita_ddos_protection_plan"></a> [vnet\_ita\_ddos\_protection\_plan](#input\_vnet\_ita\_ddos\_protection\_plan) | n/a | <pre>object({<br/>    id     = string<br/>    enable = bool<br/>  })</pre> | `null` | no |
| <a name="input_vpn_gw_pip_allocation_method"></a> [vpn\_gw\_pip\_allocation\_method](#input\_vpn\_gw\_pip\_allocation\_method) | VPN GW PIP ALLOCATION METHOD | `string` | `"Dynamic"` | no |
| <a name="input_vpn_gw_pip_sku"></a> [vpn\_gw\_pip\_sku](#input\_vpn\_gw\_pip\_sku) | VPN GW PIP SKU | `string` | `"Basic"` | no |
| <a name="input_vpn_random_specials_char"></a> [vpn\_random\_specials\_char](#input\_vpn\_random\_specials\_char) | Enable random special characters in VPN gateway's pip name | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
