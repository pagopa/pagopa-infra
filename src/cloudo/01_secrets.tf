
data "azurerm_key_vault_secret" "google_client_id" {
  key_vault_id = data.azurerm_key_vault.key_vault.id
  name         = "cloudo-google-client-id"
}