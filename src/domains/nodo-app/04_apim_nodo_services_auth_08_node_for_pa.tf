######################
## Node for PA API  ##
######################
locals {
  apim_node_for_pa_api_auth_policy_file     = file("./api/nodopagamenti_api/nodeForPa/v1/base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "node_for_pa_api_auth" {
  name                = "${var.env_short}-node-for-pa-api-auth-2" #TODO [FCADAC] remove 2
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "Node for PA WS (AUTH 2.0)"
  versioning_scheme   = "Segment"
}

resource "terraform_data" "sha256_apim_node_for_pa_api_v1_auth" {
  input = sha256(local.apim_node_for_pa_api_auth_policy_file)
}

module "apim_node_for_pa_api_v1_auth" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = azurerm_api_management_api_version_set.node_for_pa_api_auth.name
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_api_management.apim.resource_group_name
  product_ids           = [module.apim_nodo_dei_pagamenti_product_auth.product_id]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.node_for_pa_api_auth.id
  api_version    = "v1"

  description  = "Web services to support PA in payment activations, defined in nodeForPa.wsdl"
  display_name = azurerm_api_management_api_version_set.node_for_pa_api_auth.display_name
  path         = "nodo-auth-2/node-for-pa" #TODO [FCADAC] remove 2
  protocols    = ["https"]

  service_url = null

  api_type = "soap"

  content_format = "wsdl"
  content_value  = file("./api/nodopagamenti_api/nodeForPa/v1/wsdl/auth/NodeForPa.wsdl")
  wsdl_selector = {
    service_name  = "nodeForPa_Service"
    endpoint_name = "nodeForPa_Port"
  }

  xml_content = local.apim_node_for_pa_api_auth_policy_file

  depends_on = [
    module.apim_nodo_dei_pagamenti_product_auth
  ]
}
