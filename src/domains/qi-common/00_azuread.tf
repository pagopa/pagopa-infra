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

data "azuread_group" "adgroup_operations" {
  display_name = "${local.product}-adgroup-operations"
}

# Acccording to
# Application Insights API Keys are deprecated and will be retired in March 2026. Please consider using API Accesss with Azure AD. Learn more about API Access with Azure AD
# https://learn.microsoft.com/en-us/azure/azure-monitor/app/azure-ad-authentication?tabs=aspnetcore

resource "azuread_application" "qi_app" {
  display_name = "${local.product}-qi"
  owners       = ["c7636d10-4f78-43bd-89f6-555c7d82e02c"]
  lifecycle {
    ignore_changes = [
      owners
    ]
  }
}

resource "azuread_service_principal" "qi_sp" {
  client_id = azuread_application.qi_app.client_id
}

# https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#role-based-access-control-administrator
resource "azurerm_role_assignment" "qi_monitoring_reader" {
  scope = data.azurerm_subscription.current.id
  #  https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles/monitor#monitoring-reader
  role_definition_name = "Monitoring Reader"
  principal_id         = azuread_service_principal.qi_sp.object_id
}

resource "time_rotating" "qi_application_time" {
  rotation_days = 300
}

resource "azuread_application_password" "qi_app_pwd" {
  application_id    = azuread_application.qi_app.id
  display_name      = "managed by terraform"
  end_date_relative = "8640h" # 360 days
  rotate_when_changed = {
    rotation = time_rotating.qi_application_time.id
  }
}

resource "azurerm_key_vault_secret" "qi_service_principal_client_id" {
  name         = "${local.product}-qi-client-id"
  value        = azuread_service_principal.qi_sp.client_id
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "qi_service_principal_client_secret" {
  name         = "${local.product}-qi-client-secret"
  value        = azuread_application_password.qi_app_pwd.value
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
