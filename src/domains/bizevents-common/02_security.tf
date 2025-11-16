resource "azurerm_resource_group" "sec_rg" {
  name     = "${local.product}-${var.domain}-sec-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "key_vault" {
  source = "./.terraform/modules/__v3__/key_vault"

  name                       = "${local.product}-${var.domain}-kv"
  location                   = azurerm_resource_group.sec_rg.location
  resource_group_name        = azurerm_resource_group.sec_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 90

  tags = module.tag_config.tags
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "ad_group_policy" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions = [
    "Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt",
    "GetRotationPolicy", "Purge", "Recover", "Restore"
  ]
  secret_permissions = [
    "Get", "List", "Set", "Delete", "Purge", "Recover", "Restore"
  ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge",
    "Recover"
  ]
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_developers_policy" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developers.object_id

  key_permissions = [
    "Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt",
    "GetRotationPolicy", "Purge", "Recover", "Restore"
  ]
  secret_permissions = [
    "Get", "List", "Set", "Delete", "Purge", "Recover", "Restore"
  ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge",
    "Recover"
  ]
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_externals_policy" {
  count = var.env_short != "p" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_externals.object_id

  key_permissions = [
    "Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt",
    "Recover", "Rotate", "GetRotationPolicy"
  ]
  secret_permissions  = ["Get", "List", "Set", "Delete", "Recover", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

# azure devops policy
data "azuread_service_principal" "iac_principal" {
  count        = var.enable_iac_pipeline ? 1 : 0
  display_name = format("pagopaspa-pagoPA-iac-%s", data.azurerm_subscription.current.subscription_id)
}

resource "azurerm_key_vault_access_policy" "azdevops_iac_policy" {
  count        = var.enable_iac_pipeline ? 1 : 0
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.iac_principal[0].object_id

  secret_permissions = ["Get", "List", "Set", ]
  certificate_permissions = [
    "SetIssuers", "DeleteIssuers", "Purge", "List", "Get"
  ]
  key_permissions = [
    "Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt"
  ]

  storage_permissions = []
}

####################
## COSMOS DB
####################

resource "azurerm_key_vault_secret" "biz_events_datastore_cosmos_pkey" {
  name         = format("biz-events-datastore-%s-cosmos-pkey", var.env_short)
  value        = module.bizevents_datastore_cosmosdb_account.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "cosmos_biz_connection_string" {
  name         = format("cosmos-%s-biz-connection-string", var.env_short)
  value        = module.bizevents_datastore_cosmosdb_account.connection_strings[0]
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "cosmos_negative_biz_connection_string" {
  name         = format("cosmos-%s-negative-biz-connection-string", var.env_short)
  value        = module.negative_bizevents_datastore_cosmosdb_account.connection_strings[0]
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "cosmos_biz_key" {
  name         = format("cosmos-%s-biz-key", var.env_short)
  value        = module.bizevents_datastore_cosmosdb_account.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

## Negative BizEvents
resource "azurerm_key_vault_secret" "cosmos_negative_biz_key" {
  name         = format("cosmos-%s-negative-biz-key", var.env_short)
  value        = module.negative_bizevents_datastore_cosmosdb_account.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

####################
## EVENT HUB NS03
####################

resource "azurerm_key_vault_secret" "ehub_biz_connection_string" {
  name         = format("ehub-%s-biz-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_biz_tx_connection_string" {
  name         = format("ehub-tx-%s-biz-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_biz_enrich_connection_string" {
  name         = format("ehub-%s-biz-enrich-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt-enrich_pagopa-biz-evt-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_negative_biz_connection_string" {
  name         = format("ehub-%s-rx-negative-biz-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-negative-biz-evt_pagopa-negative-biz-evt-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_views_biz_connection_string" {
  name         = format("ehub-views-%s-biz-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-rx-views.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_tx_biz_key" {
  name         = format("ehub-tx-%s-biz-key", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-tx.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_tx_negative_biz_key" {
  name         = format("ehub-tx-%s-negative-biz-key", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-negative-biz-evt_pagopa-negative-biz-evt-tx.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

####################
## EVENT HUB NS04
####################

resource "azurerm_key_vault_secret" "ehub_awakable_negative_biz_connection_string" {
  name         = format("ehub-%s-tx-awakable-negative-biz-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns04_nodo-dei-pagamenti-negative-awakable-biz-evt_pagopa-biz-evt-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_final_negative_biz_connection_string" {
  name         = format("ehub-%s-tx-final-negative-biz-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns04_nodo-dei-pagamenti-negative-final-biz-evt_pagopa-biz-evt-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_rx_negative_final_biz_conn_string" {
  name         = format("ehub-rx-%s-negative-final-biz-conn-string", var.env_short)
  value        = format("'%s'", data.azurerm_eventhub_authorization_rule.pagopa-evh-ns04_nodo-dei-pagamenti-negative-final-biz-evt_pagopa-biz-evt-rx-pdnd.primary_connection_string)
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_rx_negative_awakable_biz_conn_string" {
  name         = format("ehub-rx-%s-negative-awakable-biz-conn-string", var.env_short)
  value        = format("'%s'", data.azurerm_eventhub_authorization_rule.pagopa-evh-ns04_nodo-dei-pagamenti-negative-awakable-biz-evt_pagopa-biz-evt-rx-pdnd.primary_connection_string)
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}


####################
## OTHER
####################

resource "azurerm_key_vault_secret" "ai_connection_string" {
  name         = format("ai-%s-connection-string", var.env_short)
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "biz_azurewebjobsstorage" {
  name         = format("bizevent-%s-azurewebjobsstorage", var.env_short)
  value        = module.bizevents_datastore_fn_sa.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
resource "azurerm_key_vault_secret" "biz_view_azurewebjobsstorage" {
  name         = format("bizevent-view-%s-azurewebjobsstorage", var.env_short)
  value        = module.bizevents_datastore_fn_sa_bizview.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "payment_manager_subscription_key" {
  name         = "payment-manager-subscription-key"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "elastic_otl_secret_token" {
  name         = "elastic-otl-secret-token"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

data "azurerm_redis_cache" "redis_cache" {
  name                = var.redis_ha_enabled ? format("%s-%s-%s-redis", var.prefix, var.env_short, var.location_short) : format("%s-%s-redis", var.prefix, var.env_short)
  resource_group_name = format("%s-%s-data-rg", var.prefix, var.env_short)
}

resource "azurerm_key_vault_secret" "redis_password" {
  name         = "redis-password"
  value        = data.azurerm_redis_cache.redis_cache.primary_access_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = "redis-hostname"
  value        = data.azurerm_redis_cache.redis_cache.hostname
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "tokenizer_api_key" {
  name         = "tokenizer-api-key"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "webhook-slack-token" {
  # count        = var.env_short != "p" ? 1 : 0
  name         = "webhook-slack"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

// apikey list-trx-4-io-api-key and save keys on KV
data "azurerm_api_management_product" "apim_biz_lst_trx_product" {
  product_id          = "bizevent-transactions"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

resource "azurerm_api_management_subscription" "list_trx_4_io_api_key_subkey" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_biz_lst_trx_product.id
  display_name  = "Biz Events list-trx-4-io-api-key"
  allow_tracing = false
  state         = "active"
}

resource "azurerm_key_vault_secret" "list_trx_4_io_api_keysubkey_store_kv" {
  depends_on = [
    azurerm_api_management_subscription.list_trx_4_io_api_key_subkey
  ]
  name         = "list-trx-4-io-api-key"
  value        = azurerm_api_management_subscription.list_trx_4_io_api_key_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

// appIO - apikey list-lap-4-io-api-key and save keys on KV
data "azurerm_api_management_product" "apim_biz_lst_lap_product" {
  product_id          = "bizevent-lap"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

resource "azurerm_api_management_subscription" "list_lap_4_io_api_key_subkey" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_biz_lst_lap_product.id
  display_name  = "Biz Events list-lap-4-io-api-key"
  allow_tracing = false
  state         = "active"
}

resource "azurerm_key_vault_secret" "list_lap_4_io_api_keysubkey_store_kv" {
  depends_on = [
    azurerm_api_management_subscription.list_lap_4_io_api_key_subkey
  ]
  name         = "list-lap-4-io-api-key"
  value        = azurerm_api_management_subscription.list_lap_4_io_api_key_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
// ARC apikey list-lap-4-io-api-key and save keys on KV
resource "azurerm_api_management_subscription" "list_lap_arc_4_io_api_key_subkey" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_biz_lst_lap_product.id
  display_name  = "Biz Events list-lap-arc-4-io-api-key"
  allow_tracing = false
  state         = "active"
}

resource "azurerm_key_vault_secret" "list_lap_arc_4_io_api_keysubkey_store_kv" {
  depends_on = [
    azurerm_api_management_subscription.list_lap_arc_4_io_api_key_subkey
  ]
  name         = "list-lap-arc-4-io-api-key"
  value        = azurerm_api_management_subscription.list_lap_arc_4_io_api_key_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

// apikey biz-trx-api-key-4-perftest and save keys on KV
data "azurerm_api_management_product" "apim_biz_events_service_product" {
  count = var.env_short != "p" ? 1 : 0

  product_id          = "bizevents-all-in-one"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
resource "azurerm_api_management_subscription" "biz_trx_api_key_4_perftest" {
  count = var.env_short != "p" ? 1 : 0

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_biz_events_service_product[0].id
  display_name  = "Biz Events biz-trx-api-key-4-perftest"
  allow_tracing = false
  state         = "active"
}

resource "azurerm_key_vault_secret" "biz_trx_api_key_4_perftest_store_kv" {
  count = var.env_short != "p" ? 1 : 0
  depends_on = [
    azurerm_api_management_subscription.biz_trx_api_key_4_perftest[0]
  ]
  name         = "biz-trx-api-key-4-perftest"
  value        = azurerm_api_management_subscription.biz_trx_api_key_4_perftest[0].primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}


# PDF engine nodejs for PDF engine Java

data "azurerm_api_management_product" "apim_pdf_engine_product" {
  product_id          = "pdf-engine"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
data "azurerm_api_management_product" "apim_pdf_receipt_service_product" {
  product_id          = "receipts"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

// apikey to generate PDF
resource "azurerm_api_management_subscription" "pdf_engine_node_4_list_trx_subkey" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_pdf_engine_product.id
  display_name  = "PDF Engine NodeJS Java for List Transactions"
  allow_tracing = false
  state         = "active"
}
// apikey to retrieve PDF
resource "azurerm_api_management_subscription" "pdf_receipt_service_4_list_trx_subkey" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_pdf_receipt_service_product.id
  display_name  = "Receipts Service PDF for List Transactions"
  allow_tracing = false
  state         = "active"
}

// save keys on KV

resource "azurerm_key_vault_secret" "bizevent_pdf_engine_4_list_trx_subscription_key" {
  depends_on = [
    azurerm_api_management_subscription.pdf_engine_node_4_list_trx_subkey
  ]
  name         = format("bizevent-%s-pdfengine-subscription-key", var.env_short)
  value        = azurerm_api_management_subscription.pdf_engine_node_4_list_trx_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
resource "azurerm_key_vault_secret" "bizevent_receiptpdfservice_4_list_trx_subscription_key" {
  // product apim "receipts"
  depends_on = [
    azurerm_api_management_subscription.pdf_receipt_service_4_list_trx_subkey
  ]
  name         = format("bizevent-%s-receiptpdfservice-subscription-key", var.env_short)
  value        = azurerm_api_management_subscription.pdf_receipt_service_4_list_trx_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "bizevent_receiptpdfhelpdesk_4_list_trx_subscription_key" {
  // product apim "receipts"
  depends_on = [
    azurerm_api_management_subscription.pdf_receipt_service_4_list_trx_subkey
  ]
  name         = format("bizevent-%s-generatepdfservice-subscription-key", var.env_short)
  value        = azurerm_api_management_subscription.pdf_receipt_service_4_list_trx_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

data "azurerm_api_management_product" "apim_api_config_cache_product" {
  product_id          = "apiconfig-cache"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

resource "azurerm_api_management_subscription" "api_config_cache_subkey" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_api_config_cache_product.id
  display_name  = "APIConfig Cache for BizEvents system"
  allow_tracing = false
  state         = "active"
}

resource "azurerm_key_vault_secret" "api_config_cache_subscription_key_kv" {
  depends_on = [
    azurerm_api_management_subscription.api_config_cache_subkey
  ]
  name         = "api-config-cache-subscription-key"
  value        = azurerm_api_management_subscription.api_config_cache_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

# data "azurerm_api_management_product" "apim_ecommerce_helpdesk_product" {
#   product_id          = "ecommerce-helpdesk"
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
# }

data "azurerm_api_management_api" "apim_ecommerce_helpdesk_api_v2" {
  name                = "pagopa-${var.env_short}-weu-ecommerce-helpdesk-service-api-v2"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  revision            = "1"
}

resource "azurerm_api_management_subscription" "ecommerce_helpdesk_subkey" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  # product_id    = data.azurerm_api_management_product.apim_ecommerce_helpdesk_product.id
  api_id        = replace(data.azurerm_api_management_api.apim_ecommerce_helpdesk_api_v2.id, ";rev=1", "")
  display_name  = "eCommerce Helpdesk for BizEvents system"
  allow_tracing = false
  state         = "active"
}

#######
# Copy secret from nodo-kv
#######
resource "azurerm_key_vault_secret" "db_nexi_biz_pagopa_sv_password" {
  count        = var.env_short != "d" ? 1 : 0
  name         = "db-nexi-biz-pagopa-sv-password"
  value        = data.azurerm_key_vault_secret.db_nexi_biz_pagopa_sv_password[0].value
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}
