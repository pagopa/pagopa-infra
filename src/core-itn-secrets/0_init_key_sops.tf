data "azurerm_key_vault" "kv" {
  name                = local.key_vault_name
  resource_group_name = local.key_vault_rg_name
}

resource "azurerm_key_vault_key" "generate_key_sops" {
  name         = "${local.product}-${var.domain}-sops-key"
  key_vault_id = data.azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
  ]

}
