resource "azurerm_resource_group" "sec_rg" {
  name     = "${local.product}-${var.domain}-sec-rg"
  location = var.location

  tags = var.tags
}

module "key_vault" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault?ref=v6.4.1"

  name                       = "${local.product}-${var.domain}-kv"
  location                   = azurerm_resource_group.sec_rg.location
  resource_group_name        = azurerm_resource_group.sec_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 90

  tags = var.tags
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "ad_group_policy" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt", "GetRotationPolicy", "Purge", "Recover", "Restore"]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Purge", "Recover", "Restore"]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover"]
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_developers_policy" {
  count = var.env_short != "p" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developers.object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
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

  secret_permissions      = ["Get", "List", "Set", ]
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]
  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt"]

  storage_permissions = []
}

resource "azurerm_key_vault_secret" "biz_events_datastore_cosmos_pkey" {
  name         = format("biz-events-datastore-%s-cosmos-pkey", var.env_short)
  value        = module.bizevents_datastore_cosmosdb_account.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ai_connection_string" {
  name         = format("ai-%s-connection-string", var.env_short)
  value        = data.azurerm_application_insights.application_insights.connection_string
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

resource "azurerm_key_vault_secret" "ehub_biz_connection_string" {
  name         = format("ehub-%s-biz-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns01_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_biz_enrich_connection_string" {
  name         = format("ehub-%s-biz-enrich-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns01_nodo-dei-pagamenti-biz-evt-enrich_pagopa-biz-evt-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_negative_biz_connection_string" {
  name         = format("ehub-%s-rx-negative-biz-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns01_nodo-dei-pagamenti-negative-biz-evt_pagopa-negative-biz-evt-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

// PRODns02ns04
resource "azurerm_key_vault_secret" "ehub_awakable_negative_biz_connection_string" {
  name         = format("ehub-%s-tx-awakable-negative-biz-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns04_nodo-dei-pagamenti-negative-awakable-biz-evt_pagopa-biz-evt-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

// PRODns02ns04
resource "azurerm_key_vault_secret" "ehub_final_negative_biz_connection_string" {
  name         = format("ehub-%s-tx-final-negative-biz-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns04_nodo-dei-pagamenti-negative-final-biz-evt_pagopa-biz-evt-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "biz_azurewebjobsstorage" {
  name         = format("bizevent-%s-azurewebjobsstorage", var.env_short)
  value        = module.bizevents_datastore_fn_sa.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "cosmos_biz_key" {
  name         = format("cosmos-%s-biz-key", var.env_short)
  value        = module.bizevents_datastore_cosmosdb_account.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
resource "azurerm_key_vault_secret" "ehub_tx_biz_key" {
  name         = format("ehub-tx-%s-biz-key", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns01_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-tx.primary_key
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
resource "azurerm_key_vault_secret" "ehub_tx_negative_biz_key" {
  name         = format("ehub-tx-%s-negative-biz-key", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns01_nodo-dei-pagamenti-negative-biz-evt_pagopa-negative-biz-evt-tx.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

// PRODns02ns04
resource "azurerm_key_vault_secret" "ehub_rx_negative_final_biz_conn_string" {
  name         = format("ehub-rx-%s-negative-final-biz-conn-string", var.env_short)
  value        = format("'%s'", data.azurerm_eventhub_authorization_rule.pagopa-evh-ns04_nodo-dei-pagamenti-negative-final-biz-evt_pagopa-biz-evt-rx-pdnd.primary_connection_string)
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

// PRODns02ns04
resource "azurerm_key_vault_secret" "ehub_rx_negative_awakable_biz_conn_string" {
  name         = format("ehub-rx-%s-negative-awakable-biz-conn-string", var.env_short)
  value        = format("'%s'", data.azurerm_eventhub_authorization_rule.pagopa-evh-ns04_nodo-dei-pagamenti-negative-awakable-biz-evt_pagopa-biz-evt-rx-pdnd.primary_connection_string)
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
  name                = format("%s-%s-redis", var.prefix, var.env_short)
  resource_group_name = format("%s-%s-data-rg", var.prefix, var.env_short)
}

resource "azurerm_key_vault_secret" "redis_password" {
  name         = "redis-password"
  value        = data.azurerm_redis_cache.redis_cache.primary_access_key
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
  count        = var.env_short != "p" ? 1 : 0
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
