##############
## Products ##
##############

module "apim_api_config_product" {
  count  = var.api_config_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.84"

  product_id   = "product-api-config"
  display_name = "product-api-config"
  description  = "product-api-config"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 50

  policy_xml = file("./api_product/apiconfig_api/_base_policy.xml")
}

##############
##    API   ##
##############

module "apim_api_config_api" {
  count  = var.api_config_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-api-config-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_api_config_product[0].product_id]
  subscription_required = true

  description  = "api config api"
  display_name = "api config api"
  path         = "apiconfig/api"
  protocols    = ["https"]

  service_url = format("https://%s/apiconfig/api/v1", module.api_config_app_service[0].default_site_hostname)

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig_api/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/apiconfig_api/v1/_base_policy.xml")
}
