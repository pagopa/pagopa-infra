resource "azuread_application" "selfcare" {
  display_name = "${local.product}-selfcare"
  owners       = ["c7636d10-4f78-43bd-89f6-555c7d82e02c"]
}

resource "azuread_service_principal" "selfcare" {
  client_id = azuread_application.selfcare.client_id
}

resource "azurerm_role_assignment" "selfcare_apim_contributor" {
  scope                = data.azurerm_api_management.apim.id
  role_definition_name = "API Management Service Contributor"
  principal_id         = azuread_service_principal.selfcare.object_id
}

resource "time_rotating" "selfcare_application" {
  rotation_days = 300
}

resource "azuread_application_password" "selfcare" {
  application_id    = azuread_application.selfcare.id
  display_name      = "managed by terraform"
  end_date_relative = "8640h" # 360 days
  rotate_when_changed = {
    rotation = time_rotating.selfcare_application.id
  }
}

resource "azurerm_key_vault_secret" "selfcare_service_principal_client_id" {
  name         = "${local.product}-selfcare-client-id"
  value        = azuread_service_principal.selfcare.client_id
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "selfcare_service_principal_client_secret" {
  name         = "${local.product}-selfcare-client-secret"
  value        = azuread_application_password.selfcare.value
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}
