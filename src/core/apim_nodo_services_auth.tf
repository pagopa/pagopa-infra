##############
## Products ##
##############

module "apim_nodo_dei_pagamenti_product_auth" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "nodo-auth"
  display_name = "Nodo dei Pagamenti (Nuova Connettività)"
  description  = "Product for Nodo dei Pagamenti (Nuova Connettività)"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = var.nodo_auth_subscription_limit

  policy_xml = file("./api_product/nodo_pagamenti_api/auth/_base_policy.xml")
}

locals {

  api_nodo_product_auth = [
    azurerm_api_management_api.apim_node_for_psp_api_v1_auth.name,
    azurerm_api_management_api.apim_nodo_per_psp_api_v1_auth.name,
    azurerm_api_management_api.apim_node_for_io_api_v1_auth.name,
    azurerm_api_management_api.apim_psp_for_node_api_v1_auth.name,
    azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.name,
  ]

}

resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_auth" {
  for_each = toset(local.api_nodo_product_auth)

  api_name            = each.key
  product_id          = module.apim_nodo_dei_pagamenti_product_auth.product_id
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
}

############################
## WS node for psp (NM3) ##
############################
locals {
  apim_node_for_psp_api_auth = {
    display_name          = "Node for PSP WS (NM3) (AUTH)"
    description           = "Web services to support PSP in payment activations, defined in nodeForPsp.wsdl"
    path                  = "nodo-auth/node-for-psp"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "node_for_psp_api_auth" {
  name                = format("%s-node-for-psp-api-auth", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_node_for_psp_api_auth.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_psp_api_v1_auth" {
  name                  = format("%s-node-for-psp-api-auth", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_node_for_psp_api_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_psp_api_auth.id
  version               = "v1"
  service_url           = local.apim_node_for_psp_api_auth.service_url
  revision              = "1"

  description  = local.apim_node_for_psp_api_auth.description
  display_name = local.apim_node_for_psp_api_auth.display_name
  path         = local.apim_node_for_psp_api_auth.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodeForPsp/v1/auth/nodeForPsp.wsdl")
    wsdl_selector {
      service_name  = "nodeForPsp_Service"
      endpoint_name = "nodeForPsp_Port"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_node_for_psp_policy_auth" {
  api_name            = resource.azurerm_api_management_api.apim_node_for_psp_api_v1_auth.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v1/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "{{urlnodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/webservices/input"
  })
}


# resource "azurerm_api_management_api_operation_policy" "nm3_activate_verify_policy_auth" {

#   api_name            = resource.azurerm_api_management_api.apim_node_for_psp_api_v1_auth.name
#   api_management_name = module.apim.name
#   resource_group_name = azurerm_resource_group.rg_api.name
#   operation_id        = var.env_short == "d" ? "61d70973b78e982064458676" : var.env_short == "u" ? "61dedb1872975e13800fd7ff" : "61dedafc2a92e81a0c7a58fc"

#   #tfsec:ignore:GEN005
#   xml_content = file("./api/nodopagamenti_api/nodeForPsp/v1/activate_nm3.xml")
# }

# resource "azurerm_api_management_api_operation_policy" "nm3_activate_v2_verify_policy" { # activatePaymentNoticeV2 verificatore

#   api_name            = resource.azurerm_api_management_api.apim_node_for_psp_api_v1.name
#   api_management_name = module.apim.name
#   resource_group_name = azurerm_resource_group.rg_api.name
#   operation_id        = var.env_short == "d" ? "637601f8c257810fc0ecfe06" : var.env_short == "u" ? "636e6ca51a11929386f0b101" : "TODO"

#   #tfsec:ignore:GEN005
#   xml_content = file("./api/nodopagamenti_api/nodeForPsp/v1/activate_nm3.xml")
# }

######################
## WS nodo per psp ##
######################
locals {
  apim_nodo_per_psp_api_auth = {
    display_name          = "Nodo per PSP WS (AUTH)"
    description           = "Web services to support PSP in payment activations, defined in nodoPerPsp.wsdl"
    path                  = "nodo-auth/nodo-per-psp"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_psp_api_auth" {
  name                = format("%s-nodo-per-psp-api-auth", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_nodo_per_psp_api_auth.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_psp_api_v1_auth" {
  name                  = format("%s-nodo-per-psp-api-auth", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_psp_api_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_api_auth.id
  version               = "v1"
  service_url           = local.apim_nodo_per_psp_api_auth.service_url
  revision              = "1"

  description  = local.apim_nodo_per_psp_api_auth.description
  display_name = local.apim_nodo_per_psp_api_auth.display_name
  path         = local.apim_nodo_per_psp_api_auth.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodoPerPsp/v1/auth/nodoPerPsp.wsdl")
    wsdl_selector {
      service_name  = "PagamentiTelematiciPspNodoservice"
      endpoint_name = "PPTPort"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_policy_auth" {
  api_name            = resource.azurerm_api_management_api.apim_nodo_per_psp_api_v1_auth.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPsp/v1/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "{{urlnodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/webservices/input"
  })
}

# resource "azurerm_api_management_api_operation_policy" "fdr_policy_auth" {

#   api_name            = resource.azurerm_api_management_api.apim_nodo_per_psp_api_v1_auth.name
#   api_management_name = module.apim.name
#   resource_group_name = azurerm_resource_group.rg_api.name
#   operation_id        = var.env_short == "d" ? "61e9630cb78e981290d7c74c" : var.env_short == "u" ? "61e96321e0f4ba04a49d1280" : "61e9633eea7c4a07cc7d4811"

#   xml_content = templatefile("./api/nodopagamenti_api/nodoPerPsp/v1/fdr_nodoinvia_flussorendicontazione_flow.xml", {
#     base-url = var.env_short == "p" ? "{{urlnodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/webservices/input"
#   })
# }

######################################
## WS nodo per psp richiesta avvisi ##
######################################
locals {
  apim_nodo_per_psp_richiesta_avvisi_api_auth = {
    display_name          = "Nodo per PSP Richiesta Avvisi WS (AUTH)"
    description           = "Web services to support check of pending payments to PSP, defined in nodoPerPspRichiestaAvvisi.wsdl"
    path                  = "nodo-auth/nodo-per-psp-richiesta-avvisi"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_psp_richiesta_avvisi_api_auth" {
  name                = format("%s-nodo-per-psp-richiesta-avvisi-api-auth", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_nodo_per_psp_richiesta_avvisi_api_auth.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_psp_richiesta_avvisi_api_v1_auth" {
  name                  = format("%s-nodo-per-psp-richiesta-avvisi-api-auth", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_psp_richiesta_avvisi_api_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api_auth.id
  version               = "v1"
  service_url           = local.apim_nodo_per_psp_richiesta_avvisi_api_auth.service_url
  revision              = "1"

  description  = local.apim_nodo_per_psp_richiesta_avvisi_api_auth.description
  display_name = local.apim_nodo_per_psp_richiesta_avvisi_api_auth.display_name
  path         = local.apim_nodo_per_psp_richiesta_avvisi_api_auth.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/auth/nodoPerPspRichiestaAvvisi.wsdl")
    wsdl_selector {
      service_name  = "RichiestaAvvisiservice"
      endpoint_name = "PPTPort"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_richiesta_avvisi_policy_auth" {
  api_name            = resource.azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_auth.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "{{urlnodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/webservices/input"
  })

}


######################
## WS nodo for IO   ##
######################
locals {
  apim_node_for_io_api_auth = {
    display_name          = "Node for IO WS (AUTH)"
    description           = "Web services to support activeIO, defined in nodeForIO.wsdl"
    path                  = "nodo-auth/node-for-io"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "node_for_io_api_auth" {
  name                = format("%s-nodo-for-io-api-auth", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_node_for_io_api_auth.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_io_api_v1_auth" {
  name                  = format("%s-node-for-io-api-auth", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_node_for_io_api_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_io_api_auth.id
  version               = "v1"
  service_url           = local.apim_node_for_io_api_auth.service_url
  revision              = "1"

  description  = local.apim_node_for_io_api_auth.description
  display_name = local.apim_node_for_io_api_auth.display_name
  path         = local.apim_node_for_io_api_auth.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodeForIO/v1/auth/nodeForIO.wsdl")
    wsdl_selector {
      service_name  = "nodeForIO_Service"
      endpoint_name = "nodeForIO_Port"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_node_for_io_policy_auth" {
  api_name            = resource.azurerm_api_management_api.apim_node_for_io_api_v1_auth.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodeForIO/v1/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "{{urlnodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/webservices/input"
  })

}

# resource "azurerm_api_management_api_operation_policy" "activateIO_reservation_policy_auth" {

#   api_name            = resource.azurerm_api_management_api.apim_node_for_io_api_v1_auth.name
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
  apim_psp_for_node_api_auth = {
    display_name          = "PSP for Node WS (NM3) (AUTH)"
    description           = "Web services to support payment transaction started on any PagoPA client, defined in pspForNode.wsdl"
    path                  = "nodo-auth/psp-for-node"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "psp_for_node_api_auth" {
  name                = format("%s-psp-for-node-api-auth", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_psp_for_node_api_auth.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_psp_for_node_api_v1_auth" {
  name                  = format("%s-psp-for-node-api-auth", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_psp_for_node_api_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.psp_for_node_api_auth.id
  version               = "v1"
  service_url           = local.apim_psp_for_node_api_auth.service_url
  revision              = "1"

  description  = local.apim_psp_for_node_api_auth.description
  display_name = local.apim_psp_for_node_api_auth.display_name
  path         = local.apim_psp_for_node_api_auth.path
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

resource "azurerm_api_management_api_policy" "apim_psp_for_node_policy_auth" {
  api_name            = resource.azurerm_api_management_api.apim_psp_for_node_api_v1_auth.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = file("./api/nodopagamenti_api/pspForNode/v1/_base_policy.xml")
}


######################
## WS nodo per PA ##
######################
locals {
  apim_nodo_per_pa_api_auth = {
    display_name          = "Nodo per PA WS (AUTH)"
    description           = "Web services to support PA in payment activations, defined in nodoPerPa.wsdl"
    path                  = "nodo-auth/nodo-per-pa"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_pa_api_auth" {
  name                = format("%s-nodo-per-pa-api-auth", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_nodo_per_pa_api_auth.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_pa_api_v1_auth" {
  name                  = format("%s-nodo-per-pa-api-auth", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_pa_api_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pa_api_auth.id
  version               = "v1"
  service_url           = local.apim_nodo_per_pa_api_auth.service_url
  revision              = "1"

  description  = local.apim_nodo_per_pa_api_auth.description
  display_name = local.apim_nodo_per_pa_api_auth.display_name
  path         = local.apim_nodo_per_pa_api_auth.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodoPerPa/v1/auth/NodoPerPa.wsdl")
    wsdl_selector {
      service_name  = "PagamentiTelematiciRPTservice"
      endpoint_name = "PagamentiTelematiciRPTPort"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_nodo_per_pa_policy_auth" {
  api_name            = resource.azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPa/v1/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "{{urlnodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/webservices/input"
  })
}

######################
## Nodo per PM API  ##
######################
locals {
  apim_nodo_per_pm_api_auth = {
    display_name          = "Nodo per Payment Manager API (AUTH)"
    description           = "API to support Payment Manager"
    path                  = "nodo-auth/nodo-per-pm"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_pm_api_auth" {

  name                = format("%s-nodo-per-pm-api-auth", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_nodo_per_pm_api_auth.display_name
  versioning_scheme   = "Segment"
}

module "apim_nodo_per_pm_api_v1_auth" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-nodo-per-pm-api-auth", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_pm_api_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api_auth.id
  api_version           = "v1"
  service_url           = local.apim_nodo_per_pm_api_auth.service_url

  description  = local.apim_nodo_per_pm_api_auth.description
  display_name = local.apim_nodo_per_pm_api_auth.display_name
  path         = local.apim_nodo_per_pm_api_auth.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "https://{{ip-nodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}"
  })
}

resource "azurerm_api_management_api_operation_policy" "close_payment_api_v1_auth" {
  api_name            = format("%s-nodo-per-pm-api-auth-v1", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = "closePayment"
  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_closepayment_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "https://{{ip-nodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}"
  })
}

module "apim_nodo_per_pm_api_v2_auth" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-nodo-per-pm-api-auth", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_pm_api_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api_auth.id
  api_version           = "v2"
  service_url           = local.apim_nodo_per_pm_api_auth.service_url

  description  = local.apim_nodo_per_pm_api_auth.description
  display_name = local.apim_nodo_per_pm_api_auth.display_name
  path         = local.apim_nodo_per_pm_api_auth.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/nodopagamenti_api/nodoPerPM/v2/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v2/_base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "https://{{ip-nodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}"
  })
}

resource "azurerm_api_management_named_value" "nodo_auth_password_value" {
  name                = "nodoAuthPassword"
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "nodoAuthPassword"
  value               = var.nodo_pagamenti_auth_password
}

resource "azurerm_api_management_named_value" "x_forwarded_for_value" {
  name                = "xForwardedFor"
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "xForwardedFor"
  value               = var.nodo_pagamenti_x_forwarded_for
}
