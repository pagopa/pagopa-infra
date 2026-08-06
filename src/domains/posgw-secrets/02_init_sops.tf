moved {
  from = azurerm_key_vault_key.generated
  to   = azurerm_key_vault_key.sops_key
}

resource "azurerm_key_vault_key" "sops_key" {
  name         = "${local.product}-${local.domain}-sops-key"
  key_vault_id = module.key_vault.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
  ]

  depends_on = [
    module.kv_access_policy_admins,
    module.kv_access_policy_admin_dev,
  ]
}
