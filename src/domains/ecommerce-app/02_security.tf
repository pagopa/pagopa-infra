data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

resource "azurerm_key_vault_secret" "email-confidential-data-encryption-key" {
  name         = "email-confidential-data-encryption-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>" #base64 AES encryption key
  key_vault_id = data.azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}