# ##############
# ## Products ##
# ##############
#
# module "apim_nodo_dei_pagamenti_product" {
#   source = "./.terraform/modules/__v3__/api_management_product"
#
#   product_id   = "nodo"
#   display_name = "Nodo dei Pagamenti"
#   description  = "Product for Nodo dei Pagamenti"
#
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
#
#   published             = true
#   subscription_required = var.nodo_pagamenti_subkey_required
#   approval_required     = false
#
#   policy_xml = var.apim_nodo_decoupler_enable ? templatefile("./api_product/legacy/nodo_pagamenti_api/decoupler/base_policy.xml.tpl", { # decoupler ON
#     address-range-from       = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
#     address-range-to         = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
#     is-nodo-auth-pwd-replace = false
#     }) : templatefile("./api_product/legacy/nodo_pagamenti_api/_base_policy.xml", { # decoupler OFF
#     address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
#     address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
#   })
# }
#
# # associate API to product
# resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_for_psp" {
#
#   api_name            = azurerm_api_management_api.apim_node_for_psp_api_v1.name
#   product_id          = module.apim_nodo_dei_pagamenti_product.product_id
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
# }
# resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_per_psp" {
#   api_name            = azurerm_api_management_api.apim_nodo_per_psp_api_v1.name
#   product_id          = module.apim_nodo_dei_pagamenti_product.product_id
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
# }
# resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_for_io" {
#   api_name            = azurerm_api_management_api.apim_node_for_io_api_v1.name
#   product_id          = module.apim_nodo_dei_pagamenti_product.product_id
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
# }
# resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_per_pa" {
#   api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
#   product_id          = module.apim_nodo_dei_pagamenti_product.product_id
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
# }
# resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_avv" {
#   api_name            = azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1.name
#   product_id          = module.apim_nodo_dei_pagamenti_product.product_id
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
# }
# resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_per_pm_v1" {
#   api_name            = module.apim_nodo_per_pm_api_v1.name
#   product_id          = module.apim_nodo_dei_pagamenti_product.product_id
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
# }
# resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_per_pm_v2" {
#   api_name            = module.apim_nodo_per_pm_api_v2.name
#   product_id          = module.apim_nodo_dei_pagamenti_product.product_id
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
# }
#
