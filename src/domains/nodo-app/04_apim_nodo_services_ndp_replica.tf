######################
## Products REPLICA ##
######################

module "apim_nodo_dei_pagamenti_product_replica_ndp" {
  source       = "./.terraform/modules/__v3__/api_management_product"
  count        = var.env_short == "p" ? 0 : 1
  product_id   = "nodo-replica-ndp"
  display_name = "Nodo dei Pagamenti REPLICA NDP"
  description  = "Product for Nodo dei Pagamenti REPLICA NDP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = var.nodo_ndp_subscription_limit

  policy_xml = templatefile("./api_product/nodo_pagamenti_api_replica/_base_policy.xml", {
    address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
  })
}

locals {

  api_nodo_product_replica_ndp = var.env_short == "p" ? [] : [
    azurerm_api_management_api.apim_node_for_psp_api_v1_replica_ndp[0].name,
    azurerm_api_management_api.apim_nodo_per_psp_api_v1_replica_ndp[0].name,
    azurerm_api_management_api.apim_node_for_io_api_v1_replica_ndp[0].name,
    azurerm_api_management_api.apim_psp_for_node_api_v1_replica_ndp[0].name,
    azurerm_api_management_api.apim_nodo_per_pa_api_v1_replica_ndp[0].name,
    azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_replica_ndp[0].name,
    module.apim_nodo_per_pm_api_v1_replica_ndp[0].name,
    module.apim_nodo_per_pm_api_v2_replica_ndp[0].name,
  ]

}

resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_replica_ndp" {
  for_each = toset(local.api_nodo_product_replica_ndp)

  api_name            = each.key
  product_id          = module.apim_nodo_dei_pagamenti_product_replica_ndp[0].product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

