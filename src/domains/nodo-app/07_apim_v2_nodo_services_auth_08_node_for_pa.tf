######################
## Node for PA API  ##
######################
locals {
  apim_node_for_pa_api_auth = {
    display_name          = "Node for PA WS (AUTH)"
    description           = "Web services to support PA in payment activations, defined in nodeForPa.wsdl"
    path                  = "nodo-auth/node-for-pa"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "node_for_pa_api_auth" {
  count = var.enabled_features.apim_v2 ? 1 : 0

  name                = format("%s-node-for-pa-api-auth", var.env_short)
  resource_group_name = local.pagopa_apim_v2_rg
  api_management_name = local.pagopa_apim_v2_name
  display_name        = local.apim_node_for_pa_api_auth.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_pa_api_v1_auth" {
  count = var.enabled_features.apim_v2 ? 1 : 0

  name                  = format("%s-node-for-pa-api-auth", var.env_short)
  api_management_name   = local.pagopa_apim_v2_name
  resource_group_name   = local.pagopa_apim_v2_rg
  subscription_required = local.apim_node_for_pa_api_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_pa_api_auth[0].id
  version               = "v1"
  service_url           = local.apim_node_for_pa_api_auth.service_url
  revision              = "1"

  description  = local.apim_node_for_pa_api_auth.description
  display_name = local.apim_node_for_pa_api_auth.display_name
  path         = local.apim_node_for_pa_api_auth.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./apim_v2/api/nodopagamenti_api/nodeForPa/v1/auth/NodeForPa.wsdl")
    wsdl_selector {
      service_name  = "nodeForPa_Service"
      endpoint_name = "nodeForPa_Port"
    }
  }
}

resource "azurerm_api_management_api_policy" "apim_node_for_pa_policy_auth" {
  count = var.enabled_features.apim_v2 ? 1 : 0

  api_name            = azurerm_api_management_api.apim_node_for_pa_api_v1_auth[0].name
  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_v2_rg

  xml_content = templatefile("./apim_v2/api/nodopagamenti_api/nodeForPa/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_auth_decoupler_enable
  })
}
