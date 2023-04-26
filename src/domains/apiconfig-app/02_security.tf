data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

resource "azurerm_key_vault_secret" "apiconfig_client_secret" {
  name         = "apiconfig-core-client-secret"
  value        = "TODO" # TODO
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
