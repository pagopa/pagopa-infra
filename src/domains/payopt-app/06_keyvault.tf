locals {
  aks_api_url = var.env_short == "d" ? data.azurerm_kubernetes_cluster.aks.fqdn : data.azurerm_kubernetes_cluster.aks.private_fqdn
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "aks_apiserver_url" {
  name         = "${local.aks_name}-apiserver-url"
  value        = "https://${local.aks_api_url}:443"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

## Manual secrets

resource "azurerm_key_vault_secret" "application_insights_connection_string" {
  name         = "app-insight-connection-string"
  value        = data.azurerm_application_insights.application_insights_italy.connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}


resource "azurerm_key_vault_secret" "tenant_id" {
  name         = "tenant-id"
  value        = data.azurerm_subscription.current.tenant_id
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# Event Hub

resource "azurerm_key_vault_secret" "ehub_payment-options-re_jaas_config" {
  name         = "ehub-${var.env_short}-payment-options-re-jaas-config"
  value        = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${data.azurerm_eventhub_authorization_rule.payment_options_re_authorization_rule_writer.primary_connection_string}\";"
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "ehub_nodo_pagamenti_cache_jaas_config" {
  name         = "ehub-${var.env_short}-nodo-pagamenti-cache-jaas-config"
  value        = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${data.azurerm_eventhub_authorization_rule.pagopa_weu_core_evh_ns04_nodo_dei_pagamenti_cache_sync_reader.primary_connection_string}\";"
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "ehub_nodo-dei-pagamenti-verify-ko_jaas_config" {
  name         = "ehub-${var.env_short}-nodo-dei-pagamenti-verify-ko-jaas-config"
  value        = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${data.azurerm_eventhub_authorization_rule.pagopa_weu_core_evh_ns04_nodo_dei_pagamenti_verify_ko_writer.primary_connection_string}\";"
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "api_config_subscription_key" {
  name         = "api-config-sub-key"
  value        = azurerm_api_management_subscription.api_config_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "forwarder_subscription_key" {
  name         = "forwarder-sub-key"
  value        = azurerm_api_management_subscription.forwarder_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

# using for test
resource "azurerm_key_vault_secret" "service_payment_options_subscription_key" {
  count = var.env_short != "p" ? 1 : 0

  name         = "apikey-service-payment-options"
  value        = azurerm_api_management_subscription.service_payment_options_subkey[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}



