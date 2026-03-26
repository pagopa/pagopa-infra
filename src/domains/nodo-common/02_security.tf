data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

data "azurerm_redis_cache" "redis_cache" {
  name                = var.redis_ha_enabled ? format("%s-%s-%s-redis", var.prefix, var.env_short, var.location_short) : format("%s-%s-redis", var.prefix, var.env_short)
  resource_group_name = format("%s-%s-data-rg", var.prefix, var.env_short)
}

data "azurerm_cosmosdb_account" "bizevents_datastore_cosmosdb_account" {
  name                = format("%s-%s-%s-bizevents-ds-cosmos-account", var.prefix, var.env_short, var.location_short)
  resource_group_name = format("%s-%s-%s-bizevents-rg", var.prefix, var.env_short, var.location_short)
}

data "azurerm_cosmosdb_account" "bizevents_neg_datastore_cosmosdb_account" {
  name                = format("%s-%s-%s-bizevents-neg-ds-cosmos-account", var.prefix, var.env_short, var.location_short)
  resource_group_name = format("%s-%s-%s-bizevents-rg", var.prefix, var.env_short, var.location_short)
}

data "azurerm_servicebus_queue_authorization_rule" "wisp_payment_timeout_authorization" {
  name                = "wisp_converter_payment_timeout"
  resource_group_name = local.sb_resource_group_name
  queue_name          = "nodo_wisp_payment_timeout_queue"
  namespace_name      = "${local.project}-servicebus-wisp"

  depends_on = [azurerm_servicebus_queue.service_bus_wisp_queue]
}

data "azurerm_servicebus_queue_authorization_rule" "nodo_wisp_ecommerce_hang_timeout_queue" {
  name                = "nodo_wisp_ecommerce_hang_timeout_queue"
  resource_group_name = local.sb_resource_group_name
  queue_name          = "nodo_wisp_ecommerce_hang_timeout_queue"
  namespace_name      = "${local.project}-servicebus-wisp"

  depends_on = [azurerm_servicebus_queue.service_bus_wisp_queue]
}

data "azurerm_servicebus_queue_authorization_rule" "wisp_paainviart_authorization" {
  name                = "wisp_converter_paainviart"
  resource_group_name = local.sb_resource_group_name
  queue_name          = "nodo_wisp_paainviart_queue"
  namespace_name      = "${local.project}-servicebus-wisp"

  depends_on = [azurerm_servicebus_queue.service_bus_wisp_queue]
}

data "azurerm_servicebus_queue_authorization_rule" "wisp_rpt_timeout_queue" {
  name                = "nodo_wisp_rpt_timeout_queue"
  resource_group_name = local.sb_resource_group_name
  queue_name          = "nodo_wisp_rpt_timeout_queue"
  namespace_name      = "${local.project}-servicebus-wisp"

  depends_on = [azurerm_servicebus_queue.service_bus_wisp_queue]
}

/*****************
Storage Account
*****************/
resource "azurerm_key_vault_secret" "node_cfg_sync_re_sa_connection_string" {
  name         = "node-cfg-sync-re-sa-connection-string-key"
  value        = module.nodo_cfg_sync_re_storage_account.primary_connection_string
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    module.nodo_cfg_sync_re_storage_account
  ]
  tags = module.tag_config.tags
}


