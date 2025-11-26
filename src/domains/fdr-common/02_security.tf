data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

###############
## Event Hub ##
###############

### FdR Quality Improvement
resource "azurerm_key_vault_secret" "evthub_fdr-qi-flows_tx" {
  name         = "fdr-qi-flows-tx-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_fdr-qi-flows-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "evthub_fdr-qi-flows_rx" {
  name         = "fdr-qi-flows-rx-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_fdr-qi-flows-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "evthub_fdr-qi-reported-iuv_tx" {
  name         = "fdr-qi-reported-iuv-tx-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_fdr-qi-reported-iuv-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "evthub_fdr-qi-reported-iuv_rx" {
  name         = "fdr-qi-reported-iuv-rx-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_fdr-qi-reported-iuv-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

############
## Cosmos ##
############
resource "azurerm_key_vault_secret" "fdr_re_mongodb_connection_string" {
  name         = "mongodb-re-connection-string"
  value        = module.cosmosdb_account_mongodb_fdr_re.connection_strings[0]
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    module.cosmosdb_account_mongodb_fdr_re
  ]
}

#####################
## Storage Account ##
#####################
resource "azurerm_key_vault_secret" "fdr_storage_account_connection_string" {
  name         = "fdr-sa-connection-string"
  value        = module.fdr_conversion_sa.primary_connection_string
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    module.fdr_conversion_sa
  ]
}

resource "azurerm_key_vault_secret" "fdr_re_storage_account_connection_string" {
  name         = "fdr-re-sa-connection-string"
  value        = module.fdr_re_sa.primary_connection_string
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    module.fdr_re_sa
  ]
}

##########
## APIM ##
##########
resource "azurerm_key_vault_secret" "opex_psp_subscription_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "opex-psp-subscription-key"
  value        = azurerm_api_management_subscription.opex_psp_subscription_key[0].primary_key
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    azurerm_api_management_subscription.opex_psp_subscription_key
  ]
}

resource "azurerm_key_vault_secret" "opex_org_subscription_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "opex-org-subscription-key"
  value        = azurerm_api_management_subscription.opex_org_subscription_key[0].primary_key
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    azurerm_api_management_subscription.opex_org_subscription_key
  ]
}

resource "azurerm_key_vault_secret" "opex_internal_subscription_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "opex-internal-subscription-key"
  value        = azurerm_api_management_subscription.opex_internal_subscription_key[0].primary_key
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    azurerm_api_management_subscription.opex_internal_subscription_key
  ]
}

resource "azurerm_key_vault_secret" "test_psp_subscription_key" {
  count        = var.env_short == "p" ? 0 : 1
  name         = "integration-test-psp-subscription-key"
  value        = azurerm_api_management_subscription.test_psp_subscription_key[0].primary_key
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    azurerm_api_management_subscription.test_psp_subscription_key
  ]
}

resource "azurerm_key_vault_secret" "test_org_subscription_key" {
  count        = var.env_short == "p" ? 0 : 1
  name         = "integration-test-org-subscription-key"
  value        = azurerm_api_management_subscription.test_org_subscription_key[0].primary_key
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    azurerm_api_management_subscription.test_org_subscription_key
  ]
}

resource "azurerm_key_vault_secret" "test_internal_subscription_key" {
  count        = var.env_short == "p" ? 0 : 1
  name         = "integration-test-internal-subscription-key"
  value        = azurerm_api_management_subscription.test_internal_subscription_key[0].primary_key
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    azurerm_api_management_subscription.test_internal_subscription_key
  ]
}
