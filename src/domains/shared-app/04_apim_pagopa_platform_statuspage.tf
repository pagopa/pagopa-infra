##############
## Products ##
##############

module "apim_pagopa_platform_statuspage_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "pagoPAPlatformStatusPage"
  display_name = "pagoPA platform Status Page"
  description  = "Prodotto pagoPA platform Status Page"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_pagopa_platform_statuspage_policy.xml")
}
