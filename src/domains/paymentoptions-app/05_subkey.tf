resource "azurerm_api_management_subscription" "api_config_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_api_config_product.id
  display_name        = "Subscription for Api Config APIM"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "forwarder_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_forwarder_product.id
  display_name        = "Subscription for Forwarder APIM"
  allow_tracing       = false
  state               = "active"
}
