resource "azurerm_api_management_api_operation_policy" "payments_api_v1" {
  api_name            = "wisp-converter-redirect-api-v1"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "redirect"

  xml_content = file("./api/wisp-converter/redirect/v1/payments.xml")
}

resource "terraform_data" "sha256_payments_api_v1" {
  input = sha256(file("./api/wisp-converter/redirect/v1/payments.xml"))
}
