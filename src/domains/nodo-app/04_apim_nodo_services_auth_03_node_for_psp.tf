# ############################
# ## WS node for psp (NM3) ##
# ############################
locals {
  apim_node_for_psp_api_auth_policy_file = file("./api/nodopagamenti_api/nodeForPsp/v1/base_policy.xml")
  verifyPaymentNotice_v1_policy_file     = file("./api/nodopagamenti_api/nodeForPsp/v1/base_policy_verifyPaymentNotice.xml")
  activePaymentNotice_v1_policy_file     = file("./api/nodopagamenti_api/nodeForPsp/v1/base_policy_activePaymentNotice.xml")
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

  depends_on = [
    module.apim_nodo_dei_pagamenti_product_auth
  ]
}


###### verifyPaymentNotice
resource "terraform_data" "sha256_verifyPaymentNotice_v1_policy_auth" {
  input = sha256(local.verifyPaymentNotice_v1_policy_file)
}
resource "azurerm_api_management_api_operation_policy" "verifyPaymentNotice_v1_policy_auth" {
  api_name            = module.apim_node_for_psp_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  # operation_id          = var.env_short == "d" ? "637608a0c257810fc0ecfe1c" : var.env_short == "u" ? "636cb7e439519a17ec9bf98b" : "63b6e2daea7c4a25440fdaa0" #TODO [FCADAC] replace
  operation_id = var.env_short == "d" ? "683085050a23231b90313d94" : ""

  #tfsec:ignore:GEN005
  xml_content = local.verifyPaymentNotice_v1_policy_file
}

###### activatePaymentNotice
resource "terraform_data" "sha256_activePaymentNotice_v1_policy_auth" {
  input = sha256(local.activePaymentNotice_v1_policy_file)
}
resource "azurerm_api_management_api_operation_policy" "activePaymentNotice_v1_policy_auth" {
  api_name            = module.apim_node_for_psp_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  # operation_id          = var.env_short == "d" ? "637608a0c257810fc0ecfe1c" : var.env_short == "u" ? "636cb7e439519a17ec9bf98b" : "63b6e2daea7c4a25440fdaa0" #TODO [FCADAC] replace
  # operation_id = var.env_short == "d" ? "683085050a23231b90313d95" : ""
  operation_id = "683085050a23231b90313d95"

  #tfsec:ignore:GEN005
  xml_content = local.activePaymentNotice_v1_policy_file
}


# resource "azurerm_api_management_api_policy" "apim_node_for_psp_policy_auth" {
#   api_name            = azurerm_api_management_api.apim_node_for_psp_api_v1_auth.name
#   api_management_name   = data.azurerm_api_management.apim.name
#   resource_group_name   = data.azurerm_api_management.apim.resource_group_name
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v1/_base_policy.xml.tpl", {
#     is-nodo-decoupler-enabled = var.apim_nodo_auth_decoupler_enable
#   })
# }
# #
# #
# # resource "azurerm_api_management_api_operation_policy" "nm3_activate_verify_policy_auth" {
# #
# #   api_name            = azurerm_api_management_api.apim_node_for_psp_api_v1_auth.name
# #   api_management_name = data.azurerm_api_management.apim_migrated[0].name
# #   resource_group_name = data.azurerm_resource_group.rg_api.name
# #   operation_id        = var.env_short == "d" ? "637608a0c257810fc0ecfe1c" : var.env_short == "u" ? "636cb7e439519a17ec9bf98b" : "63b6e2daea7c4a25440fdaa0"
# #
# #   #tfsec:ignore:GEN005
# #   xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v1/activate_nm3.xml", {
# #     is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
# #     urlenvpath                = var.env_short
# #     url_aks                   = var.env_short == "p" ? "weu${var.env}.apiconfig.internal.platform.pagopa.it" : "weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"
# #   })
# # }
# #
# # resource "azurerm_api_management_api_operation_policy" "nm3_activate_v2_verify_policy_auth" { # activatePaymentNoticeV2 verificatore
# #
# #   api_name            = azurerm_api_management_api.apim_node_for_psp_api_v1_auth.name
# #   api_management_name = data.azurerm_api_management.apim_migrated[0].name
# #   resource_group_name = data.azurerm_resource_group.rg_api.name
# #   operation_id        = var.env_short == "d" ? "637608a0c257810fc0ecfe21" : var.env_short == "u" ? "63756cf1451c1c01c4186baa" : "63b6e2daea7c4a25440fdaa5"
# #
# #   #tfsec:ignore:GEN005
# #   xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v2/activate_nm3.xml", {
# #     is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
# #     urlenvpath                = var.env_short
# #     url_aks                   = var.env_short == "p" ? "weu${var.env}.apiconfig.internal.platform.pagopa.it" : "weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"
# #   })
# # }
