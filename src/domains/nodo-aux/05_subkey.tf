resource "azurerm_api_management_subscription" "nodo_monitoring_product_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_nodo_monitoring_product.id
  display_name        = "Subscription for Nodo Observability"
  allow_tracing       = false
  state               = "active"
  user_id             = data.azurerm_api_management_user.pagoapa_core_user.id
}

resource "azurerm_api_management_subscription" "apiconfig_product_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_apiconfig_auth_product.id
  display_name        = "Subscription for Nodo Observability"
  allow_tracing       = false
  state               = "active"
  user_id             = data.azurerm_api_management_user.pagoapa_core_user.id
}