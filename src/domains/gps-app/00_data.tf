data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = "${local.product}-api-rg"
}

data "azurerm_key_vault" "gps_kv" {
  name                = local.gps_kv
  resource_group_name = local.gps_kv_rg
}