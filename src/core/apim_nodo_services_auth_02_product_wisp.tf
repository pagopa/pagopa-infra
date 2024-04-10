##############
## Products ##
##############

module "apim_nodo_dei_pagamenti_product_auth_wisp" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "nodo-auth-wisp"
  display_name = "Nodo dei Pagamenti WISP (Nuova Connettività)"
  description  = "Product for Nodo dei Pagamenti WISP (Nuova Connettività)"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = var.nodo_auth_subscription_limit


  policy_xml = var.apim_nodo_auth_decoupler_enable ? templatefile("./api_product/nodo_pagamenti_api/wisp_decoupler/base_policy.xml.tpl", { # decoupler ON
    address-range-from       = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to         = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
    is-nodo-auth-pwd-replace = true
  }) : file("./api_product/nodo_pagamenti_api/auth/_base_policy.xml") # decoupler OFF
}




locals {

  api_nodo_product_auth_wisp = [
    azurerm_api_management_api.apim_node_for_psp_api_v1_auth.name,
    azurerm_api_management_api.apim_nodo_per_psp_api_v1_auth.name,
    #azurerm_api_management_api.apim_node_for_io_api_v1_auth.name,
    azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.name,
    #azurerm_api_management_api.apim_node_for_pa_api_v1_auth.name,
    #azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_auth.name
  ]

}

resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_auth_wisp" {
  for_each = toset(local.api_nodo_product_auth_wisp)

  api_name            = each.key
  product_id          = module.apim_nodo_dei_pagamenti_product_auth_wisp.product_id
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
}

