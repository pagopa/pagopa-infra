data "azurerm_api_management_product" "apim_notices_product" {
  product_id          = "pagopa_notices_service_internal"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

resource "azurerm_api_management_subscription" "notices_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_notices_product.id
  display_name        = "Subscription for Notices APIM"
  allow_tracing       = false
  state               = "active"
}


resource "azurerm_key_vault_secret" "notices_subscription_key" {
  name         = "pagopa-${var.env_short}-apim-notices-key"
  value        = azurerm_api_management_subscription.notices_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id

}
