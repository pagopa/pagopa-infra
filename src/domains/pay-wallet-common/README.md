# payment-wallet-common

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 3.0.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | > 4.0.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.3.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v4__"></a> [\_\_v4\_\_](#module\_\_\_v4\_\_) | git::https://github.com/pagopa/terraform-azurerm-v4 | 7e40a22 |
| <a name="module_cosmosdb_account_mongodb"></a> [cosmosdb\_account\_mongodb](#module\_cosmosdb\_account\_mongodb) | ./.terraform/modules/__v4__/cosmosdb_account | n/a |
| <a name="module_cosmosdb_pay_wallet_collections"></a> [cosmosdb\_pay\_wallet\_collections](#module\_cosmosdb\_pay\_wallet\_collections) | ./.terraform/modules/__v4__/cosmosdb_mongodb_collection | n/a |
| <a name="module_cosmosdb_pay_wallet_snet"></a> [cosmosdb\_pay\_wallet\_snet](#module\_cosmosdb\_pay\_wallet\_snet) | ./.terraform/modules/__v4__/subnet | n/a |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ./.terraform/modules/__v4__/key_vault | n/a |
| <a name="module_pagopa_pay_wallet_redis_std"></a> [pagopa\_pay\_wallet\_redis\_std](#module\_pagopa\_pay\_wallet\_redis\_std) | ./.terraform/modules/__v4__/redis_cache | n/a |
| <a name="module_pay_wallet_storage"></a> [pay\_wallet\_storage](#module\_pay\_wallet\_storage) | ./.terraform/modules/__v4__/storage_account | n/a |
| <a name="module_redis_pagopa_pay_wallet_snet"></a> [redis\_pagopa\_pay\_wallet\_snet](#module\_redis\_pagopa\_pay\_wallet\_snet) | ./.terraform/modules/__v4__/subnet | n/a |
| <a name="module_redis_spoke_pay_wallet_snet"></a> [redis\_spoke\_pay\_wallet\_snet](#module\_redis\_spoke\_pay\_wallet\_snet) | ./.terraform/modules/__v4__/IDH/subnet | n/a |
| <a name="module_storage_pay_wallet_snet"></a> [storage\_pay\_wallet\_snet](#module\_storage\_pay\_wallet\_snet) | ./.terraform/modules/__v4__/subnet | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_wallet_fe_cdn"></a> [wallet\_fe\_cdn](#module\_wallet\_fe\_cdn) | ./.terraform/modules/__v4__/cdn | n/a |
| <a name="module_wallet_fe_web_test"></a> [wallet\_fe\_web\_test](#module\_wallet\_fe\_web\_test) | ./.terraform/modules/__v4__/application_insights_standard_web_test | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v4__/kubernetes_workload_identity_init | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_mongo_database.pay_wallet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_dns_caa_record.payment_wallet_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_ns_record.dev_payment_wallet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.uat_payment_wallet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_zone.payment_wallet_public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.cdn_wallet_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_certificate.pay-wallet-jwt-token-issuer-certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |
| [azurerm_key_vault_certificate.pay-wallet-jwt-token-issuer-certificate-ec](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |
| [azurerm_key_vault_secret.ai_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.elastic_otel_token_header](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.migration_wallet_token_test_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.mongo_wallet_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.npg_notifications_jwt_secret_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.npg_service_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pay_wallet_event_dispatcher_service_primary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pay_wallet_event_dispatcher_service_secondary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pay_wallet_jwt_issuer_service_active_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pay_wallet_jwt_issuer_service_primary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pay_wallet_jwt_issuer_service_secondary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.payment-method-api-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.payment_wallet_gha_bot_pat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.payment_wallet_opsgenie_webhook_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.payment_wallet_service_active_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.payment_wallet_service_primary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.payment_wallet_service_secondary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.paypal_psp_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.personal-data-vault-api-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.receiver_evt_rx_event_hub_connection_string_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_std_wallet_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.sender_evt_tx_event_hub_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.sender_evt_tx_event_hub_connection_string_soak_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.sender_evt_tx_event_hub_connection_string_staging](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.wallet-jwt-signing-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.wallet-token-test-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.wallet_migration_api_key_test_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.wallet_migration_cstar_api_key_test_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.wallet_storage_account_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.wallet_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_kubernetes_cluster_node_pool.user_nodepool_pay_wallet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_monitor_action_group.payment_wallet_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_diagnostic_setting.pay_wallet_queue_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_metric_alert.cosmos_db_provisioned_throughput_ru_exceeded_write_region](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.queue_storage_account_average_message_count](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.redis_std_cache_used_memory_exceeded](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pay_wallet_enqueue_rate_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pay_wallet_enqueue_rate_alert_visibility_timeout_diff](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.payment_wallet_for_ecommerce_availability_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.payment_wallet_for_io_availability_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.payment_wallet_for_webview_availability_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.payment_wallet_npg_notifications_availability_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.payment_wallet_outcomes_availability_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_portal_dashboard.pay_wallet_onboarding_monitoring_dashboard](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/portal_dashboard) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_endpoint.redis_data_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.storage_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.cosmosdb_pay_wallet_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.redis_std_pay_wallet_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_payment_wallet_alerts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.storage_pay_wallet_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.wallet_fe_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_queue.pay_wallet_cdc_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.pay_wallet_cdc_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.pay_wallet_logged_action_dead_letter_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.pay_wallet_logged_action_dead_letter_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.pay_wallet_wallet_expiration_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.pay_wallet_wallet_expiration_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_subnet.pay_wallet_user_aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [random_password.pay_wallet_event_dispatcher_service_primary_api_key_pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.pay_wallet_event_dispatcher_service_secondary_api_key_pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.pay_wallet_jwt_issuer_service_primary_api_key_pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.pay_wallet_jwt_issuer_service_secondary_api_key_pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.payment_wallet_service_primary_api_key_pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.payment_wallet_service_secondary_api_key_pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_application_insights.application_insights_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_eventhub_authorization_rule.receiver_evt_rx_event_hub_connection_string_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.sender_evt_tx_event_hub_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.sender_evt_tx_event_hub_connection_string_soak_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.sender_evt_tx_event_hub_connection_string_staging](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_key_vault_secret.monitor_payment_wallet_opsgenie_webhook_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_blob_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_queue_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_table_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_italy_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.vpn_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.iac_federated_azdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_user_node_pool"></a> [aks\_user\_node\_pool](#input\_aks\_user\_node\_pool) | AKS node pool user configuration | <pre>object({<br/>    enabled                    = optional(bool, true),<br/>    name                       = string,<br/>    vm_size                    = string,<br/>    os_disk_type               = string,<br/>    os_disk_size_gb            = string,<br/>    node_count_min             = number,<br/>    node_count_max             = number,<br/>    node_labels                = map(any),<br/>    node_taints                = list(string),<br/>    node_tags                  = map(any),<br/>    ultra_ssd_enabled          = optional(bool, false),<br/>    enable_host_encryption     = optional(bool, true),<br/>    max_pods                   = optional(number, 250),<br/>    upgrade_settings_max_surge = optional(string, "30%"),<br/>    zones                      = optional(list(any), [1, 2, 3]),<br/>  })</pre> | n/a | yes |
| <a name="input_cdn_location"></a> [cdn\_location](#input\_cdn\_location) | n/a | `string` | n/a | yes |
| <a name="input_cidr_subnet_cosmosdb_pay_wallet"></a> [cidr\_subnet\_cosmosdb\_pay\_wallet](#input\_cidr\_subnet\_cosmosdb\_pay\_wallet) | Cosmos DB address space for wallet. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_pay_wallet_user_aks"></a> [cidr\_subnet\_pay\_wallet\_user\_aks](#input\_cidr\_subnet\_pay\_wallet\_user\_aks) | AKS user address space for pagoPA pay-wallet. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_redis_pay_wallet"></a> [cidr\_subnet\_redis\_pay\_wallet](#input\_cidr\_subnet\_redis\_pay\_wallet) | Redis DB address space for wallet. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_storage_pay_wallet"></a> [cidr\_subnet\_storage\_pay\_wallet](#input\_cidr\_subnet\_storage\_pay\_wallet) | Azure storage DB address space for pagoPA wallet. | `list(string)` | n/a | yes |
| <a name="input_cosmos_mongo_db_params"></a> [cosmos\_mongo\_db\_params](#input\_cosmos\_mongo\_db\_params) | n/a | <pre>object({<br/>    capabilities   = list(string)<br/>    offer_type     = string<br/>    server_version = string<br/>    kind           = string<br/>    consistency_policy = object({<br/>      consistency_level       = string<br/>      max_interval_in_seconds = number<br/>      max_staleness_prefix    = number<br/>    })<br/>    enable_free_tier                 = bool<br/>    main_geo_location_zone_redundant = bool<br/>    additional_geo_locations = list(object({<br/>      location          = string<br/>      failover_priority = number<br/>      zone_redundant    = bool<br/>    }))<br/>    private_endpoint_enabled                     = bool<br/>    public_network_access_enabled                = bool<br/>    is_virtual_network_filter_enabled            = bool<br/>    backup_continuous_enabled                    = bool<br/>    ip_range_filter                              = list(string)<br/>    enable_provisioned_throughput_exceeded_alert = bool<br/>  })</pre> | n/a | yes |
| <a name="input_cosmos_mongo_db_pay_wallet_params"></a> [cosmos\_mongo\_db\_pay\_wallet\_params](#input\_cosmos\_mongo\_db\_pay\_wallet\_params) | n/a | <pre>object({<br/>    enable_serverless  = bool<br/>    enable_autoscaling = bool<br/>    throughput         = number<br/>    max_throughput     = number<br/>  })</pre> | n/a | yes |
| <a name="input_dns_default_ttl_sec"></a> [dns\_default\_ttl\_sec](#input\_dns\_default\_ttl\_sec) | The DNS default TTL in seconds | `number` | `3600` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_platform"></a> [dns\_zone\_platform](#input\_dns\_zone\_platform) | The platform dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The wallet dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_is_feature_enabled"></a> [is\_feature\_enabled](#input\_is\_feature\_enabled) | Features enabled in this domain | <pre>object({<br/>    cosmos             = optional(bool, false),<br/>    redis              = optional(bool, false),<br/>    storage            = optional(bool, false),<br/>    redis_hub_spoke_pe = optional(bool, false),<br/><br/>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_italy_workspace_name"></a> [log\_analytics\_italy\_workspace\_name](#input\_log\_analytics\_italy\_workspace\_name) | Specifies the name of the Log Analytics Workspace Italy. | `string` | n/a | yes |
| <a name="input_log_analytics_italy_workspace_resource_group_name"></a> [log\_analytics\_italy\_workspace\_resource\_group\_name](#input\_log\_analytics\_italy\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace Italy is located in. | `string` | n/a | yes |
| <a name="input_monitor_italy_resource_group_name"></a> [monitor\_italy\_resource\_group\_name](#input\_monitor\_italy\_resource\_group\_name) | Monitor Italy resource group name | `string` | n/a | yes |
| <a name="input_pay_wallet_jwt_issuer_api_key_use_primary"></a> [pay\_wallet\_jwt\_issuer\_api\_key\_use\_primary](#input\_pay\_wallet\_jwt\_issuer\_api\_key\_use\_primary) | If true the current active API key used for jwt issuer service will be the primary one. | `bool` | `true` | no |
| <a name="input_pay_wallet_storage_params"></a> [pay\_wallet\_storage\_params](#input\_pay\_wallet\_storage\_params) | Azure storage DB params for pagoPA wallet resources. | <pre>object({<br/>    kind                          = string,<br/>    tier                          = string,<br/>    account_replication_type      = string,<br/>    advanced_threat_protection    = bool,<br/>    retention_days                = number,<br/>    public_network_access_enabled = bool,<br/>  })</pre> | n/a | yes |
| <a name="input_payment_wallet_service_api_key_use_primary"></a> [payment\_wallet\_service\_api\_key\_use\_primary](#input\_payment\_wallet\_service\_api\_key\_use\_primary) | If true the current active API key used for wallet service requests will be the primary one. | `bool` | `true` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_redis_pay_wallet_params"></a> [redis\_pay\_wallet\_params](#input\_redis\_pay\_wallet\_params) | n/a | <pre>object({<br/>    capacity = number<br/>    sku_name = string<br/>    family   = string<br/>    version  = string<br/>    zones    = list(number)<br/>  })</pre> | n/a | yes |
| <a name="input_redis_std_pay_wallet_params"></a> [redis\_std\_pay\_wallet\_params](#input\_redis\_std\_pay\_wallet\_params) | n/a | <pre>object({<br/>    capacity = number<br/>    sku_name = string<br/>    family   = string<br/>    version  = string<br/>    zones    = list(number)<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
