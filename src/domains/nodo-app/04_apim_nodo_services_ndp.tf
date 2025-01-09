##############
## Products ##
##############

module "apim_nodo_dei_pagamenti_product_ndp" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "nodo-ndp"
  display_name = "Nodo dei Pagamenti NDP"
  description  = "Product for Nodo dei Pagamenti NDP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = var.nodo_ndp_subscription_limit

  policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
    address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
  })
}

locals {

  api_nodo_product_ndp = [
    azurerm_api_management_api.apim_node_for_psp_api_v1_ndp.name,
    azurerm_api_management_api.apim_nodo_per_psp_api_v1_ndp.name,
    azurerm_api_management_api.apim_node_for_io_api_v1_ndp.name,
    azurerm_api_management_api.apim_psp_for_node_api_v1_ndp.name,
    azurerm_api_management_api.apim_nodo_per_pa_api_v1_ndp.name,
    azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_ndp.name,
    module.apim_nodo_per_pm_api_v1_ndp.name,
    module.apim_nodo_per_pm_api_v2_ndp.name,
  ]

}

resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_ndp" {
  for_each = toset(local.api_nodo_product_ndp)

  api_name            = each.key
  product_id          = module.apim_nodo_dei_pagamenti_product_ndp.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

############################
## WS node for psp (NM3) ##
############################
locals {
  apim_node_for_psp_api_ndp = {
    display_name          = "Node for PSP WS (NM3) NDP"
    description           = "Web services to support PSP in payment activations, defined in nodeForPsp.wsdl"
    path                  = "nodo-ndp/node-for-psp"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "node_for_psp_api_ndp" {
  name                = format("%s-node-for-psp-api-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_node_for_psp_api_ndp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_psp_api_v1_ndp" {
  name                  = format("%s-node-for-psp-api-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_node_for_psp_api_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_psp_api_ndp.id
  version               = "v1"
  service_url           = local.apim_node_for_psp_api_ndp.service_url
  revision              = "1"

  description  = local.apim_node_for_psp_api_ndp.description
  display_name = local.apim_node_for_psp_api_ndp.display_name
  path         = local.apim_node_for_psp_api_ndp.path
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

resource "azurerm_api_management_api_policy" "apim_node_for_psp_policy_ndp" {
  api_name            = resource.azurerm_api_management_api.apim_node_for_psp_api_v1_ndp.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo/webservices/input"
  })
}


resource "azurerm_api_management_api_operation_policy" "nm3_activate_verify_policy_ndp" {

  api_name            = resource.azurerm_api_management_api.apim_node_for_psp_api_v1_ndp.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = local.activate_identifier[var.env]

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v1/activate_nm3.xml", {
    base-url   = "https://${local.nodo_hostname}/nodo/webservices/input"
    urlenvpath = var.env_short
    url_aks    = var.env_short == "p" ? "weu${var.env}.apiconfig.internal.platform.pagopa.it" : "weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"
  })
}

resource "azurerm_api_management_api_operation_policy" "nm3_activate_v2_verify_policy_ndp" { # activatePaymentNoticeV2 verificatore

  api_name            = resource.azurerm_api_management_api.apim_node_for_psp_api_v1_ndp.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = local.activate_v2_identifier[var.env]

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v2/activate_nm3.xml", {
    base-url                  = "https://${local.nodo_hostname}/nodo/webservices/input"
    urlenvpath                = var.env_short
    is-nodo-decoupler-enabled = false
    url_aks                   = var.env_short == "p" ? "weu${var.env}.apiconfig.internal.platform.pagopa.it" : "weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"
  })
}

