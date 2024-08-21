data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}


# KV placeholder for subkey
#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "forwarder_subscription_key" {
  name         = "pagopa-${var.env_short}-apim-forwarder-key"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "pagopa_smo_email" {
  name         = "pagopa-${var.env_short}-env-operator-email"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}
