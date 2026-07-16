# # Please consider these API are deprecated and will be removed in the future
# # The new API is defined in the file apim_nodo_services_auth_09_node_for_ecommerce
#
# ######################
# ## Nodo per PM API  ##
# ######################
# locals {
#   apim_nodo_per_pm_api = {
#     display_name          = "[Deprecated] Nodo per Payment Manager API"
#     description           = "[Deprecated] API to support Payment Manager"
#     path                  = "nodo/nodo-per-pm"
#     subscription_required = var.nodo_pagamenti_subkey_required
#     service_url           = null
#   }
# }
#
# resource "azurerm_api_management_api_version_set" "nodo_per_pm_api" {
#
#   name                = format("%s-nodo-per-pm-api", local.product)
#   resource_group_name = local.pagopa_apim_rg
#   api_management_name = local.pagopa_apim_name
#   display_name        = local.apim_nodo_per_pm_api.display_name
#   versioning_scheme   = "Segment"
# }
#
# #fetch technical support api product APIM product
# data "azurerm_api_management_product" "technical_support_api_product" {
#   product_id          = "technical_support_api"
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
# }
#
# module "apim_nodo_per_pm_api_v1" {
#
#   source = "./.terraform/modules/__v3__/api_management_api"
#
#
#   name                  = format("%s-nodo-per-pm-api", local.product)
#   api_management_name   = local.pagopa_apim_name
#   resource_group_name   = local.pagopa_apim_rg
#   product_ids           = [data.azurerm_api_management_product.technical_support_api_product.product_id]
#   subscription_required = local.apim_nodo_per_pm_api.subscription_required
#   version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api.id
#   api_version           = "v1"
#   service_url           = local.apim_nodo_per_pm_api.service_url
#
#   description  = local.apim_nodo_per_pm_api.description
#   display_name = local.apim_nodo_per_pm_api.display_name
#   path         = local.apim_nodo_per_pm_api.path
#   protocols    = ["https"]
#
#   content_format = "swagger-json"
#   content_value = templatefile("./api/legacy/nodopagamenti_api/nodoPerPM/v1/_swagger.json.tpl", {
#     host    = local.apim_hostname
#     service = module.apim_nodo_dei_pagamenti_product.product_id
#   })
#
#   xml_content = templatefile("./api/legacy/nodopagamenti_api/nodoPerPM/v1/_base_policy.xml.tpl", {
#     is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
#   })
# }
#
# resource "azurerm_api_management_api_operation_policy" "close_payment_api_v1" {
#   api_name            = format("%s-nodo-per-pm-api-v1", local.product)
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
#   operation_id        = "closePayment"
#   xml_content = templatefile("./api/legacy/nodopagamenti_api/nodoPerPM/v1/_add_v1_policy.xml.tpl", {
#     is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
#   })
# }
#
# resource "azurerm_api_management_api_operation_policy" "parked_list_api_v1" {
#   api_name            = format("%s-nodo-per-pm-api-v1", local.product)
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
#   operation_id        = "parkedList"
#   xml_content = templatefile("./api/legacy/nodopagamenti_api/nodoPerPM/v1/_add_v1_policy.xml.tpl", {
#     is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
#   })
# }
#
# module "apim_nodo_per_pm_api_v2" {
#   source = "./.terraform/modules/__v3__/api_management_api"
#
#
#   name                  = format("%s-nodo-per-pm-api", local.product)
#   api_management_name   = local.pagopa_apim_name
#   resource_group_name   = local.pagopa_apim_rg
#   subscription_required = local.apim_nodo_per_pm_api.subscription_required
#   version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api.id
#   api_version           = "v2"
#   service_url           = local.apim_nodo_per_pm_api.service_url
#
#   description  = local.apim_nodo_per_pm_api.description
#   display_name = local.apim_nodo_per_pm_api.display_name
#   path         = local.apim_nodo_per_pm_api.path
#   protocols    = ["https"]
#
#   content_format = "swagger-json"
#   content_value = templatefile("./api/legacy/nodopagamenti_api/nodoPerPM/v2/_swagger.json.tpl", {
#     host = local.apim_hostname
#   })
#
#   xml_content = templatefile("./api/legacy/nodopagamenti_api/nodoPerPM/v2/_base_policy.xml.tpl", {
#     is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
#   })
# }
#
# # WISP closePaymentV2
# resource "azurerm_api_management_api_operation_policy" "close_payment_api_v2_wisp_policy" {
#   count               = var.create_wisp_converter ? 1 : 0
#   api_name            = "${local.product}-nodo-per-pm-api-v2"
#   resource_group_name = local.pagopa_apim_rg
#   api_management_name = local.pagopa_apim_name
#   operation_id        = "closePaymentV2"
#   xml_content         = file("./api/legacy/nodopagamenti_api/nodoPerPM/v2/wisp-closepayment.xml")
# }
#
