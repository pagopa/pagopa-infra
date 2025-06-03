######################
## WS nodo for IO   ##
######################
locals {
  apim_node_for_io_api_auth_policy_file = file("./api/nodopagamenti_api/nodeForIO/v1/base_policy.xml")
  activeIOPayment_v1_policy_file        = file("./api/nodopagamenti_api/nodeForIO/v1/base_policy_activeIOPayment.xml")
}

resource "azurerm_api_management_api_version_set" "node_for_io_api_auth" {
  name                = "${var.env_short}-node-for-io-api-auth-2" #TODO [FCADAC] remove 2
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "Node for IO WS (AUTH 2.0)"
  versioning_scheme   = "Segment"
}

resource "terraform_data" "sha256_apim_node_for_io_api_v1_auth" {
  input = sha256(local.apim_node_for_io_api_auth_policy_file)
}
module "apim_node_for_io_api_v1_auth" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = azurerm_api_management_api_version_set.node_for_io_api_auth.name
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_api_management.apim.resource_group_name
  product_ids           = [module.apim_nodo_dei_pagamenti_product_auth.product_id]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.node_for_io_api_auth.id
  api_version    = "v1"

  description  = "Web services to support activeIO, defined in nodeForIO.wsdl"
  display_name = azurerm_api_management_api_version_set.node_for_io_api_auth.display_name
  path         = "nodo-auth-2/node-for-io" #TODO [FCADAC] remove 2
  protocols    = ["https"]

  service_url = null

  api_type = "soap"

  content_format = "wsdl"
  content_value  = file("./api/nodopagamenti_api/nodeForIO/v1/wsdl/auth/nodeForIO.wsdl")
  wsdl_selector = {
    service_name  = "nodeForIO_Service"
    endpoint_name = "nodeForIO_Port"
  }

  xml_content = local.apim_node_for_io_api_auth_policy_file

  api_operation_policies = [
    {
      operation_id = "activateIOPayment"
      xml_content  = local.activeIOPayment_v1_policy_file
    }
  ]

  depends_on = [
    module.apim_nodo_dei_pagamenti_product_auth
  ]
}
