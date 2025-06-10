##################################
## Node auth for eCommerce API  ##
##################################
locals {
  apim_node_for_ecommerce_api = {
    display_name          = "Node for eCommerce API"
    description           = "API to support eCommerce transactions"
    path                  = "nodo-auth/node-for-ecommerce"
    subscription_required = true
    service_url           = null
  }
}

module "apim_node_for_ecommerce_product" {

  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "node-for-ecommerce"
  display_name = "Nodo dei Pagamenti - node for eCommerce"
  description  = "Product for Nodo dei Pagamenti API dedicated to eCommerce transactions"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = "./api_product/node_for_ecommerce/_base_policy.xml"
}

resource "azurerm_api_management_api_version_set" "node_for_ecommerce_api" {

  name                = "${local.project}-node-for-ecommerce-api"
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_node_for_ecommerce_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_node_for_ecommerce_api_v1" {

  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = azurerm_api_management_api_version_set.node_for_ecommerce_api.name
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_api_management.apim.resource_group_name
  product_ids           = [module.apim_node_for_ecommerce_product.product_id]
  subscription_required = local.apim_node_for_ecommerce_api.subscription_required

  version_set_id = azurerm_api_management_api_version_set.node_for_ecommerce_api.id
  api_version    = "v1"

  service_url = local.apim_node_for_ecommerce_api.service_url

  description  = local.apim_node_for_ecommerce_api.description
  display_name = local.apim_node_for_ecommerce_api.display_name
  path         = local.apim_node_for_ecommerce_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodeForEcommerce/v1/_openapi.json.tpl", {
    host    = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
    service = module.apim_node_for_ecommerce_product.product_id
  })

  xml_content = file("./api/nodopagamenti_api/nodeForEcommerce/v1/_base_policy.xml.tpl")
}

module "apim_node_for_ecommerce_api_v2" {

  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = azurerm_api_management_api_version_set.node_for_ecommerce_api.name
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_api_management.apim.resource_group_name
  product_ids           = [module.apim_node_for_ecommerce_product.product_id]
  subscription_required = local.apim_node_for_ecommerce_api.subscription_required

  version_set_id = azurerm_api_management_api_version_set.node_for_ecommerce_api.id
  api_version    = "v2"

  service_url = local.apim_node_for_ecommerce_api.service_url

  description  = local.apim_node_for_ecommerce_api.description
  display_name = local.apim_node_for_ecommerce_api.display_name
  path         = local.apim_node_for_ecommerce_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodeForEcommerce/v2/_openapi.json.tpl", {
    host = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  })

  xml_content = file("./api/nodopagamenti_api/nodeForEcommerce/v2/_base_policy.xml.tpl")
}

# WISP closePaymentV2
resource "azurerm_api_management_api_operation_policy" "auth_close_payment_api_v2_wisp_policy" {
  count               = var.create_wisp_converter ? 1 : 0
  api_name            = module.apim_node_for_ecommerce_api_v2.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  api_management_name = data.azurerm_api_management.apim.name
  operation_id        = "closePaymentV2"
  xml_content         = file("./api/nodopagamenti_api/nodeForEcommerce/v2/wisp-closepayment.xml")
}

