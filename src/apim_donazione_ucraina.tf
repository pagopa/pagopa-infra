##############
## Products ##
##############

module "apim_donazioni_ucraina_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.84"

  product_id   = "product-donazioni"
  display_name = "Donazioni Ucraina"
  description  = "Donazioni Ucraina"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}

##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_donazioni_ucraina_api" {
  name                = format("%s-api-donazioni-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "DonazioniUcraina"
  versioning_scheme   = "Segment"
}


resource "azurerm_api_management_api" "apim_api_donazioni_ucraina_api" {
  name                  = format("%s-api-donazioni-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = false
  service_url           = null
  version_set_id        = azurerm_api_management_api_version_set.api_donazioni_ucraina_api.id
  version               = "v1"
  revision              = "1"

  description  = "Donazioni Ucraina"
  display_name = "Donazioni Ucraina"
  path         = "donazioni/api"
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/paForNode/v1/paForNode.wsdl")
    wsdl_selector {
      service_name  = "paForNode_Service"
      endpoint_name = "paForNode_Port"
    }
  }
}
