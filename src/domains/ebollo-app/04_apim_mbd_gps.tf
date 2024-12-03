locals {
  apim_mbd_gps_pagopa_api = {
    display_name = "MBD GPS Product pagoPA"
    description  = "API for MBD GPS Service"
  }
}

module "apim_mbd_gps_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v8.18.0"

  product_id   = "ebollo-gps-service"
  display_name = local.apim_mdb_pagopa_api.display_name
  description  = local.apim_mdb_pagopa_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}