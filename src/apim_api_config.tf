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

locals {
  pagopa_tenant_id       = data.azurerm_client_config.current.tenant_id
  apiconfig_be_client_id = data.azuread_application.apiconfig-be.application_id
}

module "apim_api_config_api" {
  count  = var.api_config_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.0.12"

  name                  = format("%s-api-config-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_api_config_product[0].product_id]
  subscription_required = false
  oauth2_authorization = {
    authorization_server_name = "apiconfig-oauth2"
  }

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
    origin                 = format("https://%s.%s.%s", var.cname_record_name, var.dns_zone_prefix, var.external_domain)
    pagopa_tenant_id       = local.pagopa_tenant_id
    apiconfig_be_client_id = local.apiconfig_be_client_id
  })
}

########################
##    CONFIGURATION   ##
########################

data "azuread_application" "apiconfig-fe" {
  display_name = "pagopa-apiconfig-fe"
}
data "azuread_application" "apiconfig-be" {
  display_name = "pagopa-apiconfig-be"
}


resource "azurerm_api_management_authorization_server" "apiconfig-oauth2" {
  name                         = "apiconfig-oauth2"
  api_management_name          = module.apim.name
  resource_group_name          = azurerm_resource_group.rg_api.name
  display_name                 = "apiconfig-oauth2"
  authorization_endpoint       = "https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize"
  client_id                    = data.azuread_application.apiconfig-fe.application_id
  client_registration_endpoint = "http://localhost"

  grant_types           = ["authorizationCode"]
  authorization_methods = ["GET", "POST"]

  token_endpoint = "https://login.microsoftonline.com/organizations/oauth2/v2.0/token"
  default_scope = format("%s/%s",
    data.azuread_application.apiconfig-be.identifier_uris[0],
  "access-apiconfig-be")
  client_secret = data.azurerm_key_vault_secret.apiconfig-client-secret.value

  bearer_token_sending_methods = ["authorizationHeader"]
  client_authentication_method = ["Body"]

}
