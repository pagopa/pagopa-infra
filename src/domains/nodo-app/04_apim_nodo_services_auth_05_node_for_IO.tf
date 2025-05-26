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
  wsdl_selector  = {
    service_name    = "nodeForIO_Service"
    endpoint_name   = "nodeForIO_Port"
  }

  xml_content = local.apim_node_for_io_api_auth_policy_file

  depends_on = [
    module.apim_nodo_dei_pagamenti_product_auth
  ]
}

###### activateIOPayment
resource "terraform_data" "sha256_activeIOPayment_v1_policy_auth" {
  input = sha256(local.activeIOPayment_v1_policy_file)
}
resource "azurerm_api_management_api_operation_policy" "activeIOPayment_v1_policy_auth" {
  api_name            = module.apim_node_for_io_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  # operation_id          = var.env_short == "d" ? "637608a0c257810fc0ecfe1c" : var.env_short == "u" ? "636cb7e439519a17ec9bf98b" : "63b6e2daea7c4a25440fdaa0" #TODO [FCADAC] replace
  operation_id = var.env_short == "d" ? "68345f7e0a23231b90316fd3" : ""

  #tfsec:ignore:GEN005
  xml_content = local.activeIOPayment_v1_policy_file

  depends_on = [
    azurerm_api_management_policy_fragment.verificatore_activateIOPayment_inbound_policy,
    azurerm_api_management_policy_fragment.verificatore_activateIOPayment_outbound_policy
  ]
}


/*
resource "azurerm_api_management_api" "apim_node_for_io_api_v1_auth" {
  name                  = format("%s-node-for-io-api-auth", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
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
  api_name            = azurerm_api_management_api.apim_node_for_io_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodeForIO/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_auth_decoupler_enable
  })

}
 */
