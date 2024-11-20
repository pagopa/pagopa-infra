data "azurerm_api_management" "apim" {
  name                = "${var.prefix}-${var.env_short}-apim"
  resource_group_name = "${var.prefix}-${var.env_short}-api-rg"
}

data "azurerm_api_management_product" "apim_node_for_psp_product" {
  product_id          = "${var.env_short}-node-for-psp-api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management_product" "apim_carts_product" {
  product_id          = "pagopa-${var.env_short}-carts-auth-api-v1"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management_product" "apim_gpd_payments_rest" {
  product_id          = "${var.env_short}-gpd-payments-rest-api-aks-v1"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
