data "azurerm_key_vault_secret" "slack_pagopa_pagamenti_alert_email" {
  name         = "slack-pagopa-pagamenti-alert-email"
  key_vault_id = module.key_vault.id
}
