resource "azurerm_api_management_subscription" "apiconfig_cache_for_rtp_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = module.apim_apiconfig_cache_product.id
  display_name        = "ApiConfig Cache for RTP"
  allow_tracing       = false
  state               = "active"
}
