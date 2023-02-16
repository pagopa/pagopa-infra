#############################
##         Product         ##
#############################

locals {
  apim_apiconfig_service_api = {
    display_name          = "Api Config"
    description           = "Api configuration for Nodo dei Pagamenti"
    path                  = "apiconfig/service"
    subscription_required = true
    service_url           = null
  }
}

module "apim_apiconfig_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.17"

  product_id   = "apiconfig"
  display_name = local.apim_apiconfig_service_api.display_name
  description  = local.apim_apiconfig_service_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = local.apim_apiconfig_service_api.subscription_required
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/apiconfig/_base_policy.xml")
}

#############################
##         API Core        ##
#############################


resource "azurerm_api_management_api_version_set" "api_apiconfig_core_api" {
  name                = format("%s-apiconfig-core-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_apiconfig_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_apiconfig_core_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.17"

  name                  = format("%s-apiconfig-core-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_product.product_id]
  subscription_required = local.apim_apiconfig_service_api.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_core_api.id
  api_version    = "v1"

  description  = local.apim_apiconfig_service_api.description
  display_name = local.apim_apiconfig_service_api.display_name
  path         = local.apim_apiconfig_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_apiconfig_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-core/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/apiconfig-core/v1/_base_policy.xml", {
    hostname = local.apiconfig_hostname
  })
}
