resource "azuread_application" "printit_app" {
  display_name = "${local.product}-printit"
}

resource "azuread_service_principal" "printit_service_principal" {
  client_id = azuread_application.printit_app.client_id
}

resource "time_rotating" "secret_rotation" {
  rotation_days = 300
}

resource "azuread_application_password" "printit_password" {
  application_id    = azuread_application.printit_app.object_id
  display_name      = "managed by terraform"
  end_date_relative = "8640h" # 360 days
  rotate_when_changed = {
    rotation = time_rotating.secret_rotation.id
  }
}

resource "azurerm_key_vault_secret" "selfcare_service_principal_client_id" {
  name         = "${local.product}-selfcare-client-id"
  value        = azuread_service_principal.printit_service_principal.application_id
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "selfcare_service_principal_client_secret" {
  name         = "${local.product}-selfcare-client-secret"
  value        = azuread_application_password.printit_password.value
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
