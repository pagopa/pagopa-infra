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
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/apiconfig_api/_base_policy.xml")
}

##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_config_api" {
  count = var.api_config_enabled ? 1 : 0

  name                = format("%s-api-config-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "api config api"
  versioning_scheme   = "Segment"
}

module "apim_api_config_api" {
  count  = var.api_config_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-api-config-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_api_config_product[0].product_id]
  subscription_required = false
#  oauth2_authorization  = {
#    authorization_server_name = "apiconfig-oauth2"
#  }

  version_set_id = azurerm_api_management_api_version_set.api_config_api[0].id
  api_version    = "v1"

  description  = "api config api"
  display_name = "api config api"
  path         = "apiconfig/api"
  protocols    = ["https"]

  service_url = format("https://%s/apiconfig/api/v1", module.api_config_app_service[0].default_site_hostname)

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig_api/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/apiconfig_api/v1/_base_policy.xml.tpl", {
    origin = format("https://%s.%s.%s", var.cname_record_name, var.dns_zone_prefix, var.external_domain)
    pagopa_tenant_id = data.azurerm_client_config.current.tenant_id
    apiconfig_be_client_id = azuread_application.apiconfig-be.application_id
  })
}
