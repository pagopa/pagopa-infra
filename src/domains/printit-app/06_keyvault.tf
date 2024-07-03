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


# Mongo DB

resource "azurerm_key_vault_secret" "notices_mongo_connection_string" {
  name         = "notices-mongo-connection-string"
  value        = data.azurerm_cosmosdb_account.notices_cosmos_account.primary_mongodb_connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "notices_mongo_primary_key" {
  name         = "notices-mongo-primary-key"
  value        = data.azurerm_cosmosdb_account.notices_cosmos_account.primary_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# Notices

resource "azurerm_key_vault_secret" "notices_storage_account_endpoint" {
  name         = "notices-storage-account-blob-endpoint"
  value        = data.azurerm_storage_account.notices_storage_sa.primary_blob_endpoint
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "notices_storage_account_connection_string" {
  name         = "notices-storage-account-connection-string"
  value        = data.azurerm_storage_account.notices_storage_sa.primary_connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "notices_storage_account_pkey" {
  name         = "notices-storage-account-pkey"
  value        = data.azurerm_storage_account.notices_storage_sa.primary_access_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# Templates

resource "azurerm_key_vault_secret" "templates_storage_account_connection_string" {
  name         = "templates-storage-account-connection-string"
  value        = data.azurerm_storage_account.templates_storage_sa.primary_connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "templates_storage_account_pkey" {
  name         = "templates-storage-account-pkey"
  value        = data.azurerm_storage_account.templates_storage_sa.primary_access_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# Institutions

resource "azurerm_key_vault_secret" "institutions_storage_account_connection_string" {
  name         = "institutions-storage-account-connection-string"
  value        = data.azurerm_storage_account.institutions_storage_sa.primary_connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "institutions_storage_account_pkey" {
  name         = "institutions-storage-account-pkey"
  value        = data.azurerm_storage_account.institutions_storage_sa.primary_access_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# Event Hub
resource "azurerm_key_vault_secret" "ehub_notice_connection_string" {
  name         = "ehub-${var.env_short}-notice-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.notices_evt_authorization_rule.primary_connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "ehub_notice_errors_connection_string" {
  name         = "ehub-${var.env_short}-notice-errors-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.notices_evt_errors_authorization_rule.primary_connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "ehub_notice_complete_connection_string" {
  name         = "ehub-${var.env_short}-notice-complete-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.notices_evt_complete_authorization_rule.primary_connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "ehub_notice_jaas_config" {
  name         = "ehub-${var.env_short}-notice-jaas-config"
  value        = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${data.azurerm_eventhub_authorization_rule.notices_evt_authorization_rule.primary_connection_string}\";"
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}


resource "azurerm_key_vault_secret" "ehub_notice_errors_jaas_config" {
  name         = "ehub-${var.env_short}-notice-errors-jaas-config"
  value        = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${data.azurerm_eventhub_authorization_rule.notices_evt_errors_authorization_rule.primary_connection_string}\";"
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "ehub_notice_complete_jaas_config" {
  name         = "ehub-${var.env_short}-notice-complete-jaas-config"
  value        = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${data.azurerm_eventhub_authorization_rule.notices_evt_complete_authorization_rule.primary_connection_string}\";"
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# SubKey

resource "azurerm_key_vault_secret" "pdf_engine_node_subkey_secret" {
  count        = var.is_feature_enabled.pdf_engine ? 1 : 0
  name         = "pdf-engine-node-subkey"
  value        = azurerm_api_management_subscription.pdf_engine_node_subkey[0].primary_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "generator_for_service_subkey_secret" {
  count        = var.is_feature_enabled.printit ? 1 : 0
  name         = "notice-generation-sub-key"
  value        = azurerm_api_management_subscription.generator_for_service_subkey[0].primary_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "pdf_engine_subkey_secret" {
  count        = var.is_feature_enabled.printit ? 1 : 0
  name         = "pdf-engine-subkey"
  value        = azurerm_api_management_subscription.pdf_engine_subkey[0].primary_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}



resource "azurerm_key_vault_secret" "api_config_subscription_key" {
  name         = "api-config-sub-key"
  value        = azurerm_api_management_subscription.api_config_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

