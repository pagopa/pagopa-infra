data "azurerm_key_vault" "kv" {
  name                = "${local.project}-kv"
  resource_group_name = "${local.project}-sec-rg"
}

data "azurerm_key_vault_secret" "elastic_otel_token_header" {
  name         = "elastic-apm-secret-token"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_resource_group_name
}

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
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "notices_mongo_connection_string" {
  name         = "notices-mongo-connection-string"
  value        = "AccountEndpoint=https://pagopa-${var.env_short}-${var.location_short}-${var.domain}-ds-cosmos-account.documents.azure.com:443/;AccountKey=${data.azurerm_cosmosdb_account.notices_cosmos_account.primary_key}"
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "notices_mongo_primary_key" {
  name         = "notices-mongo-primary-key"
  value        = data.azurerm_cosmosdb_account.notices_cosmos_account.primary_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "notices_storage_account_connection_string" {
  name         = "notices-storage-account-connection-string"
  value        = data.azurerm_storage_account.notices_storage_sa.primary_connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}
#
resource "azurerm_key_vault_secret" "notices_storage_account_pkey" {
  name         = "notices-storage-account-pkey"
  value        = data.azurerm_storage_account.notices_storage_sa.primary_access_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

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

resource "azurerm_key_vault_secret" "ehub_notice_connection_string" {
  name         = "ehub-${var.env_short}-notice-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.notices_evt_authorization_rule.primary_connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id

}

resource "azurerm_key_vault_secret" "ehub_notice_complete_connection_string" {
  name         = "ehub-${var.env_short}-notice-complete-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.notices_complete_evt_authorization_rule.primary_connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "ehub_notice_error_connection_string" {
  name         = "ehub-${var.env_short}-notice-error-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.notices_error_evt_authorization_rule.primary_connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "pdf_engine_node_subkey_secret" {
  count = var.is_feature_enabled.pdf_engine ? 1 : 0

  name         = "pdf-engine-node-subkey"
  value        = azurerm_api_management_subscription.pdf_engine_node_subkey[0].primary_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id

}
