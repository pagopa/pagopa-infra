##############
## Products ##
##############

module "apim_api_config_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "product-api-config"
  display_name = "ApiConfig JWT"
  description  = "Product for API Configuration with JWT "

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/apiconfig_api/_base_policy.xml")
}



##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_config_api" {

  name                = format("%s-api-config-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "ApiConfig JWT"
  versioning_scheme   = "Segment"
}

locals {
  hostname = var.env == "prod" ? "weuprod.apiconfig.internal.platform.pagopa.it" : "weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"

  pagopa_tenant_id       = data.azurerm_client_config.current.tenant_id
  apiconfig_be_client_id = data.azuread_application.apiconfig-be.application_id
  apiconfig_fe_client_id = data.azuread_application.apiconfig-fe.application_id
}

module "apim_api_config_api" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-api-config-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_api_config_product.product_id]
  subscription_required = false
  oauth2_authorization = {
    authorization_server_name = "apiconfig-oauth2"
  }

  version_set_id = azurerm_api_management_api_version_set.api_config_api.id
  api_version    = "v1"

  description  = "Api configuration with JWT"
  display_name = "ApiConfig JWT"
  path         = "apiconfig/api"
  protocols    = ["https"]

  #  service_url = format("https://%s/apiconfig/api/v1", module.api_config_app_service.default_site_hostname)
  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig_api/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_api_config_product.product_id
  })

  xml_content = templatefile("./api/apiconfig_api/jwt/v1/_base_policy.xml.tpl", {
    hostname               = local.apiconfig_core_locals.hostname
    origin                 = format("https://%s.%s.%s", var.cname_record_name, var.apim_dns_zone_prefix, var.external_domain)
    pagopa_tenant_id       = local.pagopa_tenant_id
    apiconfig_be_client_id = local.apiconfig_be_client_id
    apiconfig_fe_client_id = local.apiconfig_fe_client_id
  })
}

########################
##    CONFIGURATION   ##
########################

resource "azurerm_api_management_authorization_server" "apiconfig-oauth2" {
  name                         = "apiconfig-oauth2"
  api_management_name          = local.pagopa_apim_name
  resource_group_name          = local.pagopa_apim_rg
  display_name                 = "apiconfig-oauth2"
  authorization_endpoint       = "https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize"
  client_id                    = data.azuread_application.apiconfig-fe.application_id
  client_registration_endpoint = "http://localhost"

  grant_types           = ["authorizationCode"]
  authorization_methods = ["GET", "POST"]

  #tfsec:ignore:GEN003
  token_endpoint = "https://login.microsoftonline.com/organizations/oauth2/v2.0/token"
  default_scope = format("%s/%s",
    data.azuread_application.apiconfig-be.identifier_uris[0],
  "access-apiconfig-be")
  # client_secret = azurerm_key_vault_secret.apiconfig_client_secret.value

  bearer_token_sending_methods = ["authorizationHeader"]
  client_authentication_method = ["Body"]

}


########################
## Products for Auth  ##
## version for subkey ##
########################

module "apim_api_config_auth_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "product-api-config-auth"
  display_name = "ApiConfig SubKey"
  description  = "Product for API Configuration SubKey for B2B"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/apiconfig_api/_base_policy_auth.xml")
}

###########################
##  API for Subscribers  ##
###########################
data "azurerm_api_management_product" "apim_aca_integration_product" {
  product_id          = "aca-integration"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management_product" "technical_support_api_product" {
  product_id          = "technical_support_api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

resource "azurerm_api_management_api_version_set" "api_config_auth_api" {

  name                = format("%s-api-config-auth-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ApiConfig SubKey"
  versioning_scheme   = "Segment"
}

module "apim_api_config_auth_api" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-api-config-auth-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_api_config_auth_product.product_id, data.azurerm_api_management_product.apim_aca_integration_product.product_id, data.azurerm_api_management_product.technical_support_api_product.product_id]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.api_config_auth_api.id
  api_version    = "v1"

  description  = "Api configuration for B2B"
  display_name = "ApiConfig SubKey"
  path         = "apiconfig/auth/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig_api/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_api_config_auth_product.product_id
  })

  xml_content = templatefile("./api/apiconfig_api/subkey/v1/_base_policy.xml.tpl", {
    hostname    = local.apiconfig_core_locals.hostname
    origin      = "*"
    addMockResp = var.env_short != "d" ? "true" : "false"
  })
}
