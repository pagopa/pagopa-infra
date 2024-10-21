module "api_healthcheck" {
  source     = "./modules/api"
  depends_on = [helm_release.apisix]

  admin_token            = data.azurerm_key_vault_secret.admin_apikey.value
  apisix_admin_base_path = local.apisix_admin_base_path

  services = {
    healthcheck = {
      name      = "healthcheck"
      base_path = ""
      scheme    = "http"

      plugins = jsonencode({
        mocking = {
          _meta            = { disabled = false }
          delay            = 0
          content_type     = "text/plain"
          response_status  = 200
          response_example = "OK"
          with_mock_header = false
        }
      })
    }
  }

  routes = [
    {
      name    = "root"
      uris    = ["/healthcheck"]
      methods = ["GET"]
      service = "healthcheck"
    }
  ]
}
