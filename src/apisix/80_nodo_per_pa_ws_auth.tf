module "api_nodo_per_pa_ws_auth" {
  source     = "./modules/api"
  depends_on = [helm_release.apisix]

  admin_token            = data.azurerm_key_vault_secret.admin_apikey.value
  apisix_admin_base_path = local.apisix_admin_base_path

  services = {
    nodo_per_pa_ws_auth = {
      name      = "nodo_per_pa_ws_auth"
      base_path = "/nodo-auth/nodo-per-pa/v1"

      nodes = {
        "10.70.66.200" = 1 # handle it with variables
      }

      scheme = "http"

      plugins = jsonencode({
        key-auth = {
          _meta            = { disabled = false }
          header           = "Ocp-Apim-Subscription-Key"
          hide_credentials = true
        }
        proxy-rewrite = {
          _meta     = { disabled = false }
          regex_uri = ["^/nodo-auth/nodo-per-pa/v1(/.*)?$", "/nodo-sit/webservices/input$1"]
        }
      })
    }
    pagopa_fdr_nodo_service = {
      name      = "pagopa_fdr_nodo_service"
      base_path = "/nodo-auth/nodo-per-pa/v1"

      nodes = {
        "weudev.fdr.internal.dev.platform.pagopa.it" = 1 # handle it with variables
      }

      plugins = jsonencode({
        key-auth = {
          _meta            = { disabled = false }
          header           = "Ocp-Apim-Subscription-Key"
          hide_credentials = true
        }
        proxy-rewrite = {
          _meta     = { disabled = false }
          regex_uri = ["^/nodo-auth/nodo-per-pa/v1(/.*)?$", "/pagopa-fdr-nodo-service/webservices/input$1"]
          host      = "weudev.fdr.internal.dev.platform.pagopa.it"
        }
      })
    }
  }

  routes = [
    {
      name    = "root"
      uris    = ["", "/*"]
      methods = ["POST"]
      service = "nodo_per_pa_ws_auth"
    },
    {
      name    = "root_byhost"
      uris    = ["", "/*"]
      methods = ["POST"]
      service = "nodo_per_pa_ws_auth"
      vars = [
        [
          "OR",
          ["http_Host", "==", "api.prf.platform.pagopa.it"],
          ["http_X-Original-Host-For", "==", "api.prf.platform.pagopa.it"]
        ]
      ]
      priority = 10
    },
    {
      name    = "param_deps"
      uris    = ["", "/*"]
      methods = ["POST"]
      service = "pagopa_fdr_nodo_service"
      desc = "?soapAction has specific values"
      vars = [
        [
          "OR",
          ["arg_soapAction", "IN", ["nodoChiediElencoFlussiRendicontazione", "nodoChiediFlussoRendicontazione"]],
          ["http_SOAPAction", "IN", ["nodoChiediElencoFlussiRendicontazione", "nodoChiediFlussoRendicontazione"]]
        ]
      ]
      priority = 20
    }
  ]
}
