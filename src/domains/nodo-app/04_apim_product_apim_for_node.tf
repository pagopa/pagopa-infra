# This product groups each API called by node
module "apim_apim_for_node_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v5.1.0"

  product_id   = local.apim_for_node.product_id
  display_name = local.apim_for_node.display_name
  description  = local.apim_for_node.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apim_for_node.subscription_required
  approval_required     = local.apim_for_node.approval_required
  subscriptions_limit   = local.apim_for_node.subscription_limit

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}


resource "azurerm_api_management_product_group" "access_control_developers_for_cache" {
  product_id          = module.apim_apim_for_node_product.product_id
  group_name          = data.azurerm_api_management_group.group_developers.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
