# ############################
# ## WS node for PSP (NM3) ##
# ############################
locals {
  apim_node_for_psp_api_auth_policy_file = file("./api/nodopagamenti_api/nodeForPsp/v1/base_policy.xml")
  verifyPaymentNotice_v1_policy_file     = file("./api/nodopagamenti_api/nodeForPsp/v1/base_policy_verifyPaymentNotice.xml")
  activePaymentNotice_v1_policy_file     = file("./api/nodopagamenti_api/nodeForPsp/v1/base_policy_activePaymentNotice.xml")
  activePaymentNoticeV2_v1_policy_file   = file("./api/nodopagamenti_api/nodeForPsp/v1/base_policy_activePaymentNoticeV2.xml")
  sendPaymentOutcome_v1_policy_file      = file("./api/nodopagamenti_api/nodeForPsp/v1/base_policy_sendPaymentOutcome.xml")
  sendPaymentOutcomeV2_v1_policy_file    = file("./api/nodopagamenti_api/nodeForPsp/v1/base_policy_sendPaymentOutcomeV2.xml")
  base_policy_nodeForPsp_routing_file    = file("./api/nodopagamenti_api/nodeForPsp/v1/base_policy_routing.xml")
}

resource "azurerm_api_management_api_version_set" "node_for_psp_api_auth" {
  name                = "${var.env_short}-node-for-psp-api-auth-2" #TODO [FCADAC] remove 2
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "Node for PSP (AUTH 2.0)" #TODO [FCADAC] remove 2.0
  versioning_scheme   = "Segment"
}

resource "terraform_data" "sha256_apim_node_for_psp_api_v1_auth" {
  input = sha256(local.apim_node_for_psp_api_auth_policy_file)
}
module "apim_node_for_psp_api_v1_auth" {
  # source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.7.0"
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = azurerm_api_management_api_version_set.node_for_psp_api_auth.name
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_api_management.apim.resource_group_name
  product_ids           = [module.apim_nodo_dei_pagamenti_product_auth.product_id]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.node_for_psp_api_auth.id
  api_version    = "v1"

  description  = "Web services for supporting PSP in payment activations, defined in nodeForPsp.wsdl"
  display_name = azurerm_api_management_api_version_set.node_for_psp_api_auth.display_name
  path         = "nodo-auth-2/node-for-psp" #TODO [FCADAC] remove 2
  protocols    = ["https"]

  service_url = null

  api_type = "soap"

  content_format = "wsdl"
  content_value  = file("./api/nodopagamenti_api/nodeForPsp/v1/wsdl/auth/nodeForPsp.wsdl")
  wsdl_selector = {
    service_name  = "nodeForPsp_Service"
    endpoint_name = "nodeForPsp_Port"
  }

  xml_content = local.apim_node_for_psp_api_auth_policy_file

  api_operation_policies = [
    {
      operation_id = "verifyPaymentNotice"
      xml_content = local.verifyPaymentNotice_v1_policy_file
    },
    {
      operation_id = "activatePaymentNotice"
      xml_content = local.activePaymentNotice_v1_policy_file
    },
    {
      operation_id = "activatePaymentNoticeV2"
      xml_content = local.activePaymentNoticeV2_v1_policy_file
    },
    {
      operation_id = "sendPaymentOutcome"
      xml_content = local.sendPaymentOutcome_v1_policy_file
    },
    {
      operation_id = "sendPaymentOutcomeV2"
      xml_content = local.sendPaymentOutcomeV2_v1_policy_file
    },
    {
      operation_id = "nodoChiediCatalogoServiziV2"
      xml_content = local.base_policy_nodeForPsp_routing_file
    },
    {
      operation_id = "demandPaymentNotice"
      xml_content = local.base_policy_nodeForPsp_routing_file
    }
  ]

  depends_on = [
    module.apim_nodo_dei_pagamenti_product_auth
  ]
}


###### verifyPaymentNotice
resource "terraform_data" "sha256_verifyPaymentNotice_v1_policy_auth" {
  input = sha256(local.verifyPaymentNotice_v1_policy_file)
}

###### activatePaymentNotice
resource "terraform_data" "sha256_activePaymentNotice_v1_policy_auth" {
  input = sha256(local.activePaymentNotice_v1_policy_file)
}

###### activatePaymentNoticeV2
resource "terraform_data" "sha256_activePaymentNoticeV2_v1_policy_auth" {
  input = sha256(local.activePaymentNoticeV2_v1_policy_file)
}

###### sendPaymentOutcome
resource "terraform_data" "sha256_sendPaymentOutcome_v1_policy_auth" {
  input = sha256(local.sendPaymentOutcome_v1_policy_file)
}

###### sendPaymentOutcomeV2
resource "terraform_data" "sha256_sendPaymentOutcomeV2_v1_policy_auth" {
  input = sha256(local.sendPaymentOutcomeV2_v1_policy_file)
}

###### nodoChiediCatalogoServiziV2
resource "terraform_data" "sha256_nodoChiediCatalogoServiziV2_v1_policy_auth" {
  input = sha256(local.base_policy_nodeForPsp_routing_file)
}

###### demandPaymentNotice
resource "terraform_data" "sha256_demandPaymentNotice_v1_policy_auth" {
  input = sha256(local.base_policy_nodeForPsp_routing_file)
}
