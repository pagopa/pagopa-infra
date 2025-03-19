locals {
  apim_gps_spontaneous_payments_services_pagopa_api = {
    display_name = "GPS Spontaneous Payments Services Product pagoPA"
    description  = "API for Spontaneous Payments Services"
  }
}

module "apim_gps_spontaneous_payments_services_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "gps-spontaneous-payments-services"
  display_name = local.apim_gps_spontaneous_payments_services_pagopa_api.display_name
  description  = local.apim_gps_spontaneous_payments_services_pagopa_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy_no_forbid.xml")
}
