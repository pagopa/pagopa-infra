resource "azuread_application" "pdf_generator" {
  display_name = "${local.project}-pdf-generator"
}

resource "azuread_service_principal" "pdf_generator" {
  client_id = azuread_application.pdf_generator.client_id
}

resource "azurerm_role_assignment" "pdf_generator" {
  scope                = data.azurerm_storage_account.notices.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.pdf_generator.object_id
}

resource "azurerm_role_assignment" "pdf_generator_delegator_role" {
  scope                = data.azurerm_storage_account.notices.id
  role_definition_name = "Storage Blob Delegator"
  principal_id         = azuread_service_principal.pdf_generator.object_id
}

resource "time_rotating" "pdf_generator_application" {
  rotation_days = 300
}

resource "azuread_application_password" "pdf_generator" {
  application_id    = azuread_application.pdf_generator.id
  display_name      = "managed by terraform"
  end_date_relative = "8640h" # 360 days
  rotate_when_changed = {
    rotation = time_rotating.pdf_generator_application.id
  }
}

resource "azurerm_key_vault_secret" "pdf_generator_service_principal_client_id" {
  name         = "pdf-generator-client-id"
  value        = azuread_service_principal.pdf_generator.application_id
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv_printit.id
}

resource "azurerm_key_vault_secret" "pdf_generator_service_principal_client_secret" {
  name         = "pdf-generator-client-secret"
  value        = azuread_application_password.pdf_generator.value
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv_printit.id
}
