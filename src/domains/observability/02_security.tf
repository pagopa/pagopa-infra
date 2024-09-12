data "azurerm_key_vault" "kv" {
  name                = "${local.product}-shared-kv"
  resource_group_name = "${local.product}-shared-sec-rg"
}
