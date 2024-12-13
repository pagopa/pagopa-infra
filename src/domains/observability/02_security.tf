data "azurerm_key_vault" "kv" {
  name                = "${local.product}-shared-kv"
  resource_group_name = "${local.product}-shared-sec-rg"
}
data "azurerm_key_vault" "gps_kv" {
  name                = "${local.product}-gps-kv"
  resource_group_name = "${local.product}-gps-sec-rg"
}