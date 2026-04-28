##############
## Products ##
##############

module "apim_mock_ec_pagopa_product" {
  source = "./.terraform/modules/__v3__/api_management_product"
  count  = var.env_short != "p" ? 1 : 0

  product_id   = "mock_ec_pagopa"
  display_name = "Mock EC for PagoPA"
  description  = "Mock EC for PagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 0

  policy_xml = file("./api_product/mock-ec-pagopa/_base_policy.xml")
}
