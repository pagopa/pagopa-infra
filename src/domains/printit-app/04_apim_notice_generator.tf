locals {
  apim_notices_generator_pagopa_api = {
    display_name = "Payment Notices Generator Product pagoPA"
    description  = "API for Payment Notices Generator"
  }
}

module "apim_notices_generator_product" {
  source = "./.terraform/modules/__v4__/api_management_product"
  count  = var.is_feature_enabled.printit ? 1 : 0

  product_id   = "pagopa_notices_generator"
  display_name = local.apim_notices_generator_pagopa_api.display_name
  description  = local.apim_notices_generator_pagopa_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}
