##################################
## Node auth for eCommerce API  ##
##################################
locals {
  apim_node_for_ecommerce_api = {
    display_name          = "Node for eCommerce API"
    description           = "API to support eCommerce transactions"
    path                  = "nodo-auth/node-for-ecommerce"
    subscription_required = var.nodo_pagamenti_subkey_required
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "node_for_ecommerce_api" {

  name                = "${local.project}-node-for-ecommerce-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_node_for_ecommerce_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_node_for_ecommerce_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = "${local.project}-node-for-ecommerce-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  subscription_required = local.apim_node_for_ecommerce_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_ecommerce_api.id
  api_version           = "v1"
  service_url           = local.apim_node_for_ecommerce_api.service_url

  description  = local.apim_node_for_ecommerce_api.description
  display_name = local.apim_node_for_ecommerce_api.display_name
  path         = local.apim_node_for_ecommerce_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodeForEcommerce/v1/_openapi.json.tpl", {
    host    = local.api_domain
    service = module.apim_nodo_dei_pagamenti_product.product_id
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodeForEcommerce/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })
}

resource "azurerm_api_management_api_operation_policy" "auth_close_payment_api_v1" {
  api_name            = "${local.project}-node-for-ecommerce-api-v1"
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = "closePayment"
  xml_content = templatefile("./api/nodopagamenti_api/nodeForEcommerce/v1/_add_v1_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })
}


module "apim_node_for_ecommerce_api_v2" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = "${local.project}-node-for-ecommerce-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  subscription_required = local.apim_node_for_ecommerce_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_ecommerce_api.id
  api_version           = "v2"
  service_url           = local.apim_node_for_ecommerce_api.service_url

  description  = local.apim_node_for_ecommerce_api.description
  display_name = local.apim_node_for_ecommerce_api.display_name
  path         = local.apim_node_for_ecommerce_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodeForEcommerce/v2/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodeForEcommerce/v2/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })
}

# WISP closePaymentV2
resource "azurerm_api_management_api_operation_policy" "auth_close_payment_api_v2_wisp_policy" {
  count               = var.create_wisp_converter ? 1 : 0
  api_name            = "${local.project}-node-for-ecommerce-api-v2"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  operation_id        = "closePaymentV2"
  xml_content         = file("./api/nodopagamenti_api/nodeForEcommerce/v2/wisp-closepayment.xml")
}

