#module "apim_nodo_dei_pagamenti_product_auth_test" {
#  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"
#
#  product_id   = "nodo-auth-test"
#  display_name = "Nodo dei Pagamenti (Nuova Connettività) TEST"
#  description  = "Product for Nodo dei Pagamenti (Nuova Connettività) TEST"
#
#  api_management_name = module.apim.name
#  resource_group_name = azurerm_resource_group.rg_api.name
#
#  published             = true
#  subscription_required = true
#  approval_required     = true
#  subscriptions_limit   = var.nodo_auth_subscription_limit
#
#  policy_xml = var.apim_nodo_auth_decoupler_enable ? templatefile("./api_product/nodo_pagamenti_api/decoupler/base_policy_test.xml.tpl", { # decoupler ON
#    address-range-from       = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
#    address-range-to         = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
#    base-url                 = azurerm_api_management_named_value.default_nodo_backend.value
#    base-node-id             = azurerm_api_management_named_value.default_nodo_id.value
#    is-nodo-auth-pwd-replace = true
#  }) : file("./api_product/nodo_pagamenti_api/auth/_base_policy.xml") # decoupler OFF
#}
#
##########
### API ##
##########
#
#resource "azurerm_api_management_api" "apim_node_for_psp_api_v1_auth_test" {
#  name                  = format("%s-node-for-psp-api-auth-test", var.env_short)
#  api_management_name   = module.apim.name
#  resource_group_name   = azurerm_resource_group.rg_api.name
#  subscription_required = local.apim_node_for_psp_api_auth.subscription_required
#  version_set_id        = azurerm_api_management_api_version_set.node_for_psp_api_auth.id
#  version               = "v1-test"
#  service_url           = local.apim_node_for_psp_api_auth.service_url
#  revision              = "1"
#
#  description  = local.apim_node_for_psp_api_auth.description
#  display_name = local.apim_node_for_psp_api_auth.display_name
#  path         = local.apim_node_for_psp_api_auth.path
#  protocols    = ["https"]
#
#  soap_pass_through = true
#
#  import {
#    content_format = "wsdl"
#    content_value  = file("./api/nodopagamenti_api/nodeForPsp/v1/auth/nodeForPsp.wsdl")
#    wsdl_selector {
#      service_name  = "nodeForPsp_Service"
#      endpoint_name = "nodeForPsp_Port"
#    }
#  }
#}
#
#
#resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_auth_test" {
#  api_name            = azurerm_api_management_api.apim_node_for_psp_api_v1_auth_test.name
#  product_id          = module.apim_nodo_dei_pagamenti_product_auth_test.product_id
#  api_management_name = module.apim.name
#  resource_group_name = azurerm_resource_group.rg_api.name
#}
#
#resource "azurerm_api_management_api_policy" "apim_node_for_psp_policy_auth_test" {
#  api_name            = azurerm_api_management_api.apim_node_for_psp_api_v1_auth_test.name
#  api_management_name = module.apim.name
#  resource_group_name = azurerm_resource_group.rg_api.name
#
#  xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v1/_base_policy_api_test.xml.tpl", {
#    base-url                  = var.env_short == "p" ? "{{urlnodo}}" : azurerm_api_management_named_value.default_nodo_backend.value
#    is-nodo-decoupler-enabled = var.apim_nodo_auth_decoupler_enable
#  })
#}
