locals {
  apim_payment_options_pagopa_api = {
    display_name = "Payment Options Product pagoPA"
    description  = "API for Payment Options"
  }
}

module "apim_payment_options_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v8.18.0"
  count  = var.is_feature_enabled.paymentoptions ? 1 : 0

  product_id   = "pagopa_notices_generator"
  display_name = local.apim_payment_options_pagopa_api.display_name
  description  = local.apim_payment_options_pagopa_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}
