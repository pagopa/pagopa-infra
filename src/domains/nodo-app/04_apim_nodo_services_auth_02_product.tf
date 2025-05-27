##############
## Products ##
##############

locals {

  base_policy_nodo = templatefile("./api_product/nodo_pagamenti_api/base_policy.xml.tpl", { # decoupler ON
    address-range-from       = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to         = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
    is-nodo-auth-pwd-replace = true
  })

  api_nodo_product_auth = [
    # azurerm_api_management_api.apim_node_for_psp_api_v1_auth.name,
    # azurerm_api_management_api.apim_nodo_per_psp_api_v1_auth.name,
    # azurerm_api_management_api.apim_node_for_io_api_v1_auth.name,
    # azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.name,
    # azurerm_api_management_api.apim_node_for_pa_api_v1_auth.name,
    # azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_auth.name,
    # data.azurerm_api_management_api.apim_aca_api_v1_.name // add ACA to nuova conn, feature needs creare un 2 prodotti separati per nuova connettività x EC e x PSP con in + per gli EC ACA
  ]

}

resource "terraform_data" "sha256_apim_nodo_dei_pagamenti_product_auth" {
  input = sha256(local.base_policy_nodo)
}

module "apim_nodo_dei_pagamenti_product_auth" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "nodo-auth-2-0" #TODO [FCADAC] remove -2-0
  display_name = "AAA Nodo dei Pagamenti (Nuova Connettività) 2.0" #TODO [FCADAC] remove AAA 2.0
  description  = "AAA Product for Nodo dei Pagamenti (Nuova Connettività) 2.0" #TODO [FCADAC] remove AAA 2.0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = var.env_short == "p" ? true : false
  subscriptions_limit   = var.nodo_auth_subscription_limit

  policy_xml = local.base_policy_nodo

  depends_on = [
    azurerm_api_management_policy_fragment.nuova_connettivita_policy
  ]
}

# resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_auth" {
#   for_each = toset(local.api_nodo_product_auth)
#
#   api_name            = each.key
#   product_id          = module.apim_nodo_dei_pagamenti_product_auth.product_id
#   api_management_name = data.azurerm_api_management.apim.name
#   resource_group_name = data.azurerm_api_management.apim.resource_group_name
# }

## NAMED VALUE

# resource "azurerm_api_management_named_value" "nodo_auth_password_value" {
#   name                = "nodoAuthPassword"
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   display_name        = "nodoAuthPassword"
#   value               = var.nodo_pagamenti_auth_password
# }
#
# resource "azurerm_api_management_named_value" "x_forwarded_for_value" {
#   name                = "xForwardedFor"
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   display_name        = "xForwardedFor"
#   value               = data.azurerm_api_management.apim_migrated[0].private_ip_addresses[0]
# }
