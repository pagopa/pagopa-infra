resource "azurerm_api_management_subscription" "nodo_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_node_for_psp_product.id
  display_name        = "Subscription MBD Node for PSP APIM"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "carts_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_carts_product.id
  display_name        = "Subscription MBD for Cart APIM"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "payments_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_gpd_payments_rest.id
  display_name        = "Subscription MBD for Payments APIM"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "gps_mbd_service_integration_test_subkey" {
  count               = var.env_short != "p" ? 1 : 0
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_gps_spontaneous_payments_services_product.id
  display_name        = "Subscription GPS MBD Service for Integration Test"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "mbd_service_integration_test_subkey" {
  count               = var.env_short != "p" ? 1 : 0
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = module.apim_mbd_product.id
  display_name        = "Subscription MBD Service for Integration Test"
  allow_tracing       = false
  state               = "active"
}


resource "azurerm_api_management_subscription" "gdp_debt_positions_product_integration_test_subkey" {
  count               = var.env_short != "p" ? 1 : 0
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_gdp_debt_positions_product.id
  display_name        = "Subscription MBD Service for Integration Test to GDP"
  allow_tracing       = false
  state               = "active"
}
