##############
## Products ##
##############

module "apim_nodo_pagamenti_product" {
  count  = var.nodo_pagamenti_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "product-nodo-pagamenti"
  display_name = "product-nodo-pagamenti"
  description  = "product-nodo-pagamenti"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}

resource "azurerm_api_management_product_api" "apim_nodo_pagamenti_products" {
  product_id          = module.apim_nodo_pagamenti_product[0].product_id
  api_name            = resource.azurerm_api_management_api.apim_nodo_pagamenti_api.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
}

resource "azurerm_api_management_api" "apim_nodo_pagamenti_api" {
  # source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                = format("%s-nodo-pagamenti-api", var.env_short)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  # product_ids           = [module.apim_nodo_pagamenti_product[0].product_id]
  subscription_required = false
  revision              = "1"


  description  = "nodo pagamenti api"
  display_name = "nodo pagamenti api"
  path         = "nodopagamenti/api"
  protocols    = ["https"]

  service_url = null

  soap_pass_through = true

  # wsdl example
  # https://raw.githubusercontent.com/monodot/camel-demos/master/simple-tests/src/main/resources/wsdl/BookService.wsdl
  import {
    content_format = "wsdl-link"
    content_value  = format("https://raw.githubusercontent.com/pasqualespica/pagopa-api/develop/psp/pspForNode.wsdl")
  }

}
