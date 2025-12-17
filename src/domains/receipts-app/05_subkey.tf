resource "azurerm_api_management_subscription" "receipt_generator_helpdesk_subkey" {
  count = var.env_short != "p" ? 1 : 0

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  api_id              = module.apim_api_receipts_generator_helpdesk_api_v1.id
  display_name        = "Subscription for Receipt Generator Helpdesk integration tests"
  allow_tracing       = false
  state               = "active"
}

