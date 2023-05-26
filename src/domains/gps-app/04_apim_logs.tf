###############
## APIM Logs ##
###############

locals {
  api_verbose_log = [
    module.apim_api_gpd_api.name,
    # azurerm_api_management_api.apim_api_gpd_payments_api.name,
  ]
}

# api verbose log with request/response body
resource "azurerm_api_management_api_diagnostic" "apim_logs" {
  for_each = toset(local.api_verbose_log)

  identifier                = "applicationinsights"
  resource_group_name       = data.azurerm_resource_group.rg_api.name
  api_management_name       = data.azurerm_api_management.apim.name
  api_name                  = each.key
  api_management_logger_id  = var.apim_logger_resource_id
  sampling_percentage       = 100
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "verbose"
  http_correlation_protocol = "W3C"

  frontend_request {
    body_bytes = 8192
  }

  frontend_response {
    body_bytes = 8192
  }

  backend_request {
    body_bytes = 8192
  }

  backend_response {
    body_bytes = 8192
  }
}
