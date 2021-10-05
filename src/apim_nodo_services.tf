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

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/v1/nodeForPsp.wsdl")
    wsdl_selector {
      service_name  = "pspForNode_Service"
      endpoint_name = "http://pagopa-api.pagopa.gov.it/nodo/nodeForPsp.wsdl"
    }
  }

}


# resource "azurerm_api_management_api" "broker_api" {
#   name                  = format("%s-broker-api", local.project)
#   resource_group_name   = azurerm_resource_group.rg_api.name
#   api_management_name   = module.apim.name
#   revision              = "1"
#   display_name          = "BROKER"
#   subscription_required = false
#   # Service will respond on path /broker/v1/partner
#   path              = "broker/v1"
#   protocols         = ["http", "https"]
#   service_url       = format("https://%s/partner", module.payments.default_site_hostname)
#   soap_pass_through = true

#   import {
#     content_format = "wsdl-link"
#     content_value  = format("https://%s/partner/partner.wsdl", module.payments.default_site_hostname)
#   }
# }
