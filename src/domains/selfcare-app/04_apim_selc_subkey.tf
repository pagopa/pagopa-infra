##############
## Products ##
##############

module "apim_selfcare_product_subkey" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.7.0"

  product_id   = "selfcare-be-subkey"
  display_name = local.apim_selfcare_pagopa_api_subkey.display_name
  description  = local.apim_selfcare_pagopa_api_subkey.display_name

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = local.apim_selfcare_pagopa_api_subkey.subscription_required
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#################
##    API selfcare ##
#################
locals {
  apim_selfcare_pagopa_api_subkey = {
    display_name          = "Selfcare Product pagoPA subkey"
    description           = "API to manage institution api key"
    path                  = "selfcare/pagopa/subkey"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_selfcare_api_subkey" {

  name                = "${var.env_short}-pagopa-selfcare-api-subkey"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_selfcare_pagopa_api_subkey.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_selfcare_api_subkey_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.7.0"

  name                  = "${local.product}-api-subkey"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_selfcare_product_subkey.product_id]
  subscription_required = local.apim_selfcare_pagopa_api_subkey.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_selfcare_api_subkey.id
  api_version           = "v1"

  description  = local.apim_selfcare_pagopa_api_subkey.description
  display_name = local.apim_selfcare_pagopa_api_subkey.display_name
  path         = local.apim_selfcare_pagopa_api_subkey.path
  protocols    = ["https"]
  service_url  = local.apim_selfcare_pagopa_api_subkey.service_url

  content_format = "openapi"
  content_value = templatefile("./api/pagopa-selfcare-ms-backoffice/subkey/v1/_openapi.json.tpl", {
    host     = local.selfcare_hostname
    basePath = "selfcare"
  })

  xml_content = templatefile("./api/pagopa-selfcare-ms-backoffice/subkey/v1/_base_policy.xml", {
    hostname = local.selfcare_hostname
    origin   = local.selfcare_fe_hostname
  })
}


