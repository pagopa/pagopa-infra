locals {
  apim_mbd_pagopa_api = {
    display_name = "RMBD Product pagoPA"
    description  = "API for Rendicontazione Marca Bollo Digitale"
  }
}

module "apim_mbd_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "pagopa_mbd"
  display_name = local.apim_mbd_pagopa_api.display_name
  description  = local.apim_mbd_pagopa_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}
