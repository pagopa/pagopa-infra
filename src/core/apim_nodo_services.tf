##############
## Products ##
##############

module "apim_nodo_dei_pagamenti_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "nodo"
  display_name = "Nodo dei Pagamenti"
  description  = "Product for Nodo dei Pagamenti"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = var.nodo_pagamenti_subkey_required
  approval_required     = false

  policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
    address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
  })

}

locals {

  api_nodo_product = [
    azurerm_api_management_api.apim_node_for_psp_api_v1.name,
    azurerm_api_management_api.apim_nodo_per_psp_api_v1.name,
    azurerm_api_management_api.apim_node_for_io_api_v1.name,
    azurerm_api_management_api.apim_psp_for_node_api_v1.name,
    azurerm_api_management_api.apim_nodo_per_pa_api_v1.name,
  ]

}

resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api" {
  for_each = toset(local.api_nodo_product)

  api_name            = each.key
  product_id          = module.apim_nodo_dei_pagamenti_product.product_id
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
}

############################
## WS node for psp (NM3) ##
############################
locals {
  apim_node_for_psp_api = {
    display_name          = "Node for PSP WS (NM3)"
    description           = "Web services to support PSP in payment activations, defined in nodeForPsp.wsdl"
    path                  = "nodo/node-for-psp"
    subscription_required = var.nodo_pagamenti_subkey_required
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

  xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v1/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "https://{{urlnodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/webservices/input"
  })
}


resource "azurerm_api_management_api_operation_policy" "nm3_activate_verify_policy" { # activatePaymentNoticeV1 verificatore

  api_name            = resource.azurerm_api_management_api.apim_node_for_psp_api_v1.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "637601f8c257810fc0ecfe01" : var.env_short == "u" ? "61dedb1872975e13800fd7ff" : "61dedafc2a92e81a0c7a58fc"

  #tfsec:ignore:GEN005
  xml_content = file("./api/nodopagamenti_api/nodeForPsp/v1/activate_nm3.xml")
}

resource "azurerm_api_management_api_operation_policy" "nm3_activate_v2_verify_policy" { # activatePaymentNoticeV2 verificatore

  api_name            = resource.azurerm_api_management_api.apim_node_for_psp_api_v1.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "637601f8c257810fc0ecfe06" : var.env_short == "u" ? "636e6ca51a11929386f0b101" : "TODO"

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
    subscription_required = var.nodo_pagamenti_subkey_required
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

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPsp/v1/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "https://{{urlnodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/webservices/input"
  })
}

resource "azurerm_api_management_api_operation_policy" "fdr_policy" {

  api_name            = resource.azurerm_api_management_api.apim_nodo_per_psp_api_v1.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "61e9630cb78e981290d7c74c" : var.env_short == "u" ? "61e96321e0f4ba04a49d1280" : "61e9633eea7c4a07cc7d4811"

  xml_content = file("./api/nodopagamenti_api/nodoPerPsp/v1/fdr_nodoinvia_flussorendicontazione_flow.xml")
}

