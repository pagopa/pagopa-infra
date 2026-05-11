locals {
  apim_mdb_pagopa_api = {
    display_name = "MBD - Servizio @e.bollo"
    description  = "API for @e.bollo service"
  }
}

module "apim_mbd_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "pagopa_ebollo"
  display_name = local.apim_mdb_pagopa_api.display_name
  description  = local.apim_mdb_pagopa_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}
