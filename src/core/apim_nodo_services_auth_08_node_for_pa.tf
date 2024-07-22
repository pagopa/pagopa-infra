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
  name                = format("%s-node-for-pa-api-auth", var.env_short)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_node_for_pa_api_auth.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_pa_api_v1_auth" {
  name                  = format("%s-node-for-pa-api-auth", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  subscription_required = local.apim_node_for_pa_api_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_pa_api_auth.id
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
    content_value  = file("./api/nodopagamenti_api/nodeForPa/v1/auth/NodeForPa.wsdl")
    wsdl_selector {
      service_name  = "nodeForPa_Service"
      endpoint_name = "nodeForPa_Port"
    }
  }
}

resource "azurerm_api_management_api_policy" "apim_node_for_pa_policy_auth" {
  api_name            = azurerm_api_management_api.apim_node_for_pa_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodeForPa/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_auth_decoupler_enable
  })
}
