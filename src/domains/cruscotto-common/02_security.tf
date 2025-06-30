#  'pagopa-bo-api-key-value'
data "azurerm_api_management_product" "apim_bo_help_product" {
  product_id          = "selfcare-bo-helpdesk"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
resource "azurerm_api_management_subscription" "apim_bo_help_subscription_key" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_bo_help_product.id
  display_name  = "Subscription key Selfcare Backoffice Helpdesk Product pagoPA for Cruscotto "
  allow_tracing = false
  state         = "active"
}
resource "azurerm_key_vault_secret" "apim_bo_help_subscription_key_kv" {
  depends_on   = [azurerm_api_management_subscription.apim_bo_help_subscription_key]
  name         = "pagopa-bo-api-key-value"
  value        = azurerm_api_management_subscription.apim_bo_help_subscription_key.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

#  'pagopa-cache-api-key-value'
data "azurerm_api_management_product" "apim_cache_product" {
  product_id          = "apiconfig-cache"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
resource "azurerm_api_management_subscription" "apim_cache_subscription_key" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_cache_product.id
  display_name  = "Subscription key ApiCfg Cache for Cruscotto "
  allow_tracing = false
  state         = "active"
}
resource "azurerm_key_vault_secret" "apim_cache_subscription_key_kv" {
  depends_on   = [azurerm_api_management_subscription.apim_cache_subscription_key]
  name         = "pagopa-cache-api-key-value"
  value        = azurerm_api_management_subscription.apim_cache_subscription_key.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}


