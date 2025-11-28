# api logs

locals {

  api_log_response_body = [
    module.apim_ecommerce_checkout_api_v1.name,
  ]
}

# api for which log response body only„
resource "azurerm_api_management_api_diagnostic" "apim_logs_response_body_only" {
  for_each                  = toset(local.api_log_response_body)
  identifier                = "applicationinsights"
  resource_group_name       = local.pagopa_apim_rg
  api_management_name       = local.pagopa_apim_name
  api_name                  = each.key
  api_management_logger_id  = var.apim_logger_resource_id
  sampling_percentage       = 100
  always_log_errors         = false
  log_client_ip             = false
  verbosity                 = "information"
  http_correlation_protocol = "W3C"

  frontend_request {
    body_bytes     = 0
    headers_to_log = []
  }

  frontend_response {
    body_bytes     = 1024
    headers_to_log = []
  }

  backend_request {
    body_bytes     = 0
    headers_to_log = []
  }

  backend_response {
    body_bytes     = 0
    headers_to_log = []
  }
}
