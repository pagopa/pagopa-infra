data "azurerm_key_vault" "kv" {
  name                = "${local.product}-shared-kv"
  resource_group_name = "${local.product}-shared-sec-rg"
}
data "azurerm_key_vault" "gps_kv" {
  name                = "${local.product}-gps-kv"
  resource_group_name = "${local.product}-gps-sec-rg"
}

data "azurerm_key_vault" "cruscotto_kv" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short_itn}-crusc8-kv"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short_itn}-crusc8-sec-rg"
}