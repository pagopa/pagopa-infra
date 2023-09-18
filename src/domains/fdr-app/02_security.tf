data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

data "azurerm_key_vault_secret" "fdr_internal_product_subscription_key" {
  name         = "fdr-internal-product-subscription-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}
