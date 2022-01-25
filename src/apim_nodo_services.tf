############################
## WS node for psp (NM3) ##
############################
locals {
  apim_node_for_psp_api = {
    display_name          = "Node for PSP WS (NM3)"
    description           = "Web services to support PSP in payment activations, defined in nodeForPsp.wsdl"
    path                  = "nodo/node-for-psp"
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


resource "azurerm_api_management_api_operation_policy" "nm3_activate_verify_policy" {

  api_name            = resource.azurerm_api_management_api.apim_node_for_psp_api_v1.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "61d70973b78e982064458676" : var.env_short == "u" ? "61dedb1872975e13800fd7ff" : "61dedafc2a92e81a0c7a58fc"

  #tfsec:ignore:GEN005
  xml_content = file("./api/nodopagamenti_api/nodeForPsp/v1/activate_nm3.xml")
}

######################
## WS nodo per psp ##
######################
locals {
  apim_nodo_per_psp_api = {
    display_name          = "Nodo per PSP WS"
    description           = "Web services to support PSP in payment activations, defined in nodoPerPsp.wsdl"
    path                  = "nodo/nodo-per-psp"
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
    path                  = "nodo/node-for-io"
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


############################
## WS psp for node (NM3) ##
############################
locals {
  apim_psp_for_node_api = {
    display_name          = "PSP for Node WS (NM3)"
    description           = "Web services to support payment transaction started on any PagoPA client, defined in pspForNode.wsdl"
    path                  = "nodo/psp-for-node"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "psp_for_node_api" {
  name                = format("%s-psp-for-node-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_psp_for_node_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_psp_for_node_api_v1" {
  name                  = format("%s-psp-for-node-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_psp_for_node_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.psp_for_node_api.id
  version               = "v1"
  service_url           = local.apim_psp_for_node_api.service_url
  revision              = "1"

  description  = local.apim_psp_for_node_api.description
  display_name = local.apim_psp_for_node_api.display_name
  path         = local.apim_psp_for_node_api.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/pspForNode/v1/pspForNode.wsdl")
    wsdl_selector {
      service_name  = "pspForNode_Service"
      endpoint_name = "pspForNode_Port"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_psp_for_node_policy" {
  api_name            = resource.azurerm_api_management_api.apim_psp_for_node_api_v1.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = file("./api/nodopagamenti_api/pspForNode/v1/_base_policy.xml")
}


######################
## WS nodo per PA ##
######################
locals {
  apim_nodo_per_pa_api = {
    display_name          = "Nodo per PA WS"
    description           = "Web services to support PA in payment activations, defined in nodoPerPa.wsdl"
    path                  = "nodo/nodo-per-pa"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_pa_api" {
  name                = format("%s-nodo-per-pa-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_nodo_per_pa_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_pa_api_v1" {
  name                  = format("%s-nodo-per-pa-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_pa_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pa_api.id
  version               = "v1"
  service_url           = local.apim_nodo_per_pa_api.service_url
  revision              = "1"

  description  = local.apim_nodo_per_pa_api.description
  display_name = local.apim_nodo_per_pa_api.display_name
  path         = local.apim_nodo_per_pa_api.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodoPerPa/v1/NodoPerPa.wsdl")
    wsdl_selector {
      service_name  = "PagamentiTelematiciRPTservice"
      endpoint_name = "PagamentiTelematiciRPTPort"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_nodo_per_pa_policy" {
  api_name            = resource.azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = file("./api/nodopagamenti_api/nodoPerPa/v1/_base_policy.xml")
}

######################
## Nodo per PM API  ##
######################
locals {
  apim_nodo_per_pm_api = {
    display_name          = "Nodo per Payment Manager API"
    description           = "API to support Payment Manager"
    path                  = "nodo/nodo-per-pm"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_pm_api" {

  name                = format("%s-nodo-per-pm-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_nodo_per_pm_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_nodo_per_pm_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-nodo-per-pm-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_pm_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api.id
  api_version           = "v1"
  service_url           = local.apim_nodo_per_pm_api.service_url

  description  = local.apim_nodo_per_pm_api.description
  display_name = local.apim_nodo_per_pm_api.display_name
  path         = local.apim_nodo_per_pm_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/nodopagamenti_api/nodoPerPM/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/_base_policy.xml.tpl", {
    restapi-ip-filter = data.azurerm_key_vault_secret.pm_restapi_ip.value
  })
}