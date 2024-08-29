############################
## WS node for PSP (NM3) ##
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
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_node_for_psp_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_psp_api_v1" {
  name                  = format("%s-node-for-psp-api", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
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
  api_name            = azurerm_api_management_api.apim_node_for_psp_api_v1.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })
}


resource "azurerm_api_management_api_operation_policy" "nm3_activate_verify_policy" { # activatePaymentNoticeV1 verificatore

  api_name            = azurerm_api_management_api.apim_node_for_psp_api_v1.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "637601f8c257810fc0ecfe01" : var.env_short == "u" ? "61dedb1872975e13800fd7ff" : "61dedafc2a92e81a0c7a58fc"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v1/activate_nm3.xml", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
    urlenvpath                = var.env_short
    url_aks                   = var.env_short == "p" ? "weu${var.env}.apiconfig.internal.platform.pagopa.it" : "weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"
  })
}

resource "azurerm_api_management_api_operation_policy" "nm3_activate_v2_verify_policy" { # activatePaymentNoticeV2 verificatore

  api_name            = azurerm_api_management_api.apim_node_for_psp_api_v1.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "637601f8c257810fc0ecfe06" : var.env_short == "u" ? "636e6ca51a11929386f0b101" : "63c559672a92e811a8f33a00"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v2/activate_nm3.xml", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
    urlenvpath                = var.env_short
    url_aks                   = var.env_short == "p" ? "weu${var.env}.apiconfig.internal.platform.pagopa.it" : "weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"
  })
}
