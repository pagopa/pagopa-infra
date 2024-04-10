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

# decoupler algorithm fragment
resource "azapi_resource" "decoupler_algorithm_wisp" {
  count = var.env_short == "d" ? 1 : 0

  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "decoupler-algorithm-wisp"
  parent_id = module.apim.id

  body = jsonencode({
    properties = {
      description = "[WISP] Logic about NPD decoupler"
      format      = "rawxml"
      value       = file("./api_product/nodo_pagamenti_api/wisp_decoupler/decoupler-algorithm-wisp.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

# fragment for managing outbound policy if primitive is activatePayment or activateIO
resource "azapi_resource" "decoupler_activate_outbound_wisp" {
  count = var.env_short == "d" ? 1 : 0

  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "decoupler-activate-outbound-wisp"
  parent_id = module.apim.id

  body = jsonencode({
    properties = {
      description = "[WISP] Outbound logic for Activate primitive of NDP decoupler"
      format      = "rawxml"
      value       = file("./api_product/nodo_pagamenti_api/wisp_decoupler/decoupler-activate-outbound-wisp.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}
