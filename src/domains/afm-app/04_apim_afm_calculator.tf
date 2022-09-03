#############################
## Product AFM Calculator ##
#############################

module "apim_afm_calculator_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "afm-calculator"
  display_name = "GEC pagoPA - Calcolatrice"
  description  = "Prodotto Gestione Evoluta Commissioni - Calcolo delle commissioni"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/calculator/_base_policy.xml")
}

###########################
##  API AFM Calculator  ##
###########################
locals {
  apim_afm_calculator_service_api = {
    display_name          = "AFM Calculator pagoPA - calculator of advanced fees management service API"
    description           = "Calculator API to support advanced fees management service"
    path                  = "afm/calculator-service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_afm_calculator_api" {

  name                = format("%s-afm-calculator-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_afm_calculator_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_afm_calculator_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-afm-calculator-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_afm_calculator_product.product_id]
  subscription_required = local.apim_afm_calculator_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_afm_calculator_api.id
  api_version           = "v1"

  description  = local.apim_afm_calculator_service_api.description
  display_name = local.apim_afm_calculator_service_api.display_name
  path         = local.apim_afm_calculator_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_afm_calculator_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/calculator-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/calculator-service/v1/_base_policy.xml", {
    hostname = local.afm_hostname
  })
}
