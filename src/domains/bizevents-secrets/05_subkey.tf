# internal subscription key for receipt service
resource "azurerm_api_management_subscription" "receipt_service_internal_subkey" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  product_id          = data.azurerm_api_management_product.apim_receipts_internal_product.id
  display_name        = "receipt-service-internal-subkey"
  allow_tracing       = false
  state               = "active"
}


resource "azurerm_key_vault_secret" "receipt_service_internal_subkey_secret" {
  name         = "receiptpdfservice-internal-${var.env_short}-subscription-key"
  value        = azurerm_api_management_subscription.receipt_service_internal_subkey.primary_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.bizevents_kv.id
}
