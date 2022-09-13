#############################
## Product AFM Calculator ##
#############################

module "apim_afm_calculator_data_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "afm-calculator-data"
  display_name = "GEC pagoPA - Calcolatrice Dati"
  description  = "Prodotto Gestione Evoluta Commissioni - Dati delle commissioni"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/calculator_data/_base_policy.xml")
}

###############################
##  API AFM Calculator Data  ##
###############################
locals {
  apim_afm_calculator_data_service_api = {
    display_name          = "AFM Calculator Data pagoPA - data for calculator of advanced fees management service API"
    description           = "Data Calculator API to support advanced fees management service"
    path                  = "afm/calculator-data-service"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_afm_calculator_data_api" {

  name                = format("%s-afm-calculator-data-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_afm_calculator_data_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_afm_calculator_data_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-afm-calculator-data-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_afm_calculator_data_product.product_id]
  subscription_required = local.apim_afm_calculator_data_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_afm_calculator_data_api.id
  api_version           = "v1"

  description  = local.apim_afm_calculator_data_service_api.description
  display_name = local.apim_afm_calculator_data_service_api.display_name
  path         = local.apim_afm_calculator_data_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_afm_calculator_data_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/calculator-data-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/calculator-data-service/v1/_base_policy.xml", {
    hostname = local.afm_hostname
  })
}
