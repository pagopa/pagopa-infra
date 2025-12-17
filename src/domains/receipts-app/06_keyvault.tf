resource "azurerm_key_vault_secret" "receipt_generator_helpdesk_subkey" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "receipt-generator-helpdesk-integration-test-api-key"
  value        = azurerm_api_management_subscription.receipt_generator_helpdesk_subkey[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
