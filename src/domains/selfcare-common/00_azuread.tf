# Azure AD
data "azuread_group" "adgroup_admin" {
  display_name = "${local.product}-adgroup-admin"
}

data "azuread_group" "adgroup_developers" {
  display_name = "${local.product}-adgroup-developers"
}

data "azuread_group" "adgroup_externals" {
  display_name = "${local.product}-adgroup-externals"
}

data "azuread_group" "adgroup_security" {
  display_name = "${local.product}-adgroup-security"
}

resource "azuread_application" "selfcare" {
  display_name = "${local.product}-selfcare"
}

resource "azuread_service_principal" "selfcare" {
  application_id = azuread_application.selfcare.application_id
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
  application_object_id = azuread_application.selfcare.object_id
  display_name          = "managed by terraform"
  end_date_relative     = "8640h" # 360 days
  rotate_when_changed = {
    rotation = time_rotating.selfcare_application.id
  }
}

resource "azurerm_key_vault_secret" "selfcare_service_principal_client_id" {
  name         = "${local.product}-selfcare-client-id"
  value        = azuread_service_principal.selfcare.application_id
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "selfcare_service_principal_client_secret" {
  name         = "${local.product}-selfcare-client-secret"
  value        = azuread_application_password.selfcare.value
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