######################
## WS nodo per psp ##
######################
locals {
  apim_nodo_per_psp_api_ndp = {
    display_name          = "Nodo per PSP WS NDP"
    description           = "Web services to support PSP in payment activations, defined in nodoPerPsp.wsdl"
    path                  = "nodo-ndp/nodo-per-psp"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_psp_api_ndp" {
  name                = format("%s-nodo-per-psp-api-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_nodo_per_psp_api_ndp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_psp_api_v1_ndp" {
  name                  = format("%s-nodo-per-psp-api-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_nodo_per_psp_api_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_api_ndp.id
  version               = "v1"
  service_url           = local.apim_nodo_per_psp_api_ndp.service_url
  revision              = "1"

  description  = local.apim_nodo_per_psp_api_ndp.description
  display_name = local.apim_nodo_per_psp_api_ndp.display_name
  path         = local.apim_nodo_per_psp_api_ndp.path
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

resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_policy_ndp" {
  api_name            = resource.azurerm_api_management_api.apim_nodo_per_psp_api_v1_ndp.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPsp/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo/webservices/input"
  })
}


######################################
## WS nodo per psp richiesta avvisi ##
######################################
locals {
  apim_nodo_per_psp_richiesta_avvisi_api_ndp = {
    display_name          = "Nodo per PSP Richiesta Avvisi WS NDP"
    description           = "Web services to support check of pending payments to PSP, defined in nodoPerPspRichiestaAvvisi.wsdl"
    path                  = "nodo-ndp/nodo-per-psp-richiesta-avvisi"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_psp_richiesta_avvisi_api_ndp" {
  name                = format("%s-nodo-per-psp-richiesta-avvisi-api-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_nodo_per_psp_richiesta_avvisi_api_ndp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_psp_richiesta_avvisi_api_v1_ndp" {
  name                  = format("%s-nodo-per-psp-richiesta-avvisi-api-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_nodo_per_psp_richiesta_avvisi_api_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api_ndp.id
  version               = "v1"
  service_url           = local.apim_nodo_per_psp_richiesta_avvisi_api_ndp.service_url
  revision              = "1"

  description  = local.apim_nodo_per_psp_richiesta_avvisi_api_ndp.description
  display_name = local.apim_nodo_per_psp_richiesta_avvisi_api_ndp.display_name
  path         = local.apim_nodo_per_psp_richiesta_avvisi_api_ndp.path
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

resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_richiesta_avvisi_policy_ndp" {
  api_name            = resource.azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_ndp.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo/webservices/input"
  })

}


######################
## WS nodo for IO   ##
######################
locals {
  apim_node_for_io_api_ndp = {
    display_name          = "Node for IO WS NDP"
    description           = "Web services to support activeIO, defined in nodeForIO.wsdl"
    path                  = "nodo-ndp/node-for-io"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "node_for_io_api_ndp" {
  name                = format("%s-nodo-for-io-api-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_node_for_io_api_ndp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_io_api_v1_ndp" {
  name                  = format("%s-node-for-io-api-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_node_for_io_api_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_io_api_ndp.id
  version               = "v1"
  service_url           = local.apim_node_for_io_api_ndp.service_url
  revision              = "1"

  description  = local.apim_node_for_io_api_ndp.description
  display_name = local.apim_node_for_io_api_ndp.display_name
  path         = local.apim_node_for_io_api_ndp.path
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

resource "azurerm_api_management_api_policy" "apim_node_for_io_policy_ndp" {
  api_name            = resource.azurerm_api_management_api.apim_node_for_io_api_v1_ndp.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  xml_content = templatefile("./api/nodopagamenti_api/nodeForIO/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo/webservices/input"
  })

}

# resource "azurerm_api_management_api_operation_policy" "activateIO_reservation_policy_ndp" {

#   api_name            = resource.azurerm_api_management_api.apim_node_for_io_api_v1_ndp.name
#   api_management_name = module.apim.name
#   resource_group_name = azurerm_resource_group.rg_api.name
#   operation_id        = var.env_short == "d" ? "61dc5018b78e981290d7c176" : var.env_short == "u" ? "61dedb1e72975e13800fd80f" : "61dedb1eea7c4a07cc7d47b8"

#   #tfsec:ignore:GEN005
#   xml_content = file("./api/nodopagamenti_api/nodeForIO/v1/activateIO_reservation_nm3.xml")
# }

############################
## WS psp for node (NM3) ##
############################
locals {
  apim_psp_for_node_api_ndp = {
    display_name          = "PSP for Node WS (NM3) NDP"
    description           = "Web services to support payment transaction started on any PagoPA client, defined in pspForNode.wsdl"
    path                  = "nodo-ndp/psp-for-node"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "psp_for_node_api_ndp" {
  name                = format("%s-psp-for-node-api-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_psp_for_node_api_ndp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_psp_for_node_api_v1_ndp" {
  name                  = format("%s-psp-for-node-api-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_psp_for_node_api_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.psp_for_node_api_ndp.id
  version               = "v1"
  service_url           = local.apim_psp_for_node_api_ndp.service_url
  revision              = "1"

  description  = local.apim_psp_for_node_api_ndp.description
  display_name = local.apim_psp_for_node_api_ndp.display_name
  path         = local.apim_psp_for_node_api_ndp.path
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

resource "azurerm_api_management_api_policy" "apim_psp_for_node_policy_ndp" {
  api_name            = resource.azurerm_api_management_api.apim_psp_for_node_api_v1_ndp.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  xml_content = file("./api/nodopagamenti_api/pspForNode/v1/_base_policy.xml")
}


######################
## WS nodo per PA ##
######################
locals {
  apim_nodo_per_pa_api_ndp = {
    display_name          = "Nodo per PA WS NDP"
    description           = "Web services to support PA in payment activations, defined in nodoPerPa.wsdl"
    path                  = "nodo-ndp/nodo-per-pa"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_pa_api_ndp" {
  name                = format("%s-nodo-per-pa-api-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_nodo_per_pa_api_ndp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_pa_api_v1_ndp" {
  name                  = format("%s-nodo-per-pa-api-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_nodo_per_pa_api_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pa_api_ndp.id
  version               = "v1"
  service_url           = local.apim_nodo_per_pa_api_ndp.service_url
  revision              = "1"

  description  = local.apim_nodo_per_pa_api_ndp.description
  display_name = local.apim_nodo_per_pa_api_ndp.display_name
  path         = local.apim_nodo_per_pa_api_ndp.path
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

resource "azurerm_api_management_api_policy" "apim_nodo_per_pa_policy_ndp" {
  api_name            = resource.azurerm_api_management_api.apim_nodo_per_pa_api_v1_ndp.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPa/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo/webservices/input"
  })
}

######################
## Nodo per PM API  ##
######################
locals {
  apim_nodo_per_pm_api_ndp = {
    display_name          = "Nodo per Payment Manager API NDP"
    description           = "API to support Payment Manager"
    path                  = "nodo-ndp/nodo-per-pm"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_pm_api_ndp" {
  // TODO remove nodo from name because it is included in local.project
  name                = format("%s-nodo-per-pm-api-ndp", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_nodo_per_pm_api_ndp.display_name
  versioning_scheme   = "Segment"
}

module "apim_nodo_per_pm_api_v1_ndp" {

  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-nodo-per-pm-api-ndp", local.project)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_nodo_per_pm_api_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api_ndp.id
  api_version           = "v1"
  service_url           = local.apim_nodo_per_pm_api_ndp.service_url

  description  = local.apim_nodo_per_pm_api_ndp.description
  display_name = local.apim_nodo_per_pm_api_ndp.display_name
  path         = local.apim_nodo_per_pm_api_ndp.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_swagger.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_nodo_dei_pagamenti_product_ndp.product_id
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo"
  })
}

resource "azurerm_api_management_api_operation_policy" "close_payment_api_v1_ndp" {
  api_name            = format("%s-nodo-per-pm-api-ndp-v1", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "closePayment"
  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_add_v1_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo"
  })
}

resource "azurerm_api_management_api_operation_policy" "parked_list_api_v1_ndp" {
  api_name            = format("%s-nodo-per-pm-api-ndp-v1", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "parkedList"
  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_add_v1_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo"
  })
}

resource "azurerm_api_management_api_operation_policy" "close_payment_api_v2_ndp_wisp_policy" {
  count = var.create_wisp_converter ? 1 : 0
  // TODO remove redundant nodo
  api_name            = format("%s-nodo-per-pm-api-ndp-v2", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "closePaymentV2"
  xml_content         = file("./api/nodopagamenti_api/nodoPerPM/v2/wisp-closepayment.xml")
}


module "apim_nodo_per_pm_api_v2_ndp" {

  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-nodo-per-pm-api-ndp", local.project)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_nodo_per_pm_api_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api_ndp.id
  api_version           = "v2"
  service_url           = local.apim_nodo_per_pm_api_ndp.service_url

  description  = local.apim_nodo_per_pm_api_ndp.description
  display_name = local.apim_nodo_per_pm_api_ndp.display_name
  path         = local.apim_nodo_per_pm_api_ndp.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/nodopagamenti_api/nodoPerPM/v2/_swagger.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v2/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo"
  })
}


######################
## NODO monitoring  ##
######################

# https://api.<env>.platform.pagopa.it/nodo-ndp/monitoring/v1/monitor

locals {
  apim_nodo_monitoring_api_ndp = {
    display_name          = "Nodo monitoring NDP"
    description           = "Nodo monitoring NDP"
    path                  = "nodo-ndp/monitoring"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_monitoring_api_ndp" {
  name                = format("%s-nodo-monitoring-api-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_nodo_monitoring_api_ndp.display_name
  versioning_scheme   = "Segment"
}

module "apim_nodo_monitoring_api_ndp" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-nodo-monitoring-api-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_nodo_dei_pagamenti_product_ndp.product_id]
  subscription_required = local.apim_nodo_monitoring_api_ndp.subscription_required

  version_set_id = azurerm_api_management_api_version_set.nodo_monitoring_api_ndp.id
  api_version    = "v1"

  description  = local.apim_nodo_monitoring_api_ndp.description
  display_name = local.apim_nodo_monitoring_api_ndp.display_name
  path         = local.apim_nodo_monitoring_api_ndp.path
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/monitoring/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/nodopagamenti_api/monitoring/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo"
  })
}

# nodoInviaRPT
resource "azurerm_api_management_api_operation_policy" "nodoInviaRPT_api_v1_policy_ndp" {
  count = var.create_wisp_converter ? 1 : 0

  api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1_ndp.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = var.env_short == "d" ? "63bff3b0c257811280ef760a" : var.env_short == "u" ? "63d1612239519a10d0113a06" : "63d93febf6c0271814e8909e"
  xml_content         = file("./api/nodopagamenti_api/nodoPerPa/v1/nodoInviaRPT_policy.xml")
}

# nodoInviaCarrelloRPT
resource "azurerm_api_management_api_operation_policy" "nodoInviaCarrelloRPT_api_v1_policy_ndp" {
  count = var.create_wisp_converter ? 1 : 0

  api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1_ndp.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = var.env_short == "d" ? "63bff3b0c257811280ef760b" : var.env_short == "u" ? "63d1612239519a10d0113a07" : "63d93febf6c0271814e8909f"
  xml_content         = file("./api/nodopagamenti_api/nodoPerPa/v1/nodoInviaCarrelloRPT_policy.xml")
}
