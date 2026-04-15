data "azurerm_key_vault_secret" "slack_pagopa_pagamenti_alert_email" {
  name         = "slack-pagopa-pagamenti-alert-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_cosmosdb_account" "bizevents_ds_cosmos" {
  count               = var.env_short != "p" ? 1 : 0
  name                = "${local.product}-${var.location_short}-bizevents-ds-cosmos-account"
  resource_group_name = "${local.product}-${var.location_short}-bizevents-rg"
}