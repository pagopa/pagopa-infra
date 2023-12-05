#############################
### WS psp for node (NM3) ##
#############################
#locals {
#  apim_psp_for_node_api_auth = {
#    display_name          = "PSP for Node WS (NM3) (AUTH)"
#    description           = "Web services to support payment transaction started on any PagoPA client, defined in pspForNode.wsdl"
#    path                  = "nodo-auth/psp-for-node"
#    subscription_required = true
#    service_url           = null
#  }
#}
#
#resource "azurerm_api_management_api_version_set" "psp_for_node_api_auth" {
#  name                = format("%s-psp-for-node-api-auth", var.env_short)
#  resource_group_name = azurerm_resource_group.rg_api.name
#  api_management_name = module.apim.name
#  display_name        = local.apim_psp_for_node_api_auth.display_name
#  versioning_scheme   = "Segment"
#}
#
#resource "azurerm_api_management_api" "apim_psp_for_node_api_v1_auth" {
#  name                  = format("%s-psp-for-node-api-auth", var.env_short)
#  api_management_name   = module.apim.name
#  resource_group_name   = azurerm_resource_group.rg_api.name
#  subscription_required = local.apim_psp_for_node_api_auth.subscription_required
#  version_set_id        = azurerm_api_management_api_version_set.psp_for_node_api_auth.id
#  version               = "v1"
#  service_url           = local.apim_psp_for_node_api_auth.service_url
#  revision              = "1"
#
#  description  = local.apim_psp_for_node_api_auth.description
#  display_name = local.apim_psp_for_node_api_auth.display_name
#  path         = local.apim_psp_for_node_api_auth.path
#  protocols    = ["https"]
#
#  soap_pass_through = true
#
#  import {
#    content_format = "wsdl"
#    content_value  = file("./api/nodopagamenti_api/pspForNode/v1/pspForNode.wsdl")
#    wsdl_selector {
#      service_name  = "pspForNode_Service"
#      endpoint_name = "pspForNode_Port"
#    }
#  }
#
#}
#
#resource "azurerm_api_management_api_policy" "apim_psp_for_node_policy_auth" {
#  api_name            = azurerm_api_management_api.apim_psp_for_node_api_v1_auth.name
#  api_management_name = module.apim.name
#  resource_group_name = azurerm_resource_group.rg_api.name
#
#  xml_content = file("./api/nodopagamenti_api/pspForNode/v1/_base_policy.xml")
#}
