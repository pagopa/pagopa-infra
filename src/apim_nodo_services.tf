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

#tfsec:ignore:general-secrets-sensitive-in-attribute-value
resource "azurerm_api_management_api_policy" "apim_nodo_pagamenti_api_psp_cli_policy" {
  api_name            = resource.azurerm_api_management_api.apim_nodo_pagamenti_api_psp_cli.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = file("./api/nodopagamenti_api/v1/activate_nm3.xml")

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

############################
## WS node for psp (NM3) ##
############################
locals {
  apim_node_for_psp_api = {
    display_name          = "Node for PSP WS (NM3)"
    description           = "Web services to support PSP in payment activations, defined in nodeForPsp.wsdl"
    path                  = "api/node-for-psp"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "node_for_psp_api" {
  name                = format("%s-node-for-psp-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_node_for_psp_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_psp_api_v1" {
  name                  = format("%s-node-for-psp-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_node_for_psp_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_psp_api.id
  version               = "v1"
  service_url           = local.apim_node_for_psp_api.service_url
  revision              = "1"

  description  = local.apim_node_for_psp_api.description
  display_name = local.apim_node_for_psp_api.display_name
  path         = local.apim_node_for_psp_api.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodeForPsp/v1/nodeForPsp.wsdl")
    wsdl_selector {
      service_name  = "nodeForPsp_Service"
      endpoint_name = "nodeForPsp_Port"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_node_for_psp_policy" {
  api_name            = resource.azurerm_api_management_api.apim_node_for_psp_api_v1.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = file("./api/nodopagamenti_api/nodeForPsp/v1/_base_policy.xml")
}

######################
## WS nodo per psp ##
######################
locals {
  apim_nodo_per_psp_api = {
    display_name          = "Nodo per PSP WS"
    description           = "Web services to support PSP in payment activations, defined in nodoPerPsp.wsdl"
    path                  = "api/nodo-per-psp"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_psp_api" {
  name                = format("%s-nodo-per-psp-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_nodo_per_psp_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_psp_api_v1" {
  name                  = format("%s-nodo-per-psp-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_psp_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_api.id
  version               = "v1"
  service_url           = local.apim_nodo_per_psp_api.service_url
  revision              = "1"

  description  = local.apim_nodo_per_psp_api.description
  display_name = local.apim_nodo_per_psp_api.display_name
  path         = local.apim_nodo_per_psp_api.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodoPerPsp/v1/nodoPerPsp.wsdl")
    wsdl_selector {
      service_name  = "PagamentiTelematiciPspNodoservice"
      endpoint_name = "PPTPort"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_policy" {
  api_name            = resource.azurerm_api_management_api.apim_nodo_per_psp_api_v1.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = file("./api/nodopagamenti_api/nodoPerPsp/v1/_base_policy.xml")
}

######################
## WS nodo for IO   ##
######################
locals {
  apim_node_for_io_api = {
    display_name          = "Node for IO WS"
    description           = "Web services to support activeIO, defined in nodeForIO.wsdl"
    path                  = "api/node-for-io"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "node_for_io_api" {
  name                = format("%s-nodo-for-io-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_node_for_io_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_io_api_v1" {
  name                  = format("%s-node-for-io-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_node_for_io_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_io_api.id
  version               = "v1"
  service_url           = local.apim_node_for_io_api.service_url
  revision              = "1"

  description  = local.apim_node_for_io_api.description
  display_name = local.apim_node_for_io_api.display_name
  path         = local.apim_node_for_io_api.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodeForIO/v1/nodeForIO.wsdl")
    wsdl_selector {
      service_name  = "nodeForIO_Service"
      endpoint_name = "nodeForIO_Port"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_node_for_io_policy" {
  api_name            = resource.azurerm_api_management_api.apim_node_for_io_api_v1.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = file("./api/nodopagamenti_api/nodeForIO/v1/_base_policy.xml")
}
