##############
## Products ##
##############

module "apim_selc_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "selfcare-be"
  display_name = local.apim_selfcare_pagopa_api.display_name
  description  = local.apim_selfcare_pagopa_api.display_name

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#################
##    API SELC ##
#################
locals {
  apim_selfcare_pagopa_api = {
    display_name          = "Selfcare Product pagoPA"
    description           = "API to manage institution api key"
    path                  = "selc/pagopa"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_selc_api" {

  name                = format("%s-pagopa-selc-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_selfcare_pagopa_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_selc_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-pagopa-selc-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_selc_product.product_id]
  subscription_required = local.apim_selfcare_pagopa_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_selc_api.id
  api_version           = "v1"

  description  = local.apim_selfcare_pagopa_api.description
  display_name = local.apim_selfcare_pagopa_api.display_name
  path         = local.apim_selfcare_pagopa_api.path
  protocols    = ["https"]
  service_url  = local.apim_selfcare_pagopa_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/pagopa-selfcare-ms-backoffice/v1/_openapi.json.tpl", {
    host = local.selc_hostname
    basePath = "selc"
  })

  xml_content = templatefile("./api/pagopa-selfcare-ms-backoffice/v1/_base_policy.xml", {
    hostname = local.selc_hostname
    origin = local.selc_fe_hostname
  })
}
