# ##############
# ## Products ##
# ##############
#
# module "apim_nodo_dei_pagamenti_product_auth" {
#   source = "./.terraform/modules/__v3__/api_management_product"
#
#   product_id   = "nodo-auth"
#   display_name = "Nodo dei Pagamenti (Nuova Connettività)"
#   description  = "Product for Nodo dei Pagamenti (Nuova Connettività)"
#
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
#
#   published             = true
#   subscription_required = true
#   approval_required     = var.env_short == "p" ? true : false
#   subscriptions_limit   = var.nodo_auth_subscription_limit
#
#
#   policy_xml = var.apim_nodo_auth_decoupler_enable ? templatefile("./api_product/legacy/nodo_pagamenti_api/decoupler/base_policy.xml.tpl", { # decoupler ON
#     address-range-from       = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
#     address-range-to         = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
#     is-nodo-auth-pwd-replace = true
#   }) : file("./api_product/legacy/nodo_pagamenti_api/auth/_base_policy.xml") # decoupler OFF
# }
#
# locals {
#
#   api_nodo_product_auth = [
#     format("%s-node-for-psp-api-auth", var.env_short),
#     format("%s-nodo-per-psp-api-auth", var.env_short),
#     format("%s-node-for-io-api-auth", var.env_short),
#     format("%s-nodo-per-pa-api-auth", var.env_short),
#     format("%s-node-for-pa-api-auth", var.env_short),
#     format("%s-nodo-per-psp-richiesta-avvisi-api-auth", var.env_short),
#     format("%s-weu-aca-api-v1", "${var.prefix}-${var.env_short}") // add ACA to nuova conn, feature needs creare un 2 prodotti separati per nuova connettività x EC e x PSP con in + per gli EC ACA
#   ]
#
# }
#
# resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_auth" {
#   for_each = toset(local.api_nodo_product_auth)
#
#   api_name            = each.key
#   product_id          = "nodo-auth"
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
#
#   # Aggiungiamo una dipendenza esplicita per garantire che il prodotto venga
#   # creato *prima* di tentare di collegare le API, visto che abbiamo rimosso il link implicito.
#   depends_on = [
#     module.apim_nodo_dei_pagamenti_product_auth
#   ]
# }
#
# ## NAMED VALUE
#
# resource "azurerm_api_management_named_value" "nodo_auth_password_value" {
#   name                = "nodoAuthPassword"
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
#   display_name        = "nodoAuthPassword"
#   value               = var.nodo_pagamenti_auth_password
# }
#
# resource "azurerm_api_management_named_value" "x_forwarded_for_value" {
#   name                = "xForwardedFor"
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
#   display_name        = "xForwardedFor"
#   value               = data.azurerm_api_management.apim.private_ip_addresses[0]
# }
#
# resource "azurerm_api_management_named_value" "ndp_disable_activate" {
#   name                = "ndp-disable-activate"
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
#   display_name        = "ndp-disable-activate"
#   value               = "false"
# }
#
