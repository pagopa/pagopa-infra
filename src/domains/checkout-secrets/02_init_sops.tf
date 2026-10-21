resource "azurerm_key_vault_key" "sops_key" {
  name         = "${local.product}-${var.domain}-sops-key"
  key_vault_id = data.azurerm_key_vault.checkout_kv.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
  ]
}
