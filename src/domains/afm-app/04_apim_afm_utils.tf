# named-values

resource "azurerm_api_management_named_value" "afm_utils_sub_key_internal" {
  name                = "afm-utils-sub-key-internal"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "afm-utils-sub-key-internal"
  value               = "<TO_UPDATE_MANUALLY_BY_PORTAL>"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#############################
## Product AFM Calculator ##
#############################

module "apim_afm_utils_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "afm-utils"
  display_name = "GEC pagoPA - AFM Utility"
  description  = "Prodotto Gestione Evoluta Commissioni - AFM Utility"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = local.apim_afm_utils_service_api.subscription_required
  approval_required     = false

  policy_xml = file("./api_product/afm_utils/_base_policy.xml")
}

###############################
##  API AFM Utils ##
###############################
locals {
  apim_afm_utils_service_api = {
    display_name          = "AFM Utils pagoPA - utility for calculator of advanced fees management service API"
    description           = "Data Calculator API to support advanced fees management service"
    path                  = "afm/utils-service"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_afm_utils_api" {

  name                = format("%s-afm-utils-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_afm_utils_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_afm_utils_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-afm-utils-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_afm_utils_product.product_id]
  subscription_required = local.apim_afm_utils_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_afm_utils_api.id
  api_version           = "v1"

  description  = local.apim_afm_utils_service_api.description
  display_name = local.apim_afm_utils_service_api.display_name
  path         = local.apim_afm_utils_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_afm_utils_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/afm-utils-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/afm-utils-service/v1/_base_policy.xml", {
    hostname = local.afm_hostname
  })
}
