##############
## Products ##
##############

module "apim_api_config_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-api-config"
  display_name = "ApiConfig"
  description  = "Product for API Configuration of the Node "

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

  name                = format("%s-api-config-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "ApiConfig for Node"
  versioning_scheme   = "Segment"
}

locals {
  pagopa_tenant_id       = data.azurerm_client_config.current.tenant_id
  apiconfig_be_client_id = data.azuread_application.apiconfig-be.application_id
  apiconfig_fe_client_id = data.azuread_application.apiconfig-fe.application_id
}

module "apim_api_config_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.0.12"

  name                  = format("%s-api-config-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_api_config_product.product_id]
  subscription_required = false
  oauth2_authorization = {
    authorization_server_name = "apiconfig-oauth2"
  }

  version_set_id = azurerm_api_management_api_version_set.api_config_api.id
  api_version    = "v1"

  description  = "Api configuration for Nodo dei Pagamenti"
  display_name = "ApiConfig for Node"
  path         = "apiconfig/api"
  protocols    = ["https"]

  service_url = format("https://%s/apiconfig/api/v1", module.api_config_app_service.default_site_hostname)

  content_format = var.env_short == "p" ? "openapi" : "openapi-link"
  content_value = var.env_short == "p" ? templatefile("./api/apiconfig_api/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  }) : format("https://%s/apiconfig/api/v1/v3/api-docs", module.api_config_app_service.default_site_hostname)

  xml_content = templatefile("./api/apiconfig_api/v1/_base_policy.xml.tpl", {
    origin                 = format("https://%s.%s.%s", var.cname_record_name, var.dns_zone_prefix, var.external_domain)
    pagopa_tenant_id       = local.pagopa_tenant_id
    apiconfig_be_client_id = local.apiconfig_be_client_id
    apiconfig_fe_client_id = local.apiconfig_fe_client_id
  })
}

########################
##    CONFIGURATION   ##
########################

data "azuread_application" "apiconfig-fe" {
  display_name = format("pagopa-%s-apiconfig-fe", var.env_short)
}
data "azuread_application" "apiconfig-be" {
  display_name = format("pagopa-%s-apiconfig-be", var.env_short)
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

  #tfsec:ignore:GEN003
  token_endpoint = "https://login.microsoftonline.com/organizations/oauth2/v2.0/token"
  default_scope = format("%s/%s",
    data.azuread_application.apiconfig-be.identifier_uris[0],
  "access-apiconfig-be")
  client_secret = data.azurerm_key_vault_secret.apiconfig-client-secret.value

  bearer_token_sending_methods = ["authorizationHeader"]
  client_authentication_method = ["Body"]

}


###########################
## Products for Auth ##
###########################

module "apim_api_config_auth_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-api-config-auth"
  display_name = "ApiConfig for Auth"
  description  = "Product for API Configuration of the Node for Auth"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/apiconfig_api/_base_policy_auth.xml")
}

########################
##  API for Subscribers  ##
########################

resource "azurerm_api_management_api_version_set" "api_config_auth_api" {

  name                = format("%s-api-config-auth-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "ApiConfig for Auth"
  versioning_scheme   = "Segment"
}

module "apim_api_config_auth_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.0.12"

  name                = format("%s-api-config-auth-api", var.env_short)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  product_ids         = [module.apim_api_config_auth_product.product_id]

  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.api_config_auth_api.id
  api_version    = "v1"

  description  = "Api configuration for Auth"
  display_name = "ApiConfig for Auth"
  path         = "apiconfig/auth/api"
  protocols    = ["https"]

  service_url = format("https://%s/apiconfig/api/v1", module.api_config_app_service.default_site_hostname)

  content_format = var.env_short == "p" ? "openapi" : "openapi-link"
  content_value = var.env_short == "p" ? templatefile("./api/apiconfig_api/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  }) : format("https://%s/apiconfig/api/v1/v3/api-docs", module.api_config_app_service.default_site_hostname)

  xml_content = templatefile("./api/apiconfig_api/auth/v1/_base_policy.xml.tpl", {
    origin                 = "*"
    pagopa_tenant_id       = local.pagopa_tenant_id
    apiconfig_be_client_id = local.apiconfig_be_client_id
  })
}

##################################################################################
#                                   DEPRECATED                                   #
# API apim_api_config_checkout_product (which contains only a subset of actions) #
# will be removed in favor of API apim_api_config_auth_product which             #
# is the same of apim_api_config_product but requires authentication             #
##################################################################################


###########################
## Products for Checkout ##
###########################

module "apim_api_config_checkout_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-api-config-checkout"
  display_name = "ApiConfig for Checkout"
  description  = "Product for API Configuration of the Node for Checkout"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/apiconfig_api/_base_policy_checkout.xml")
}

########################
##  API for Checkout  ##
########################

resource "azurerm_api_management_api_version_set" "api_config_checkout_api" {

  name                = format("%s-api-config-checkout-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "ApiConfig for Checkout"
  versioning_scheme   = "Segment"
}

module "apim_api_config_checkout_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.0.12"

  name                = format("%s-api-config-checkout-api", var.env_short)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  product_ids         = [module.apim_api_config_checkout_product.product_id]

  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.api_config_checkout_api.id
  api_version    = "v1"

  description  = "Api configuration for Checkout"
  display_name = "ApiConfig for Checkout"
  path         = "apiconfig/checkout/api"
  protocols    = ["https"]

  service_url = format("https://%s/apiconfig/api/v1", module.api_config_app_service.default_site_hostname)

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig_api/checkout/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/apiconfig_api/checkout/v1/_base_policy.xml.tpl", {
    origin                 = "*"
    pagopa_tenant_id       = local.pagopa_tenant_id
    apiconfig_be_client_id = local.apiconfig_be_client_id
  })
}
