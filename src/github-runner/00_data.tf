data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-kv"
  resource_group_name = "${local.product}-sec-rg"
}
