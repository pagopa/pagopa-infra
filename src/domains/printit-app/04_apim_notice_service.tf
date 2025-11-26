locals {
  apim_notices_service_external_pagopa_api = {
    display_name = "Payment Notices Service Product pagoPA (External)"
    description  = "API for Payment Notices (External)"
  }
  apim_notices_service_internal_pagopa_api = {
    display_name = "Payment Notices Service Product pagoPA (Internal)"
    description  = "API for Payment Notices (Internal)"
  }

}

module "apim_notices_service_product_external" {
  source = "./.terraform/modules/__v3__/api_management_product"
  count  = var.is_feature_enabled.printit ? 1 : 0

  product_id   = "pagopa_notices_service_external"
  display_name = local.apim_notices_service_external_pagopa_api.display_name
  description  = local.apim_notices_service_external_pagopa_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

module "apim_notices_service_product_internal" {
  source = "./.terraform/modules/__v3__/api_management_product"
  count  = var.is_feature_enabled.printit ? 1 : 0

  product_id   = "pagopa_notices_service_internal"
  display_name = local.apim_notices_service_internal_pagopa_api.display_name
  description  = local.apim_notices_service_internal_pagopa_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}
