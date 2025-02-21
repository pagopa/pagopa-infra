moved {
  from = azurerm_key_vault_key.generated
  to   = azurerm_key_vault_key.sops_key
}

resource "azurerm_key_vault_key" "sops_key" {
  name         = "${local.product}-${var.domain}-sops-key"
  key_vault_id = module.key_vault.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
  ]

  depends_on = [
    azurerm_key_vault_access_policy.adgroup_developers_policy,
    azurerm_key_vault_access_policy.ad_group_policy,
  ]
}
