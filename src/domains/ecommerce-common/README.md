<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.38.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.30.0, <= 3.53.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cosmosdb_account_mongodb"></a> [cosmosdb\_account\_mongodb](#module\_cosmosdb\_account\_mongodb) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account | v6.7.0 |
| <a name="module_cosmosdb_ecommerce_collections"></a> [cosmosdb\_ecommerce\_collections](#module\_cosmosdb\_ecommerce\_collections) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection | v6.7.0 |
| <a name="module_cosmosdb_ecommerce_history_collections"></a> [cosmosdb\_ecommerce\_history\_collections](#module\_cosmosdb\_ecommerce\_history\_collections) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection | v6.7.0 |
| <a name="module_cosmosdb_ecommerce_snet"></a> [cosmosdb\_ecommerce\_snet](#module\_cosmosdb\_ecommerce\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.7.0 |
| <a name="module_ecommerce_pm_history_storage"></a> [ecommerce\_pm\_history\_storage](#module\_ecommerce\_pm\_history\_storage) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v6.7.0 |
| <a name="module_ecommerce_storage_deadletter"></a> [ecommerce\_storage\_deadletter](#module\_ecommerce\_storage\_deadletter) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v6.7.0 |
| <a name="module_ecommerce_storage_snet"></a> [ecommerce\_storage\_snet](#module\_ecommerce\_storage\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.7.0 |
| <a name="module_ecommerce_storage_transient"></a> [ecommerce\_storage\_transient](#module\_ecommerce\_storage\_transient) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v6.7.0 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault | v6.7.0 |
| <a name="module_pagopa_ecommerce_redis"></a> [pagopa\_ecommerce\_redis](#module\_pagopa\_ecommerce\_redis) | git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache | v7.72.1 |
| <a name="module_pagopa_ecommerce_redis_snet"></a> [pagopa\_ecommerce\_redis\_snet](#module\_pagopa\_ecommerce\_redis\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.7.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_mongo_database.ecommerce](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_cosmosdb_mongo_database.ecommerce_history](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_legacy_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.ai_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.aws_ses_accesskey_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.aws_ses_accesskey_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ecommerce-io-jwt-signing-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ecommerce_dev_sendpaymentresult_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ecommerce_for_checkout_google_recaptcha_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ecommerce_opsgenie_webhook_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ecommerce_storage_dead_letter_account_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ecommerce_storage_deadletter_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ecommerce_storage_transient_account_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ecommerce_storage_transient_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.elastic-apm-secret-token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.elastic_otel_token_header](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.helpdesk-service-testing-api-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.helpdesk-service-testing-email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.helpdesk-service-testing-email-history](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.helpdesk-service-testing-fiscalCode](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.mongo_ecommerce_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.node_forwarder_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.nodo_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.nodo_nodeforpm_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.nodo_nodeforpsp_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.notifications_sender](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.notifications_service_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.npg_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.npg_apple_pay_psp_keys](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.npg_bancomatpay_psp_keys](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.npg_cards_psp_keys](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.npg_mybank_psp_keys](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.npg_notification_signing_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.npg_paypal_psp_keys](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.npg_satispay_psp_keys](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.payment_method_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.personal-data-vault-api-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pm_oracle_db_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pm_oracle_db_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redirect_url_mapping](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_ecommerce_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_ecommerce_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_ecommerce_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.sessions_jwt_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.touchpoint_mail](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.transactions_service_auth_update_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.user_stats_for_event_dispatcher_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.wallet-api-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.wallet-token-test-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_action_group.ecommerce_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_diagnostic_setting.ecommerce_deadletter_queue_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.ecommerce_transient_queue_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_metric_alert.cosmos_db_normalized_ru_exceeded](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.queue_storage_account_average_messge_count](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.redis_cache_used_memory_exceeded](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.ecommerce_authorization_outcome_notification_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.ecommerce_deadletter_filling_rate_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.ecommerce_enqueue_rate_alert_visibility_timeout_diff](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.ecommerce_for_app_io_v2_availability_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.ecommerce_for_checkout_availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.ecommerce_notifications_service_availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.ecommerce_payment_methods_start_session_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.ecommerce_payment_requests_service_availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.ecommerce_transactions_service_auth_request_ko](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.ecommerce_transactions_service_user_receipts_ko](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.ecommerce_transient_enqueue_rate_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.ecommerce_user_stats_last_payment_method_put_availability_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_endpoint.storage_deadletter_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.storage_transient_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.cosmosdb_ecommerce_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.redis_ecommerce_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_ecommerce_alerts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.storage_ecommerce_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_queue.notifications_service_errors_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.notifications_service_errors_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.notifications_service_retry_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.notifications_service_retry_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_authorization_outcome_waiting_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_authorization_outcome_waiting_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_authorization_requested_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_authorization_requested_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_close_payment_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_close_payment_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_close_payment_retry_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_close_payment_retry_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_dead_letter_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_dead_letter_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_expiration_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_expiration_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_notifications_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_notifications_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_notifications_retry_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_notifications_retry_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_refund_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_refund_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_refund_retry_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.transactions_refund_retry_queue_blue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_table.pm_history_ingestion_log_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_deploy_legacy](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_plan_legacy](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/service_principal) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_secret.monitor_ecommerce_opsgenie_webhook_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.iac_federated_azdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_subnet_cosmosdb_ecommerce"></a> [cidr\_subnet\_cosmosdb\_ecommerce](#input\_cidr\_subnet\_cosmosdb\_ecommerce) | Cosmos DB address space for ecommerce. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_redis_ecommerce"></a> [cidr\_subnet\_redis\_ecommerce](#input\_cidr\_subnet\_redis\_ecommerce) | Redis DB address space for ecommerce. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_storage_ecommerce"></a> [cidr\_subnet\_storage\_ecommerce](#input\_cidr\_subnet\_storage\_ecommerce) | Azure storage DB address space for ecommerce. | `list(string)` | n/a | yes |
| <a name="input_cosmos_mongo_db_ecommerce_history_params"></a> [cosmos\_mongo\_db\_ecommerce\_history\_params](#input\_cosmos\_mongo\_db\_ecommerce\_history\_params) | n/a | <pre>object({<br/>    enable_serverless  = bool<br/>    enable_autoscaling = bool<br/>    throughput         = number<br/>    max_throughput     = number<br/>  })</pre> | n/a | yes |
| <a name="input_cosmos_mongo_db_ecommerce_params"></a> [cosmos\_mongo\_db\_ecommerce\_params](#input\_cosmos\_mongo\_db\_ecommerce\_params) | n/a | <pre>object({<br/>    enable_serverless  = bool<br/>    enable_autoscaling = bool<br/>    throughput         = number<br/>    max_throughput     = number<br/>  })</pre> | n/a | yes |
| <a name="input_cosmos_mongo_db_params"></a> [cosmos\_mongo\_db\_params](#input\_cosmos\_mongo\_db\_params) | n/a | <pre>object({<br/>    enabled        = bool<br/>    capabilities   = list(string)<br/>    offer_type     = string<br/>    server_version = string<br/>    kind           = string<br/>    consistency_policy = object({<br/>      consistency_level       = string<br/>      max_interval_in_seconds = number<br/>      max_staleness_prefix    = number<br/>    })<br/>    enable_free_tier                 = bool<br/>    main_geo_location_zone_redundant = bool<br/>    additional_geo_locations = list(object({<br/>      location          = string<br/>      failover_priority = number<br/>      zone_redundant    = bool<br/>    }))<br/>    private_endpoint_enabled                     = bool<br/>    public_network_access_enabled                = bool<br/>    is_virtual_network_filter_enabled            = bool<br/>    backup_continuous_enabled                    = bool<br/>    enable_provisioned_throughput_exceeded_alert = bool<br/>  })</pre> | n/a | yes |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_ecommerce_storage_deadletter_params"></a> [ecommerce\_storage\_deadletter\_params](#input\_ecommerce\_storage\_deadletter\_params) | Azure storage DB params for ecommerce deadletter resources. | <pre>object({<br/>    enabled                       = bool,<br/>    kind                          = string,<br/>    tier                          = string,<br/>    account_replication_type      = string,<br/>    advanced_threat_protection    = bool,<br/>    retention_days                = number,<br/>    public_network_access_enabled = bool,<br/>  })</pre> | <pre>{<br/>  "account_replication_type": "LRS",<br/>  "advanced_threat_protection": true,<br/>  "enabled": false,<br/>  "kind": "StorageV2",<br/>  "public_network_access_enabled": false,<br/>  "retention_days": 7,<br/>  "tier": "Standard"<br/>}</pre> | no |
| <a name="input_ecommerce_storage_transient_params"></a> [ecommerce\_storage\_transient\_params](#input\_ecommerce\_storage\_transient\_params) | Azure storage DB params for ecommerce transient resources. | <pre>object({<br/>    enabled                       = bool,<br/>    kind                          = string,<br/>    tier                          = string,<br/>    account_replication_type      = string,<br/>    advanced_threat_protection    = bool,<br/>    retention_days                = number,<br/>    public_network_access_enabled = bool,<br/>  })</pre> | <pre>{<br/>  "account_replication_type": "LRS",<br/>  "advanced_threat_protection": true,<br/>  "enabled": false,<br/>  "kind": "StorageV2",<br/>  "public_network_access_enabled": false,<br/>  "retention_days": 7,<br/>  "tier": "Standard"<br/>}</pre> | no |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_redis_ecommerce_params"></a> [redis\_ecommerce\_params](#input\_redis\_ecommerce\_params) | n/a | <pre>object({<br/>    capacity   = number<br/>    sku_name   = string<br/>    family     = string<br/>    version    = string<br/>    ha_enabled = bool<br/>    zones      = list(number)<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br/>  "CreatedBy": "Terraform"<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
