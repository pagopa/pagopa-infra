data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}


data "azurerm_key_vault" "kv_core" {
  name                = "${local.product}-kv"
  resource_group_name = "${local.product}-sec-rg"
}


