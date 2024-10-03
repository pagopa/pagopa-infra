locals {
  apim_payment_options_mock_pagopa_api = {
    display_name = "Payment Options Mock Product pagoPA"
    description  = "Mocked API for Payment Options"
  }
}

module "apim_payment_options_mock_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v8.18.0"
  count  = var.is_feature_enabled.paymentoptions_mock ? 1 : 0

  product_id   = "pagopa_payment_options_mock"
  display_name = local.apim_payment_options_pagopa_api.display_name
  description  = local.apim_payment_options_pagopa_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "payment_options_mock_api" {

  name                = format("%s-payment-options-mock-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "Payment Options Mock"
  versioning_scheme   = "Segment"
}


module "apim_api_pay_opt_mock_api" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.4.1"

  name                  = format("%s-pay-opt-mock-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_payment_options_mock_product[0].product_id]
  subscription_required = false
  version_set_id        = azurerm_api_management_api_version_set.payment_options_mock_api.id

  description  = "Payment Options Mock"
  display_name = "payment-options-mock-api"
  path         = "payopt-mock"
  protocols    = ["https"]
  service_url  = null

  content_format = "openapi"
  content_value = templatefile("./api/payment-options-mock/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/payment-options-mock/_base_policy.xml", {
    hostname = local.hostname
  })

  api_operation_policies = [
    {
      operation_id = "get-payment-options",
      xml_content = templatefile("./api/payment-options-mock/_get_payment_options_policy.xml", {
        hostname = local.hostname
      })
    },
  ]

}
