##############
## Products ##
##############

module "apim_nodo_dei_pagamenti_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "nodo"
  display_name = "Nodo dei Pagamenti"
  description  = "Product for Nodo dei Pagamenti"

  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = var.nodo_pagamenti_subkey_required
  approval_required     = false

  policy_xml = var.apim_nodo_decoupler_enable ? templatefile("base_policy.xml", { # decoupler ON
    address-range-from       = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to         = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
    is-nodo-auth-pwd-replace = false
    }) : templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", { # decoupler OFF
    address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
  })
}

locals {
  api_nodo_product = [
    azurerm_api_management_api.apim_node_for_psp_api_v1.name,
    azurerm_api_management_api.apim_nodo_per_psp_api_v1.name,
    azurerm_api_management_api.apim_node_for_io_api_v1.name,
    azurerm_api_management_api.apim_nodo_per_pa_api_v1.name,
    azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1.name,
    module.apim_nodo_per_pm_api_v1.name,
    module.apim_nodo_per_pm_api_v2.name,
  ]
}
# associate API to product
resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api" {
  for_each = toset(local.api_nodo_product)

  api_name            = each.key
  product_id          = module.apim_nodo_dei_pagamenti_product.product_id
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name
}
