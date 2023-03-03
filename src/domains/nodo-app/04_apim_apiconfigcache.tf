##############
## Products ##
##############

module "apim_apiconfig_cache_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"
  count  = var.env_short == "d" ? 1 : 0

  product_id   = "apiconfig_cache"
  display_name = "Apiconfig cache app"
  description  = "Apiconfig cache app"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/apiconfig-cache-service/_base_policy.xml")
}

########################
## Apiconfig cache    ##
########################
locals {
  apim_apiconfig_cache_service_api = {
    display_name          = "apiconfig_cache"
    description           = "Apiconfig cache app"
    path                  = "apiconfig-cache-ndp/service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_apiconfig_cache_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-apiconfig-cache-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_apiconfig_cache_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_apiconfig_cache_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"
  count  = var.env_short == "d" ? 1 : 0

  name                  = format("%s-apiconfig-cache-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_cache_product[0].product_id]
  subscription_required = local.apim_apiconfig_cache_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_apiconfig_cache_api[0].id
  api_version           = "v1"

  description  = local.apim_apiconfig_cache_service_api.description
  display_name = local.apim_apiconfig_cache_service_api.display_name
  path         = local.apim_apiconfig_cache_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_apiconfig_cache_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-cache-service/v1/_apiconfig-cache.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/apiconfig-cache-service/v1/_base_policy.xml", {
    hostname = local.nodo_hostname
  })
}
