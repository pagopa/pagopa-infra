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

data "azurerm_key_vault" "network_kv" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-network-kv"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-network-sec-rg"
}

data "azurerm_key_vault" "nodo_kv" {
  name                = "${var.prefix}-${var.env_short}-nodo-kv"
  resource_group_name = "${var.prefix}-${var.env_short}-nodo-sec-rg"
}

data "azurerm_key_vault" "qi-kv" {
  name                = "${var.prefix}-${var.env_short}-qi-kv"
  resource_group_name = "${var.prefix}-${var.env_short}-qi-sec-rg"
}
