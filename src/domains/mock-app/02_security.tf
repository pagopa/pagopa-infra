data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

/*
data "azurerm_key_vault_secret" "monitor_notification_email" {
  name         = "monitor-notification-email"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "monitor_notification_slack_email" {
  name         = "monitor-notification-slack-email"
  key_vault_id = data.azurerm_key_vault.kv.id
}
*/

# create json letsencrypt inside kv
# requierd: Docker
module "letsencrypt_mock" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//letsencrypt_credential?ref=v3.8.1"

  prefix            = var.prefix
  env               = var.env_short
  key_vault_name    = "${local.product}-${var.domain}-kv"
  subscription_name = local.subscription_name
}
