
resource "azuread_application" "grafana_infinity" {
  display_name = "${local.product}-grafana-infinity"

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }

  owners = [data.azuread_group.adgroup_admin.object_id]
}

resource "azuread_service_principal" "grafana_infinity" {
  application_id = azuread_application.grafana_infinity.application_id
}

resource "azuread_application_password" "grafana_infinity" {
  application_object_id = azuread_application.grafana_infinity.object_id
  display_name          = "GrafanaInfinitySecret"
  end_date              = "2099-01-01T01:02:03Z"
}

resource "azurerm_key_vault_secret" "grafana_infinity" {
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "grafana-infinity-principal-secret"
  value        = azuread_application_password.grafana_infinity.value
}
