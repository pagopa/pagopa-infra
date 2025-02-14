data "azurerm_api_management" "apim" {
  name                = "${var.prefix}-${var.env_short}-apim"
  resource_group_name = "${var.prefix}-${var.env_short}-api-rg"
}

data "azurerm_api_management_product" "apim_node_for_psp_product" {
  product_id          = "nodo-auth"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management_product" "apim_carts_product" {
  product_id          = "checkout-carts"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management_product" "apim_gpd_payments_rest" {
  product_id          = "gpd-payments-rest-aks"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management_product" "apim_gps_spontaneous_payments_services_product" {
  product_id          = "gps-spontaneous-payments-services"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

data "azurerm_api_management_product" "apim_gdp_debt_positions_product" {
  product_id          = "test-gpd-payments-pull-and-debt-positions"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
