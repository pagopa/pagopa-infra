resource "azapi_resource" "wisp_disable_payment_token_timer" {
  count = var.enable_wisp_converter ? 1 : 0

  type = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name = "wisp-disable-payment-token-timer"

  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "[WISP] Logic to disable payment token timer"
      format      = "rawxml"
      value       = file("./api/nodopagamenti_api/wisp/wisp-disable-payment-token-timer.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

resource "azapi_resource" "wisp_receipt_ko" {
  count = var.enable_wisp_converter ? 1 : 0

  type = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name = "wisp-receipt-ko"

  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "[WISP] Logic to send receipt ko"
      format      = "rawxml"
      value       = file("./api/nodopagamenti_api/wisp/wisp-receipt-ko.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}
