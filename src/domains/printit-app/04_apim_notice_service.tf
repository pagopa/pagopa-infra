locals {
  apim_notices_service_pagopa_api = {
    display_name = "Payment Notices Service Product pagoPA"
    description  = "API for Payment Notices"
  }
}


module "apim_notices_service_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v8.5.0"
  count  = var.is_feature_enabled.printit ? 1 : 0

  product_id   = "pagoa_notices_service"
  display_name = local.apim_notices_service_pagopa_api.display_name
  description  = local.apim_notices_service_pagopa_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}