######################################
## WS nodo per psp richiesta avvisi ##
######################################
locals {
  apim_nodo_per_psp_richiesta_avvisi_api = {
    display_name          = "Nodo per PSP Richiesta Avvisi WS"
    description           = "Web services to support check of pending payments to PSP, defined in nodoPerPspRichiestaAvvisi.wsdl"
    path                  = "nodo/nodo-per-psp-richiesta-avvisi"
    subscription_required = var.nodo_pagamenti_subkey_required
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_psp_richiesta_avvisi_api" {
  name                = format("%s-nodo-per-psp-richiesta-avvisi-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_nodo_per_psp_richiesta_avvisi_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_psp_richiesta_avvisi_api_v1" {
  name                  = format("%s-nodo-per-psp-richiesta-avvisi-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_psp_richiesta_avvisi_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api.id
  version               = "v1"
  service_url           = local.apim_nodo_per_psp_richiesta_avvisi_api.service_url
  revision              = "1"

  description  = local.apim_nodo_per_psp_richiesta_avvisi_api.description
  display_name = local.apim_nodo_per_psp_richiesta_avvisi_api.display_name
  path         = local.apim_nodo_per_psp_richiesta_avvisi_api.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/nodoPerPspRichiestaAvvisi.wsdl")
    wsdl_selector {
      service_name  = "RichiestaAvvisiservice"
      endpoint_name = "PPTPort"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_richiesta_avvisi_policy" {
  api_name            = resource.azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "https://{{urlnodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/webservices/input"
  })

}


######################
## WS nodo for IO   ##
######################
locals {
  apim_node_for_io_api = {
    display_name          = "Node for IO WS"
    description           = "Web services to support activeIO, defined in nodeForIO.wsdl"
    path                  = "nodo/node-for-io"
    subscription_required = var.nodo_pagamenti_subkey_required
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

  xml_content = templatefile("./api/nodopagamenti_api/nodeForIO/v1/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "https://{{urlnodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/webservices/input"
  })

}

resource "azurerm_api_management_api_operation_policy" "activateIO_reservation_policy" {

  api_name            = resource.azurerm_api_management_api.apim_node_for_io_api_v1.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "61dc5018b78e981290d7c176" : var.env_short == "u" ? "61dedb1e72975e13800fd80f" : "61dedb1eea7c4a07cc7d47b8"

  #tfsec:ignore:GEN005
  xml_content = file("./api/nodopagamenti_api/nodeForIO/v1/activateIO_reservation_nm3.xml")
}

############################
## WS psp for node (NM3) ##
############################
locals {
  apim_psp_for_node_api = {
    display_name          = "PSP for Node WS (NM3)"
    description           = "Web services to support payment transaction started on any PagoPA client, defined in pspForNode.wsdl"
    path                  = "nodo/psp-for-node"
    subscription_required = var.nodo_pagamenti_subkey_required
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
    subscription_required = var.nodo_pagamenti_subkey_required
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

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPa/v1/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "https://{{urlnodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/webservices/input"
  })
}

######################
## Nodo per PM API  ##
######################
locals {
  apim_nodo_per_pm_api = {
    display_name          = "Nodo per Payment Manager API"
    description           = "API to support Payment Manager"
    path                  = "nodo/nodo-per-pm"
    subscription_required = var.nodo_pagamenti_subkey_required
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

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

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
  content_value = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "https://{{ip-nodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}"
  })
}

resource "azurerm_api_management_api_operation_policy" "close_payment_api_v1" {
  api_name            = format("%s-nodo-per-pm-api-v1", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = "closePayment"
  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_closepayment_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "https://{{ip-nodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}"
  })
}

module "apim_nodo_per_pm_api_v2" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-nodo-per-pm-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_pm_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api.id
  api_version           = "v2"
  service_url           = local.apim_nodo_per_pm_api.service_url

  description  = local.apim_nodo_per_pm_api.description
  display_name = local.apim_nodo_per_pm_api.display_name
  path         = local.apim_nodo_per_pm_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/nodopagamenti_api/nodoPerPM/v2/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v2/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "https://{{ip-nodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}"
  })
}

######################
## NODO monitoring  ##
######################
locals {
  apim_nodo_monitoring_api = {
    display_name          = "Nodo monitoring "
    description           = "Nodo monitoring"
    path                  = "nodo/monitoring"
    subscription_required = var.nodo_pagamenti_subkey_required
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_monitoring_api" {
  count = var.env_short != "p" ? 1 : 0

  name                = format("%s-nodo-monitoring-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_nodo_monitoring_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_nodo_monitoring_api" {
  count  = var.env_short != "p" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-monitoring-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_dei_pagamenti_product.product_id]
  subscription_required = local.apim_nodo_monitoring_api.subscription_required

  version_set_id = azurerm_api_management_api_version_set.nodo_monitoring_api[0].id
  api_version    = "v1"

  description  = local.apim_nodo_monitoring_api.description
  display_name = local.apim_nodo_monitoring_api.display_name
  path         = local.apim_nodo_monitoring_api.path
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/monitoring/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/monitoring/v1/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "https://{{ip-nodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}"
  })
}
