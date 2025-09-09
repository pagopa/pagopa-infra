
resource "azuread_application" "grafana_infinity" {
  display_name = "${local.product}-grafana-infinity"

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }
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

resource "azurerm_role_assignment" "grafana_infinity_viewer" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Cost Management Reader"
  principal_id         = azuread_service_principal.grafana_infinity.object_id
}

resource "grafana_data_source" "infinity" {
  provider    = grafana.cloudinternal
  type        = "yesoreyeram-infinity-datasource"
  name        = "${local.product}-infinity"
  access_mode = "proxy"
  is_default  = true

  json_data_encoded = jsonencode({
    allowedHosts = [
      "https://management.azure.com/"
    ]
    auth_method    = "oauth2"
    global_queries = []
    oauth2 = {
      client_secret = azurerm_key_vault_secret.grafana_infinity.value
      client_id     = azuread_service_principal.grafana_infinity.application_id
      scopes = [
        ""
      ],
      token_url = "https://login.microsoftonline.com/${data.azurerm_subscription.current.tenant_id}/oauth2/token"
    },
    oauth2EndPointParamsName1 = "resource"
  })

  secure_json_data_encoded = jsonencode({
    oauth2ClientSecret         = azurerm_key_vault_secret.grafana_infinity.value
    oauth2EndPointParamsValue1 = "https://management.azure.com/"
  })
}
