data "azurerm_key_vault_secret" "nodo_switcher_static_slack_user_id" {
  name         = "nodo-switcher-static-slack-user-id"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "nodo_switcher_slack_webhook" {
  name         = "nodo-switcher-slack-webhook"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "nodo_switcher_slack_team_id" {
  name         = "nodo-switcher-slack-team-id"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "nodo_switcher_slack_app_id" {
  name         = "nodo-switcher-slack-app-id"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "nodo_switcher_allowed_slack_users" {
  name         = "nodo-switcher-allowed-slack-users"
  key_vault_id = data.azurerm_key_vault.kv.id
}
