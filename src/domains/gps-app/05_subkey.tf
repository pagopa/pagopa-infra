resource "azurerm_api_management_subscription" "iuv_generator_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_iuv_generator_product.id
  display_name        = "Subscription Spontaneous Payments for IUV Generator"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "gps_spontaneous_payments_services_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_gps_spontaneous_payments_services_product.id
  display_name        = "Subscription Spontaneous Payments for Services"
  allow_tracing       = false
  state               = "active"
}
