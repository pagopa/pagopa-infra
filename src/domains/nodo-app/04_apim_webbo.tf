##############
## Products ##
##############

module "apim_webbo_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "webbo"
  display_name = "WebBO for NDP"
  description  = "WebBO for NDP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/webbo-service/_base_policy.xml")
}

########################
##    webbo  NDP    ##
########################
locals {
  apim_webbo_service_api = {
    display_name          = "WebBO for NDP"
    description           = "API webbo for NDP"
    path                  = "bo-nodo"
    subscription_required = false
    service_url           = null
  }
}

# resource "azurerm_api_management_api_version_set" "api_webbo_api" {
#   name                = format("%s-webbo-service-api", var.env_short)
#   resource_group_name = local.pagopa_apim_rg
#   api_management_name = local.pagopa_apim_name
#   display_name        = local.apim_webbo_service_api.display_name
#   versioning_scheme   = "Segment"
# }


module "apim_api_webbo_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-webbo-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_webbo_product.product_id]
  subscription_required = local.apim_webbo_service_api.subscription_required
  #version_set_id        = azurerm_api_management_api_version_set.api_webbo_api.id
  #api_version           = "v1"

  description  = local.apim_webbo_service_api.description
  display_name = local.apim_webbo_service_api.display_name
  path         = local.apim_webbo_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_webbo_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/webbo-service/v1/_webbo.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/webbo-service/v1/_base_policy.xml", {
    hostname = local.nodo_hostname
    dns_pagopa_platform = format("api.%s.%s", var.apim_dns_zone_prefix, var.external_domain)
    apim_base_path      = "/bo-nodo"
  })
  
}
