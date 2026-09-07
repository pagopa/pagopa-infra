data "azurerm_resource_group" "sec_rg" {
  name = "${local.product}-${var.domain}-sec-rg"
}


data "azurerm_key_vault" "checkout_kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = data.azurerm_resource_group.sec_rg.name
}