###################################
## WS node for psp (NM3) REPLICA ##
###################################
locals {
  apim_node_for_psp_api_replica_ndp = {
    display_name          = "Node for PSP WS (NM3) REPLICA NDP"
    description           = "Web services to support PSP in payment activations, defined in nodeForPsp.wsdl"
    path                  = "nodo-replica-ndp/node-for-psp"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "node_for_psp_api_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-node-for-psp-api-replica-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_node_for_psp_api_replica_ndp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_psp_api_v1_replica_ndp" {
  count                 = var.env_short == "p" ? 0 : 1
  name                  = format("%s-node-for-psp-api-replica-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_node_for_psp_api_replica_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_psp_api_replica_ndp[0].id
  version               = "v1"
  service_url           = local.apim_node_for_psp_api_replica_ndp.service_url
  revision              = "1"

  description  = local.apim_node_for_psp_api_replica_ndp.description
  display_name = local.apim_node_for_psp_api_replica_ndp.display_name
  path         = local.apim_node_for_psp_api_replica_ndp.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api_replica/nodeForPsp/v1/nodeForPsp.wsdl")
    wsdl_selector {
      service_name  = "nodeForPsp_Service"
      endpoint_name = "nodeForPsp_Port"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_node_for_psp_policy_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  api_name            = resource.azurerm_api_management_api.apim_node_for_psp_api_v1_replica_ndp[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  xml_content = templatefile("./api/nodopagamenti_api_replica/nodeForPsp/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo-replica/webservices/input"
  })
}


#############################
## WS nodo per psp REPLICA ##
#############################
locals {
  apim_nodo_per_psp_api_replica_ndp = {
    display_name          = "Nodo per PSP WS REPLICA NDP"
    description           = "Web services to support PSP in payment activations, defined in nodoPerPsp.wsdl"
    path                  = "nodo-replica-ndp/nodo-per-psp"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_psp_api_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-nodo-per-psp-api-replica-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_nodo_per_psp_api_replica_ndp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_psp_api_v1_replica_ndp" {
  count                 = var.env_short == "p" ? 0 : 1
  name                  = format("%s-nodo-per-psp-api-replica-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_nodo_per_psp_api_replica_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_api_replica_ndp[0].id
  version               = "v1"
  service_url           = local.apim_nodo_per_psp_api_replica_ndp.service_url
  revision              = "1"

  description  = local.apim_nodo_per_psp_api_replica_ndp.description
  display_name = local.apim_nodo_per_psp_api_replica_ndp.display_name
  path         = local.apim_nodo_per_psp_api_replica_ndp.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api_replica/nodoPerPsp/v1/nodoPerPsp.wsdl")
    wsdl_selector {
      service_name  = "PagamentiTelematiciPspNodoservice"
      endpoint_name = "PPTPort"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_policy_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  api_name            = resource.azurerm_api_management_api.apim_nodo_per_psp_api_v1_replica_ndp[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  xml_content = templatefile("./api/nodopagamenti_api_replica/nodoPerPsp/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo-replica/webservices/input"
  })
}


##############################################
## WS nodo per psp richiesta avvisi REPLICA ##
##############################################
locals {
  apim_nodo_per_psp_richiesta_avvisi_api_replica_ndp = {
    display_name          = "Nodo per PSP Richiesta Avvisi WS REPLICA NDP"
    description           = "Web services to support check of pending payments to PSP, defined in nodoPerPspRichiestaAvvisi.wsdl"
    path                  = "nodo-replica-ndp/nodo-per-psp-richiesta-avvisi"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_psp_richiesta_avvisi_api_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-nodo-per-psp-richiesta-avvisi-api-replica-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_nodo_per_psp_richiesta_avvisi_api_replica_ndp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_psp_richiesta_avvisi_api_v1_replica_ndp" {
  count                 = var.env_short == "p" ? 0 : 1
  name                  = format("%s-nodo-per-psp-richiesta-avvisi-api-replica-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_nodo_per_psp_richiesta_avvisi_api_replica_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api_replica_ndp[0].id
  version               = "v1"
  service_url           = local.apim_nodo_per_psp_richiesta_avvisi_api_replica_ndp.service_url
  revision              = "1"

  description  = local.apim_nodo_per_psp_richiesta_avvisi_api_replica_ndp.description
  display_name = local.apim_nodo_per_psp_richiesta_avvisi_api_replica_ndp.display_name
  path         = local.apim_nodo_per_psp_richiesta_avvisi_api_replica_ndp.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api_replica/nodoPerPspRichiestaAvvisi/v1/nodoPerPspRichiestaAvvisi.wsdl")
    wsdl_selector {
      service_name  = "RichiestaAvvisiservice"
      endpoint_name = "PPTPort"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_richiesta_avvisi_policy_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  api_name            = resource.azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_replica_ndp[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  xml_content = templatefile("./api/nodopagamenti_api_replica/nodoPerPspRichiestaAvvisi/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo-replica/webservices/input"
  })

}


############################
## WS nodo for IO REPLICA ##
############################
locals {
  apim_node_for_io_api_replica_ndp = {
    display_name          = "Node for IO WS REPLICA NDP"
    description           = "Web services to support activeIO, defined in nodeForIO.wsdl"
    path                  = "nodo-replica-ndp/node-for-io"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "node_for_io_api_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-nodo-for-io-api-replica-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_node_for_io_api_replica_ndp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_io_api_v1_replica_ndp" {
  count                 = var.env_short == "p" ? 0 : 1
  name                  = format("%s-node-for-io-api-replica-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_node_for_io_api_replica_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_io_api_replica_ndp[0].id
  version               = "v1"
  service_url           = local.apim_node_for_io_api_replica_ndp.service_url
  revision              = "1"

  description  = local.apim_node_for_io_api_replica_ndp.description
  display_name = local.apim_node_for_io_api_replica_ndp.display_name
  path         = local.apim_node_for_io_api_replica_ndp.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api_replica/nodeForIO/v1/nodeForIO.wsdl")
    wsdl_selector {
      service_name  = "nodeForIO_Service"
      endpoint_name = "nodeForIO_Port"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_node_for_io_policy_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  api_name            = resource.azurerm_api_management_api.apim_node_for_io_api_v1_replica_ndp[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  xml_content = templatefile("./api/nodopagamenti_api_replica/nodeForIO/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo-replica/webservices/input"
  })

}


###################################
## WS psp for node (NM3) REPLICA ##
###################################
locals {
  apim_psp_for_node_api_replica_ndp = {
    display_name          = "PSP for Node WS (NM3) REPLICA NDP"
    description           = "Web services to support payment transaction started on any PagoPA client, defined in pspForNode.wsdl"
    path                  = "nodo-replica-ndp/psp-for-node"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "psp_for_node_api_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-psp-for-node-api-replica-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_psp_for_node_api_replica_ndp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_psp_for_node_api_v1_replica_ndp" {
  count                 = var.env_short == "p" ? 0 : 1
  name                  = format("%s-psp-for-node-api-replica-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_psp_for_node_api_replica_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.psp_for_node_api_replica_ndp[0].id
  version               = "v1"
  service_url           = local.apim_psp_for_node_api_replica_ndp.service_url
  revision              = "1"

  description  = local.apim_psp_for_node_api_replica_ndp.description
  display_name = local.apim_psp_for_node_api_replica_ndp.display_name
  path         = local.apim_psp_for_node_api_replica_ndp.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api_replica/pspForNode/v1/pspForNode.wsdl")
    wsdl_selector {
      service_name  = "pspForNode_Service"
      endpoint_name = "pspForNode_Port"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_psp_for_node_policy_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  api_name            = resource.azurerm_api_management_api.apim_psp_for_node_api_v1_replica_ndp[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  xml_content = file("./api/nodopagamenti_api_replica/pspForNode/v1/_base_policy.xml")
}


############################
## WS nodo per PA REPLICA ##
############################
locals {
  apim_nodo_per_pa_api_replica_ndp = {
    display_name          = "Nodo per PA WS REPLICA NDP"
    description           = "Web services to support PA in payment activations, defined in nodoPerPa.wsdl"
    path                  = "nodo-replica-ndp/nodo-per-pa"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_pa_api_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-nodo-per-pa-api-replica-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_nodo_per_pa_api_replica_ndp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_pa_api_v1_replica_ndp" {
  count                 = var.env_short == "p" ? 0 : 1
  name                  = format("%s-nodo-per-pa-api-replica-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_nodo_per_pa_api_replica_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pa_api_replica_ndp[0].id
  version               = "v1"
  service_url           = local.apim_nodo_per_pa_api_replica_ndp.service_url
  revision              = "1"

  description  = local.apim_nodo_per_pa_api_replica_ndp.description
  display_name = local.apim_nodo_per_pa_api_replica_ndp.display_name
  path         = local.apim_nodo_per_pa_api_replica_ndp.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api_replica/nodoPerPa/v1/NodoPerPa.wsdl")
    wsdl_selector {
      service_name  = "PagamentiTelematiciRPTservice"
      endpoint_name = "PagamentiTelematiciRPTPort"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_nodo_per_pa_policy_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  api_name            = resource.azurerm_api_management_api.apim_nodo_per_pa_api_v1_replica_ndp[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  xml_content = templatefile("./api/nodopagamenti_api_replica/nodoPerPa/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo-replica/webservices/input"
  })
}

#############################
## Nodo per PM API REPLICA ##
#############################
locals {
  apim_nodo_per_pm_api_replica_ndp = {
    display_name          = "Nodo per Payment Manager API REPLICA NDP"
    description           = "API to support Payment Manager"
    path                  = "nodo-replica-ndp/nodo-per-pm"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_pm_api_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-nodo-per-pm-api-replica-ndp", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_nodo_per_pm_api_replica_ndp.display_name
  versioning_scheme   = "Segment"
}

module "apim_nodo_per_pm_api_v1_replica_ndp" {
  source = "./.terraform/modules/__v3__/api_management_api"
  count  = var.env_short == "p" ? 0 : 1

  name                  = format("%s-nodo-per-pm-api-replica-ndp", local.project)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_nodo_per_pm_api_replica_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api_replica_ndp[0].id
  api_version           = "v1"
  service_url           = local.apim_nodo_per_pm_api_replica_ndp.service_url

  description  = local.apim_nodo_per_pm_api_replica_ndp.description
  display_name = local.apim_nodo_per_pm_api_replica_ndp.display_name
  path         = local.apim_nodo_per_pm_api_replica_ndp.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/nodopagamenti_api_replica/nodoPerPM/v1/_swagger.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_nodo_dei_pagamenti_product_replica_ndp[0].product_id
  })

  xml_content = templatefile("./api/nodopagamenti_api_replica/nodoPerPM/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo-replica"
  })
}

resource "azurerm_api_management_api_operation_policy" "close_payment_api_v1_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  api_name            = format("%s-nodo-per-pm-api-replica-ndp-v1", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "closePayment"
  xml_content = templatefile("./api/nodopagamenti_api_replica/nodoPerPM/v1/_add_v1_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo-replica"
  })
}

resource "azurerm_api_management_api_operation_policy" "parked_list_api_v1_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  api_name            = format("%s-nodo-per-pm-api-replica-ndp-v1", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "parkedList"
  xml_content = templatefile("./api/nodopagamenti_api_replica/nodoPerPM/v1/_add_v1_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo-replica"
  })
}

module "apim_nodo_per_pm_api_v2_replica_ndp" {
  source                = "./.terraform/modules/__v3__/api_management_api"
  count                 = var.env_short == "p" ? 0 : 1
  name                  = format("%s-nodo-per-pm-api-replica-ndp", local.project)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  subscription_required = local.apim_nodo_per_pm_api_replica_ndp.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api_replica_ndp[0].id
  api_version           = "v2"
  service_url           = local.apim_nodo_per_pm_api_replica_ndp.service_url

  description  = local.apim_nodo_per_pm_api_replica_ndp.description
  display_name = local.apim_nodo_per_pm_api_replica_ndp.display_name
  path         = local.apim_nodo_per_pm_api_replica_ndp.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/nodopagamenti_api_replica/nodoPerPM/v2/_swagger.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/nodopagamenti_api_replica/nodoPerPM/v2/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo-replica"
  })
}


#############################
## NODO monitoring REPLICA ##
#############################

# https://api.<env>.platform.pagopa.it/nodo-replica-ndp/monitoring/v1/monitor

locals {
  apim_nodo_monitoring_api_replica_ndp = {
    display_name          = "Nodo monitoring REPLICA NDP"
    description           = "Nodo monitoring REPLICA NDP"
    path                  = "nodo-replica-ndp/monitoring"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_monitoring_api_replica_ndp" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-nodo-monitoring-api-replica-ndp", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_nodo_monitoring_api_replica_ndp.display_name
  versioning_scheme   = "Segment"
}

module "apim_nodo_monitoring_api_replica_ndp" {
  source                = "./.terraform/modules/__v3__/api_management_api"
  count                 = var.env_short == "p" ? 0 : 1
  name                  = format("%s-nodo-monitoring-api-replica-ndp", var.env_short)
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_nodo_dei_pagamenti_product_replica_ndp[0].product_id]
  subscription_required = local.apim_nodo_monitoring_api_replica_ndp.subscription_required

  version_set_id = azurerm_api_management_api_version_set.nodo_monitoring_api_replica_ndp[0].id
  api_version    = "v1"

  description  = local.apim_nodo_monitoring_api_replica_ndp.description
  display_name = local.apim_nodo_monitoring_api_replica_ndp.display_name
  path         = local.apim_nodo_monitoring_api_replica_ndp.path
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api_replica/monitoring/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/nodopagamenti_api_replica/monitoring/v1/_base_policy.xml.tpl", {
    base-url = "https://${local.nodo_hostname}/nodo-replica"
  })
}

# nodoInviaRPT
resource "azurerm_api_management_api_operation_policy" "nodoInviaRPT_api_v1_policy_replica_ndp" {
  count = var.create_wisp_converter && var.env_short != "p" ? 1 : 0

  api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1_replica_ndp[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = var.env_short == "d" ? "63d7c034c257810ad4354e11" : "63d7c1f0451c1c1948ef4165"
  xml_content         = file("./api/nodopagamenti_api/nodoPerPa/v1/nodoInviaRPT_policy.xml")
}

# nodoInviaCarrelloRPT
resource "azurerm_api_management_api_operation_policy" "nodoInviaCarrelloRPT_api_v1_policy_replica_ndp" {
  count = var.create_wisp_converter && var.env_short != "p" ? 1 : 0

  api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1_replica_ndp[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = var.env_short == "d" ? "63d7c034c257810ad4354e12" : "63d7c1f0451c1c1948ef4166"
  xml_content         = file("./api/nodopagamenti_api/nodoPerPa/v1/nodoInviaCarrelloRPT_policy.xml")
}