resource "azurerm_key_vault_secret" "ai_connection_string" {
  name         = format("ai-%s-connection-string", var.env_short)
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "wisp_converter_re_sa_connection_string" {
  count        = var.create_wisp_converter ? 1 : 0
  name         = "wisp-converter-re-sa-connection-string-key"
  value        = module.wisp_converter_storage_account[0].primary_connection_string
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    module.nodo_cfg_sync_re_storage_account
  ]

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "verifyko_tablestorage_connection_string" {
  name         = "verifyko-tablestorage-connection-string"
  value        = module.nodo_verifyko_storage_account.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

# Storage Account for MBD - file shared firmatore
# 🏗️ https://pagopa.atlassian.net/wiki/spaces/IQCGJ/pages/887455819/Design+Review+Rendicontazione+MBD#Vista-statica-delle-componenti
# the old one present into node-secrets will be rename in
# 1) azurestorageaccountkey-deprecated
# 1) azurestorageaccountname-deprecated
resource "azurerm_key_vault_secret" "mbd_storage_key" {
  name         = "azurestorageaccountkey"
  value        = module.mbd_storage_account.primary_access_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "mbd_storage_name" {
  name         = "azurestorageaccountname"
  value        = module.mbd_storage_account.name
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "mbd_storage_conn_string" {
  name         = "mbd-storage-account-connection-string"
  value        = module.mbd_storage_account.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

/**********
Event Hub
***********/
### cache
# consumer used by node-cfg-sync
resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_cache_sync_rx" {
  name         = "nodo-dei-pagamenti-cache-sync-rx-connection-string-key"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-cache-sync-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}
# consumer used by stand-in-manager
resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_cache_stand_in_rx" {
  name         = "nodo-dei-pagamenti-cache-stand-in-rx-connection-string-key"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-cache-stand-in-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

### stand-in
resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_stand_in_tx" {
  name         = "nodo-dei-pagamenti-stand-in-tx-connection-string-key"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-stand-in-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_stand_in_sync_rx" {
  name         = "nodo-dei-pagamenti-stand-in-sync-rx-connection-string-key"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-stand-in-sync-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

### verify ko
resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_verify_ko_tx" {
  name         = "azure-event-hub-verify-ko-evt-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-verify-ko-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_verify_ko_datastore_rx" {
  name         = "ehub-verifyko-datastore-rx-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-verify-ko-datastore-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_verify_ko_tablestorage_rx" {
  name         = "ehub-verifyko-tablestorage-rx-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-verify-ko-tablestorage-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_negative_biz_evt_pagopa_negative_biz_evt_tx" {
  name         = "azure-event-hub-negative-biz-evt-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-negative-biz-evt_pagopa-negative-biz-evt-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_biz_evt_pagopa_biz_evt_tx" {
  name         = "azure-event-hub-biz-evt-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_verify_ko_nodo_dei_pagamenti_verify_ko_tx" {
  name         = "azure-event-hub-verify-ko-evt-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_re_nodo_dei_pagamenti" {
  name         = "azure-event-hub-re-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-re_nodo-dei-pagamenti.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}


/*****************
CosmosDB
*****************/

resource "azurerm_key_vault_secret" "wisp_converter_cosmosdb_account_key" {
  count        = var.create_wisp_converter ? 1 : 0
  name         = "cosmosdb-wisp-converter-account-key"
  value        = module.cosmosdb_account_wispconv[0].primary_key
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    module.cosmosdb_account_wispconv
  ]

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "cosmos_neg_biz_account_key" {
  name         = "cosmos-neg-biz-account-key"
  value        = data.azurerm_cosmosdb_account.bizevents_neg_datastore_cosmosdb_account.secondary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "cosmos_biz_account_key" {
  name         = "cosmos-biz-account-key"
  value        = data.azurerm_cosmosdb_account.bizevents_datastore_cosmosdb_account.secondary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "cosmos_verifyko_account_key" {
  name         = "cosmos-verifyko-account-key"
  value        = module.cosmosdb_account_nodo_verifyko.secondary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "verifyko_datastore_primary_key" {
  name         = "verifyko-datastore-primary-key"
  value        = module.cosmosdb_account_nodo_verifyko.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

/*****************
Redis
*****************/

resource "azurerm_key_vault_secret" "redis_primary_key" {
  name         = "redis-primary-key"
  value        = data.azurerm_redis_cache.redis_cache.primary_access_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}


resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = "redis-hostname"
  value        = data.azurerm_redis_cache.redis_cache.hostname
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

/*****************
Service Bus
*****************/
resource "azurerm_key_vault_secret" "wisp_payment_timeout_key" {
  count = var.create_wisp_converter ? 1 : 0

  name         = "wisp-payment-timeout-queue-connection-string"
  value        = data.azurerm_servicebus_queue_authorization_rule.wisp_payment_timeout_authorization.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "ecommerce_hang_timeout_key" {
  count = var.create_wisp_converter ? 1 : 0

  name         = "ecommerce-hang-timer-queue-connection-string"
  value        = data.azurerm_servicebus_queue_authorization_rule.nodo_wisp_ecommerce_hang_timeout_queue.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "wisp_paainviart_key" {
  count = var.create_wisp_converter ? 1 : 0

  name         = "wisp-paainviart-queue-connection-string"
  value        = data.azurerm_servicebus_queue_authorization_rule.wisp_paainviart_authorization.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "wisp_rpt_timeout_key" {
  count = var.create_wisp_converter ? 1 : 0

  name         = "wisp-rpt-timeout-queue-connection-string"
  value        = data.azurerm_servicebus_queue_authorization_rule.wisp_rpt_timeout_queue.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}


/*****************
Integration tests
*****************/
# Subscription key taken from Node Forwarder product and used for integration tests
data "azurerm_api_management_product" "apim_forwarder_product" {
  product_id          = "nodo-auth"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
resource "azurerm_api_management_subscription" "integration_test_forwarder_subscription_key" {
  count               = var.env_short != "p" ? 1 : 0
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_forwarder_product.id
  display_name  = "Subscription key from Nuova Connettivita for integration test"
  allow_tracing = false
  state         = "active"
}

resource "azurerm_key_vault_secret" "integration_test_forwarder_subscription_key_kv" {
  count        = var.env_short != "p" ? 1 : 0
  depends_on   = [azurerm_api_management_subscription.integration_test_forwarder_subscription_key[0]]
  name         = "integration-test-forwarder-subscription-key"
  value        = azurerm_api_management_subscription.integration_test_forwarder_subscription_key[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

# Subscription key taken from GPD product and used for integration tests
data "azurerm_api_management_product" "apim_gpd_product" {
  product_id          = "product-gpd"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
resource "azurerm_api_management_subscription" "integration_test_gpd_subscription_key" {
  count               = var.env_short != "p" ? 1 : 0
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_gpd_product.id
  display_name  = "Subscription key from GPD-core for integration test"
  allow_tracing = false
  state         = "active"
}
resource "azurerm_key_vault_secret" "integration_test_gpd_subscription_key_kv" {
  count        = var.env_short != "p" ? 1 : 0
  depends_on   = [azurerm_api_management_subscription.integration_test_gpd_subscription_key[0]]
  name         = "integration-test-gpd-subscription-key"
  value        = azurerm_api_management_subscription.integration_test_gpd_subscription_key[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

# Subscription key taken from Nodo dei Pagamenti product and used for integration tests
data "azurerm_api_management_product" "apim_nodo_dei_pagamenti_product" {
  product_id          = "nodo"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
resource "azurerm_api_management_subscription" "integration_test_nodo_subscription_key" {
  count               = var.env_short != "p" ? 1 : 0
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_nodo_dei_pagamenti_product.id
  display_name  = "Subscription key from Nodo dei Pagamenti for integration test"
  allow_tracing = false
  state         = "active"
}
resource "azurerm_key_vault_secret" "integration_test_nodo_subscription_key_kv" {
  count        = var.env_short != "p" ? 1 : 0
  depends_on   = [azurerm_api_management_subscription.integration_test_nodo_subscription_key[0]]
  name         = "integration-test-nodo-subscription-key"
  value        = azurerm_api_management_subscription.integration_test_nodo_subscription_key[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}

# Subscription key taken from Technical Support APIs product and used for integration tests
data "azurerm_api_management_product" "apim_technical_support_product" {
  product_id          = "technical_support_api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
resource "azurerm_api_management_subscription" "integration_test_technical_support_subscription_key" {
  count               = var.env_short != "p" ? 1 : 0
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_technical_support_product.id
  display_name  = "Subscription key from Nodo dei Pagamenti for integration test"
  allow_tracing = false
  state         = "active"
}
resource "azurerm_key_vault_secret" "integration_test_technical_support_subscription_key_kv" {
  count        = var.env_short != "p" ? 1 : 0
  depends_on   = [azurerm_api_management_subscription.integration_test_technical_support_subscription_key[0]]
  name         = "integration-test-technicalsupport-subscription-key"
  value        = azurerm_api_management_subscription.integration_test_technical_support_subscription_key[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  tags = module.tag_config.tags
}
