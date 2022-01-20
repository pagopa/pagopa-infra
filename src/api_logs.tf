# api logs

locals {

  api_verbose_log = [
    module.apim_checkout_payments_api_v1[0].name,
    azurerm_api_management_api.apim_node_for_psp_api_v1.name,
    azurerm_api_management_api.apim_nodo_per_psp_api_v1.name,
    azurerm_api_management_api.apim_node_for_io_api_v1.name,
    azurerm_api_management_api.apim_psp_for_node_api_v1.name,
    azurerm_api_management_api.apim_nodo_per_pa_api_v1.name,
    azurerm_api_management_api.apim_cd_info_wisp_v1.name
  ]

}

# api log
resource "azurerm_api_management_api_diagnostic" "apim_logs" {
  for_each = toset(local.api_verbose_log)

  identifier               = "applicationinsights"
  resource_group_name      = azurerm_resource_group.rg_api.name
  api_management_name      = module.apim.name
  api_name                 = each.key
  api_management_logger_id = module.apim.logger_id

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
