locals {
  apim_cruscotto_ingestor_pagopa_api = {
    display_name = "Cruscotto Ingestor Product pagoPA backend service"
    description  = "Cruscotto Ingestor Product pagoPA backend service"
  }
}

module "apim_cruscotto_ingestor_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "pagopa-smo-cruscotto-ingestor"
  display_name = local.apim_cruscotto_ingestor_pagopa_api.display_name
  description  = local.apim_cruscotto_ingestor_pagopa_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 0 # false

  policy_xml = file("./api_product/_base_policy.xml")
}
