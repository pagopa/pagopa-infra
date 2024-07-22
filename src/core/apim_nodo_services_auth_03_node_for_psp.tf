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
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_node_for_psp_api_auth.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_psp_api_v1_auth" {
  name                  = format("%s-node-for-psp-api-auth", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
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
  api_name            = azurerm_api_management_api.apim_node_for_psp_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_auth_decoupler_enable
  })
}


resource "azurerm_api_management_api_operation_policy" "nm3_activate_verify_policy_auth" {

  api_name            = azurerm_api_management_api.apim_node_for_psp_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "637608a0c257810fc0ecfe1c" : var.env_short == "u" ? "636cb7e439519a17ec9bf98b" : "63b6e2daea7c4a25440fdaa0"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v1/activate_nm3.xml", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
    urlenvpath                = var.env_short
    url_aks                   = var.env_short == "p" ? "weu${var.env}.apiconfig.internal.platform.pagopa.it" : "weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"
  })
}

resource "azurerm_api_management_api_operation_policy" "nm3_activate_v2_verify_policy_auth" { # activatePaymentNoticeV2 verificatore

  api_name            = azurerm_api_management_api.apim_node_for_psp_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "637608a0c257810fc0ecfe21" : var.env_short == "u" ? "63756cf1451c1c01c4186baa" : "63b6e2daea7c4a25440fdaa5"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v2/activate_nm3.xml", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
    urlenvpath                = var.env_short
    url_aks                   = var.env_short == "p" ? "weu${var.env}.apiconfig.internal.platform.pagopa.it" : "weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"
  })

}
