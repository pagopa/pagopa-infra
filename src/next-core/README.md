<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
| <a name="module_apimv2"></a> [apimv2](#module\_apimv2) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management | v7.67.1 |
| <a name="module_apimv2_snet"></a> [apimv2\_snet](#module\_apimv2\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.0 |
| <a name="module_app_gw_integration"></a> [app\_gw\_integration](#module\_app\_gw\_integration) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_gateway | v7.50.0 |
| <a name="module_dns_forwarder_backup_snet"></a> [dns\_forwarder\_backup\_snet](#module\_dns\_forwarder\_backup\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.76.0 |
| <a name="module_dns_forwarder_backup_vmss_li"></a> [dns\_forwarder\_backup\_vmss\_li](#module\_dns\_forwarder\_backup\_vmss\_li) | git::https://github.com/pagopa/terraform-azurerm-v3.git//dns_forwarder_scale_set_vm | v7.76.0 |
| <a name="module_domain_key_vault_secrets_query"></a> [domain\_key\_vault\_secrets\_query](#module\_domain\_key\_vault\_secrets\_query) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v7.50.0 |
| <a name="module_event_hub03"></a> [event\_hub03](#module\_event\_hub03) | git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub | v7.62.0 |
| <a name="module_event_hub04"></a> [event\_hub04](#module\_event\_hub04) | git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub | v7.62.0 |
| <a name="module_integration_appgateway_snet"></a> [integration\_appgateway\_snet](#module\_integration\_appgateway\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.0 |
| <a name="module_logos_donation_flows_sa"></a> [logos\_donation\_flows\_sa](#module\_logos\_donation\_flows\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.50.0 |
| <a name="module_monitor"></a> [monitor](#module\_monitor) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_node_forwarder_app_service"></a> [node\_forwarder\_app\_service](#module\_node\_forwarder\_app\_service) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service | v7.69.1 |
| <a name="module_node_forwarder_slot_staging"></a> [node\_forwarder\_slot\_staging](#module\_node\_forwarder\_slot\_staging) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot | v7.60.0 |
| <a name="module_redis"></a> [redis](#module\_redis) | git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache | v7.50.0 |
| <a name="module_vnet_peering"></a> [vnet\_peering](#module\_vnet\_peering) | git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering | v7.62.0 |
| <a name="module_vnet_replica"></a> [vnet\_replica](#module\_vnet\_replica) | git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network | v7.62.0 |
| <a name="module_vpn"></a> [vpn](#module\_vpn) | git::https://github.com/pagopa/terraform-azurerm-v3.git//vpn_gateway | v7.76.0 |
| <a name="module_vpn_snet"></a> [vpn\_snet](#module\_vpn\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.76.0 |

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
| [azurerm_api_management_group.payment_manager](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.pda](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.piattaforma_notifiche](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.readonly](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_named_value.aks_lb_nexi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
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
| [azurerm_api_management_named_value.fdrcontainername](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.fdrsaname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ip_nodo_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_buyerbanks_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_buyerbanks_url_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_checkout_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_checkout_url_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_mock_services_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.password_pm_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pm_gtw_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pm_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pm_host_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pm_onprem_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.schema_ip_nexi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.schema_ip_nodo_pagopa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.urlnodo_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.user_pm_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.verificatore_api_key_apiconfig](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp2_gov_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp2_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_redis_cache.apimv2_external_cache_redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_redis_cache) | resource |
| [azurerm_container_app_environment.tools_cae](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment) | resource |
| [azurerm_key_vault_access_policy.api_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_gateway_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_monitor_autoscale_setting.node_forwarder_app_service_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_metric_alert.app_service_over_cpu_usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.app_service_over_mem_usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_network_security_group.apimv2_snet_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.apimv2_snet_nsg_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_private_dns_zone.private_db_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.private_db_zone_to_core_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.apimv2_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.integration_appgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.tools_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.data_contributor_role_donations](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_blob.donation_logo10](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.donation_logo7](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.donation_logo8](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.donation_logo9](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_container.donation_logo10](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.donation_logo7](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.donation_logo8](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.donation_logo9](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_subnet.tools_cae_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.apim_stv2_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.rt_sia_for_apim_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.rt_sia_for_appgw_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_user_assigned_identity.appgateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [null_resource.change_auth_donations_blob_container_logo10](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [null_resource.change_auth_donations_blob_container_logo7](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [null_resource.change_auth_donations_blob_container_logo8](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [null_resource.change_auth_donations_blob_container_logo9](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [azuread_application.vpn_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_key_vault.kv_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_certificate.app_gw_platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.app_gw_platform_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.management_platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.portal_platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_secret.apim_publisher_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.certificate_crt_node_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.certificate_key_node_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.checkout_v2_test_key_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_buyerbanks_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_checkout_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.google_recaptcha_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.mock_services_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.password_pm_test_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_gtw_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_host_prf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_onprem_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.user_pm_test_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.verificatore_key_secret_apiconfig](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.new_conn_srv_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_redis_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_redis_cache.redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/redis_cache) | data source |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_route_table.rt_sia](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/route_table) | data source |
| [azurerm_storage_account.fdr_flows_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_container.fdr_rend_flow](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_container) | data source |
| [azurerm_subnet.apim_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.eventhub_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.node_forwarder_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.redis_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_enable_nm3_decoupler_switch"></a> [apim\_enable\_nm3\_decoupler\_switch](#input\_apim\_enable\_nm3\_decoupler\_switch) | Enable switch backend address in NM3 algorithm logic | `bool` | `false` | no |
| <a name="input_apim_enable_routing_decoupler_switch"></a> [apim\_enable\_routing\_decoupler\_switch](#input\_apim\_enable\_routing\_decoupler\_switch) | Enable switch backend address in Routing algorithm logic | `bool` | `false` | no |
| <a name="input_apim_v2_alerts_enabled"></a> [apim\_v2\_alerts\_enabled](#input\_apim\_v2\_alerts\_enabled) | Enable alerts | `bool` | `true` | no |
| <a name="input_apim_v2_autoscale"></a> [apim\_v2\_autoscale](#input\_apim\_v2\_autoscale) | Configure Apim autoscale on capacity metric | <pre>object(<br>    {<br>      enabled                       = bool<br>      default_instances             = number<br>      minimum_instances             = number<br>      maximum_instances             = number<br>      scale_out_capacity_percentage = number<br>      scale_out_time_window         = string<br>      scale_out_value               = string<br>      scale_out_cooldown            = string<br>      scale_in_capacity_percentage  = number<br>      scale_in_time_window          = string<br>      scale_in_value                = string<br>      scale_in_cooldown             = string<br>    }<br>  )</pre> | <pre>{<br>  "default_instances": 1,<br>  "enabled": false,<br>  "maximum_instances": 5,<br>  "minimum_instances": 1,<br>  "scale_in_capacity_percentage": 30,<br>  "scale_in_cooldown": "PT30M",<br>  "scale_in_time_window": "PT30M",<br>  "scale_in_value": "1",<br>  "scale_out_capacity_percentage": 60,<br>  "scale_out_cooldown": "PT45M",<br>  "scale_out_time_window": "PT10M",<br>  "scale_out_value": "2"<br>}</pre> | no |
| <a name="input_apim_v2_publisher_name"></a> [apim\_v2\_publisher\_name](#input\_apim\_v2\_publisher\_name) | n/a | `string` | n/a | yes |
| <a name="input_apim_v2_sku"></a> [apim\_v2\_sku](#input\_apim\_v2\_sku) | n/a | `string` | n/a | yes |
| <a name="input_apim_v2_subnet_nsg_security_rules"></a> [apim\_v2\_subnet\_nsg\_security\_rules](#input\_apim\_v2\_subnet\_nsg\_security\_rules) | Network security rules for APIM subnet | `list(any)` | n/a | yes |
| <a name="input_apim_v2_zones"></a> [apim\_v2\_zones](#input\_apim\_v2\_zones) | (Optional) Zones in which the apim will be deployed | `list(string)` | <pre>[<br>  "1"<br>]</pre> | no |
| <a name="input_app_gateway_alerts_enabled"></a> [app\_gateway\_alerts\_enabled](#input\_app\_gateway\_alerts\_enabled) | Enable alerts | `bool` | `true` | no |
| <a name="input_app_gateway_api_certificate_name"></a> [app\_gateway\_api\_certificate\_name](#input\_app\_gateway\_api\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_management_certificate_name"></a> [app\_gateway\_management\_certificate\_name](#input\_app\_gateway\_management\_certificate\_name) | Application gateway api management certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_max_capacity"></a> [app\_gateway\_max\_capacity](#input\_app\_gateway\_max\_capacity) | n/a | `number` | `2` | no |
| <a name="input_app_gateway_min_capacity"></a> [app\_gateway\_min\_capacity](#input\_app\_gateway\_min\_capacity) | n/a | `number` | `0` | no |
| <a name="input_app_gateway_portal_certificate_name"></a> [app\_gateway\_portal\_certificate\_name](#input\_app\_gateway\_portal\_certificate\_name) | Application gateway developer portal certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_prf_certificate_name"></a> [app\_gateway\_prf\_certificate\_name](#input\_app\_gateway\_prf\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | `""` | no |
| <a name="input_app_gateway_sku_name"></a> [app\_gateway\_sku\_name](#input\_app\_gateway\_sku\_name) | The Name of the SKU to use for this Application Gateway. Possible values are Standard\_Small, Standard\_Medium, Standard\_Large, Standard\_v2, WAF\_Medium, WAF\_Large, and WAF\_v2 | `string` | n/a | yes |
| <a name="input_app_gateway_sku_tier"></a> [app\_gateway\_sku\_tier](#input\_app\_gateway\_sku\_tier) | The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard\_v2, WAF and WAF\_v2 | `string` | n/a | yes |
| <a name="input_app_gateway_waf_enabled"></a> [app\_gateway\_waf\_enabled](#input\_app\_gateway\_waf\_enabled) | Enable waf | `bool` | `false` | no |
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
| <a name="input_checkout_enabled"></a> [checkout\_enabled](#input\_checkout\_enabled) | apim named values | `bool` | `true` | no |
| <a name="input_cidr_subnet_apim"></a> [cidr\_subnet\_apim](#input\_cidr\_subnet\_apim) | (Required) APIM v2 subnet cidr | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_appgateway_integration"></a> [cidr\_subnet\_appgateway\_integration](#input\_cidr\_subnet\_appgateway\_integration) | Address prefixes subnet integration appgateway. | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_dns_forwarder_backup"></a> [cidr\_subnet\_dns\_forwarder\_backup](#input\_cidr\_subnet\_dns\_forwarder\_backup) | Address prefixes subnet dns forwarder backup. | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_tools_cae"></a> [cidr\_subnet\_tools\_cae](#input\_cidr\_subnet\_tools\_cae) | Tool container app env, network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_vpn"></a> [cidr\_subnet\_vpn](#input\_cidr\_subnet\_vpn) | VPN network address space. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_cidr_vnet_italy"></a> [cidr\_vnet\_italy](#input\_cidr\_vnet\_italy) | Address prefixes for vnet in italy. | `list(string)` | n/a | yes |
| <a name="input_create_redis_multiaz"></a> [create\_redis\_multiaz](#input\_create\_redis\_multiaz) | (Optional) true if a multi az premium instance of redis is required | `bool` | `false` | no |
| <a name="input_default_node_id"></a> [default\_node\_id](#input\_default\_node\_id) | Default NodeId according to default base url | `string` | n/a | yes |
| <a name="input_dns_forwarder_vm_image_name"></a> [dns\_forwarder\_vm\_image\_name](#input\_dns\_forwarder\_vm\_image\_name) | Image name for dns forwarder | `string` | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix_prf"></a> [dns\_zone\_prefix\_prf](#input\_dns\_zone\_prefix\_prf) | The dns subdomain. | `string` | `""` | no |
| <a name="input_dns_zone_wisp2"></a> [dns\_zone\_wisp2](#input\_dns\_zone\_wisp2) | The wisp2 dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_ehns_alerts_enabled"></a> [ehns\_alerts\_enabled](#input\_ehns\_alerts\_enabled) | Event hub alerts enabled? | `bool` | `false` | no |
| <a name="input_ehns_auto_inflate_enabled"></a> [ehns\_auto\_inflate\_enabled](#input\_ehns\_auto\_inflate\_enabled) | Is Auto Inflate enabled for the EventHub Namespace? | `bool` | `false` | no |
| <a name="input_ehns_capacity"></a> [ehns\_capacity](#input\_ehns\_capacity) | Specifies the Capacity / Throughput Units for a Standard SKU namespace. | `number` | `null` | no |
| <a name="input_ehns_maximum_throughput_units"></a> [ehns\_maximum\_throughput\_units](#input\_ehns\_maximum\_throughput\_units) | Specifies the maximum number of throughput units when Auto Inflate is Enabled | `number` | `null` | no |
| <a name="input_ehns_metric_alerts"></a> [ehns\_metric\_alerts](#input\_ehns\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    metric_name = string<br>    description = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br>    frequency = string<br>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br>    window_size = string<br><br>    dimension = list(object(<br>      {<br>        name     = string<br>        operator = string<br>        values   = list(string)<br>      }<br>    ))<br>  }))</pre> | `{}` | no |
| <a name="input_ehns_public_network_access"></a> [ehns\_public\_network\_access](#input\_ehns\_public\_network\_access) | (Required) enables public network access to the event hubs | `bool` | n/a | yes |
| <a name="input_ehns_sku_name"></a> [ehns\_sku\_name](#input\_ehns\_sku\_name) | Defines which tier to use. | `string` | `"Standard"` | no |
| <a name="input_ehns_zone_redundant"></a> [ehns\_zone\_redundant](#input\_ehns\_zone\_redundant) | Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). | `bool` | `false` | no |
| <a name="input_enable_logos_backup"></a> [enable\_logos\_backup](#input\_enable\_logos\_backup) | (Optional) Enables nodo sftp storage account backup | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_eventhubs_03"></a> [eventhubs\_03](#input\_eventhubs\_03) | A list of event hubs to add to namespace. | <pre>list(object({<br>    name              = string<br>    partitions        = number<br>    message_retention = number<br>    consumers         = list(string)<br>    keys = list(object({<br>      name   = string<br>      listen = bool<br>      send   = bool<br>      manage = bool<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_eventhubs_04"></a> [eventhubs\_04](#input\_eventhubs\_04) | A list of event hubs to add to namespace. | <pre>list(object({<br>    name              = string<br>    partitions        = number<br>    message_retention = number<br>    consumers         = list(string)<br>    keys = list(object({<br>      name   = string<br>      listen = bool<br>      send   = bool<br>      manage = bool<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `"pagopa.it"` | no |
| <a name="input_geo_replica_cidr_vnet"></a> [geo\_replica\_cidr\_vnet](#input\_geo\_replica\_cidr\_vnet) | (Required) Cidr block for replica vnet address space | `list(string)` | `null` | no |
| <a name="input_geo_replica_ddos_protection_plan"></a> [geo\_replica\_ddos\_protection\_plan](#input\_geo\_replica\_ddos\_protection\_plan) | n/a | <pre>object({<br>    id     = string<br>    enable = bool<br>  })</pre> | `null` | no |
| <a name="input_geo_replica_enabled"></a> [geo\_replica\_enabled](#input\_geo\_replica\_enabled) | (Optional) True if geo replica should be active for key data components i.e. PostgreSQL Flexible servers | `bool` | `false` | no |
| <a name="input_geo_replica_location"></a> [geo\_replica\_location](#input\_geo\_replica\_location) | (Optional) Location of the geo replica | `string` | `"northeurope"` | no |
| <a name="input_geo_replica_location_short"></a> [geo\_replica\_location\_short](#input\_geo\_replica\_location\_short) | (Optional) Short Location of the geo replica | `string` | `"neu"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_integration_appgateway_private_ip"></a> [integration\_appgateway\_private\_ip](#input\_integration\_appgateway\_private\_ip) | Integration app gateway private ip | `string` | n/a | yes |
| <a name="input_integration_appgateway_zones"></a> [integration\_appgateway\_zones](#input\_integration\_appgateway\_zones) | Integration app gateway private ip | `list(number)` | n/a | yes |
| <a name="input_ip_nodo"></a> [ip\_nodo](#input\_ip\_nodo) | Nodo pagamenti ip | `string` | n/a | yes |
| <a name="input_is_feature_enabled"></a> [is\_feature\_enabled](#input\_is\_feature\_enabled) | Features enabled in this domain | <pre>object({<br>    vnet_ita                  = bool,<br>    container_app_tools_cae   = optional(bool, false),<br>    node_forwarder_ha_enabled = bool<br>    vpn                       = optional(bool, false)<br>    dns_forwarder_lb          = optional(bool, false)<br>    postgres_private_dns      = bool<br>  })</pre> | n/a | yes |
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
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_node_forwarder_always_on"></a> [node\_forwarder\_always\_on](#input\_node\_forwarder\_always\_on) | Node Forwarder always on property | `bool` | `true` | no |
| <a name="input_node_forwarder_autoscale_enabled"></a> [node\_forwarder\_autoscale\_enabled](#input\_node\_forwarder\_autoscale\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_node_forwarder_logging_level"></a> [node\_forwarder\_logging\_level](#input\_node\_forwarder\_logging\_level) | Logging level of Node Forwarder | `string` | `"INFO"` | no |
| <a name="input_node_forwarder_sku"></a> [node\_forwarder\_sku](#input\_node\_forwarder\_sku) | (Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1. | `string` | `"P3v3"` | no |
| <a name="input_node_forwarder_zone_balancing_enabled"></a> [node\_forwarder\_zone\_balancing\_enabled](#input\_node\_forwarder\_zone\_balancing\_enabled) | (Optional) enables the load balancing for node forwarder app service plan | `bool` | `true` | no |
| <a name="input_nodo_pagamenti_ec"></a> [nodo\_pagamenti\_ec](#input\_nodo\_pagamenti\_ec) | EC' black list nodo pagamenti (separate comma list). | `string` | `","` | no |
| <a name="input_nodo_pagamenti_psp"></a> [nodo\_pagamenti\_psp](#input\_nodo\_pagamenti\_psp) | PSP' white list nodo pagamenti (separate comma list) . | `string` | `","` | no |
| <a name="input_nodo_pagamenti_url"></a> [nodo\_pagamenti\_url](#input\_nodo\_pagamenti\_url) | Nodo pagamenti url | `string` | `"https://"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_redis_cache_enabled"></a> [redis\_cache\_enabled](#input\_redis\_cache\_enabled) | redis cache enabled | `bool` | `false` | no |
| <a name="input_redis_cache_params"></a> [redis\_cache\_params](#input\_redis\_cache\_params) | # Redis cache | <pre>object({<br>    public_access = bool<br>    capacity      = number<br>    sku_name      = string<br>    family        = string<br>  })</pre> | <pre>{<br>  "capacity": 1,<br>  "family": "C",<br>  "public_access": false,<br>  "sku_name": "Basic"<br>}</pre> | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | The version of Redis to use: 4 (deprecated) or 6 | `string` | `"6"` | no |
| <a name="input_redis_zones"></a> [redis\_zones](#input\_redis\_zones) | (Optional) Zone list where redis will be deployed | `list(string)` | <pre>[<br>  "1"<br>]</pre> | no |
| <a name="input_schema_ip_nexi"></a> [schema\_ip\_nexi](#input\_schema\_ip\_nexi) | Nodo Pagamenti Nexi schema://ip | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_vnet_ita_ddos_protection_plan"></a> [vnet\_ita\_ddos\_protection\_plan](#input\_vnet\_ita\_ddos\_protection\_plan) | n/a | <pre>object({<br>    id     = string<br>    enable = bool<br>  })</pre> | `null` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
