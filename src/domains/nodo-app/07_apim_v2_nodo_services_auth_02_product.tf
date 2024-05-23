##############
## Products ##
##############

module "apim_nodo_dei_pagamenti_product_auth" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.60.0"
  count  = var.enabled_features.apim_v2 ? 1 : 0

  product_id   = "nodo-auth"
  display_name = "Nodo dei Pagamenti (Nuova Connettività)"
  description  = "Product for Nodo dei Pagamenti (Nuova Connettività)"

  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_v2_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = var.nodo_auth_subscription_limit


  policy_xml = var.apim_nodo_auth_decoupler_enable ? templatefile("./api_product/nodo_pagamenti_api/decoupler/base_policy.xml.tpl", { # decoupler ON
    address-range-from       = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to         = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
    is-nodo-auth-pwd-replace = true
  }) : file("./apim_v2/api_product/nodo_pagamenti_api/auth/_base_policy.xml") # decoupler OFF
}

data "azurerm_api_management_api" "apim_aca_api_v1_" {
  count = var.enabled_features.apim_v2 ? 1 : 0

  name                = format("%s-weu-aca-api-v1", "${var.prefix}-${var.env_short}") // pagopa-<ENV>-weu-aca-api-v1
  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_v2_rg
  revision            = "1"
}


locals {

  api_nodo_product_auth = var.enabled_features.apim_v2 ? [
    azurerm_api_management_api.apim_node_for_psp_api_v1_auth[0].name,
    azurerm_api_management_api.apim_nodo_per_psp_api_v1_auth[0].name,
    azurerm_api_management_api.apim_node_for_io_api_v1_auth[0].name,
    azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth[0].name,
    azurerm_api_management_api.apim_node_for_pa_api_v1_auth[0].name,
    azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_auth[0].name,
    data.azurerm_api_management_api.apim_aca_api_v1_[0].name // add ACA to nuova conn, feature needs creare un 2 prodotti separati per nuova connettività x EC e x PSP con in + per gli EC ACA
  ] : []


}

resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_auth" {
  for_each = toset(local.api_nodo_product_auth)

  api_name            = each.key
  product_id          = module.apim_nodo_dei_pagamenti_product_auth[0].product_id
  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_v2_rg
}

## NAMED VALUE

resource "azurerm_api_management_named_value" "nodo_auth_password_value" {
  count = var.enabled_features.apim_v2 ? 1 : 0

  name                = "nodoAuthPassword"
  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_v2_rg
  display_name        = "nodoAuthPassword"
  value               = var.nodo_pagamenti_auth_password
}

resource "azurerm_api_management_named_value" "x_forwarded_for_value" {
  count = var.enabled_features.apim_v2 ? 1 : 0

  name                = "xForwardedFor"
  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_v2_rg
  display_name        = "xForwardedFor"
  value               = var.nodo_pagamenti_x_forwarded_for
}