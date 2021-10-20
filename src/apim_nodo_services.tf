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

  policy_xml = file("./api_product/nodo_pagamenti_api/activate_nm3.xml")
}

resource "azurerm_api_management_product_api" "apim_nodo_pagamenti_products_psp_c" {
  product_id          = module.apim_nodo_pagamenti_product[0].product_id
  api_name            = resource.azurerm_api_management_api.apim_nodo_pagamenti_api_psp_cli.name # api ref
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
}

resource "azurerm_api_management_product_api" "apim_nodo_pagamenti_products_psp_s" {
  product_id          = module.apim_nodo_pagamenti_product[0].product_id
  api_name            = resource.azurerm_api_management_api.apim_nodo_pagamenti_api_psp_svr.name # api ref
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
}

# resource "azurerm_api_management_product_api" "apim_nodo_pagamenti_products_ec_c" {
#   product_id          = module.apim_nodo_pagamenti_product[0].product_id
#   api_name            = resource.azurerm_api_management_api.apim_nodo_pagamenti_api_ec_cli.name # api ref
#   api_management_name = module.apim.name
#   resource_group_name = azurerm_resource_group.rg_api.name
# }

resource "azurerm_api_management_product_api" "apim_nodo_pagamenti_products_ec_s" {
  product_id          = module.apim_nodo_pagamenti_product[0].product_id
  api_name            = resource.azurerm_api_management_api.apim_nodo_pagamenti_api_ec_svr.name # api ref
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
}

resource "azurerm_api_management_api" "apim_nodo_pagamenti_api_psp_svr" {
  # source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                = format("%s-nodo-pagamenti-psp-svr-api", var.env_short)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  # product_ids           = [module.apim_nodo_pagamenti_product[0].product_id]
  subscription_required = false
  revision              = "1"


  description  = "nodo pagamenti api psp server"
  display_name = "nodo pagamenti api psp server"
  path         = "nodopagamenti/pspsvr/api"
  protocols    = ["https"]

  service_url = null

  soap_pass_through = true

  # wsdl example
  # https://raw.githubusercontent.com/monodot/camel-demos/master/simple-tests/src/main/resources/wsdl/BookService.wsdl
  import {
    content_format = "wsdl-link"
    content_value  = format("https://raw.githubusercontent.com/pagopa/pagopa-infra/PAG-851-devporta-nodo-nm3/src/api/nodopagamenti_api/v1/pspForNode.wsdl")
  }

}

resource "azurerm_api_management_api" "apim_nodo_pagamenti_api_psp_cli" {
  # source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                = format("%s-nodo-pagamenti-psp-cli-api", var.env_short)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  # product_ids           = [module.apim_nodo_pagamenti_product[0].product_id]
  subscription_required = false
  revision              = "1"


  description  = "nodo pagamenti api psp client"
  display_name = "nodo pagamenti api psp client"
  path         = "nodopagamenti/pspcli/api"
  protocols    = ["https"]

  service_url = null

  soap_pass_through = true

  # wsdl example
  # https://raw.githubusercontent.com/monodot/camel-demos/master/simple-tests/src/main/resources/wsdl/BookService.wsdl
  import {
    content_format = "wsdl-link"
    content_value  = format("https://raw.githubusercontent.com/pagopa/pagopa-infra/PAG-851-devporta-nodo-nm3/src/api/nodopagamenti_api/v1/nodeForPsp.wsdl")
  }

}

resource "azurerm_api_management_api" "apim_nodo_pagamenti_api_ec_svr" {
  # source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                = format("%s-nodo-pagamenti-ec-svr-api", var.env_short)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  # product_ids           = [module.apim_nodo_pagamenti_product[0].product_id]
  subscription_required = false
  revision              = "1"


  description  = "nodo pagamenti api ec server"
  display_name = "nodo pagamenti api ec server"
  path         = "nodopagamenti/ecsvr/api"
  protocols    = ["https"]

  service_url = null

  soap_pass_through = true

  # wsdl example
  # https://raw.githubusercontent.com/monodot/camel-demos/master/simple-tests/src/main/resources/wsdl/BookService.wsdl
  import {
    content_format = "wsdl-link"
    content_value  = format("https://raw.githubusercontent.com/pagopa/pagopa-infra/PAG-851-devporta-nodo-nm3/src/api/nodopagamenti_api/v1/paForNode.wsdl")
  }

}

# resource "azurerm_api_management_api" "apim_nodo_pagamenti_api_ec_cli" {
#   # source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

#   name                = format("%s-nodo-pagamenti-ec-cli-api", var.env_short)
#   api_management_name = module.apim.name
#   resource_group_name = azurerm_resource_group.rg_api.name
#   # product_ids           = [module.apim_nodo_pagamenti_product[0].product_id]
#   subscription_required = false
#   revision              = "1"


#   description  = "nodo pagamenti api ec client"
#   display_name = "nodo pagamenti api ec client"
#   path         = "nodopagamenti/eccli/api"
#   protocols    = ["https"]

#   service_url = null

#   soap_pass_through = true

#   # wsdl example
#   # https://raw.githubusercontent.com/monodot/camel-demos/master/simple-tests/src/main/resources/wsdl/BookService.wsdl
#   import {
#     content_format = "wsdl-link"
#     content_value  = format("https://raw.githubusercontent.com/pagopa/pagopa-infra/PAG-851-devporta-nodo-nm3/src/api/nodopagamenti_api/v1/nodeForPsp.wsdl")
#   }

# }
