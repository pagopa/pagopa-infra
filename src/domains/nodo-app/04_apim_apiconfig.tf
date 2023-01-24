########################
##    CONFIGURATION   ##
########################

// TODO analyze
data "azuread_application" "apiconfig-fe-aks" {
  display_name = format("pagopa-%s-apiconfig-fe", var.env_short)
}
data "azuread_application" "apiconfig-be-aks" {
  display_name = format("pagopa-%s-apiconfig-be", var.env_short)
}

data "azurerm_key_vault" "nodo-kv" {
  name                = format("pagopa-%s-nodo-kv", var.env_short)
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

data "azurerm_key_vault_secret" "apiconfig-client-secret" {
  name         = "apiconfig-client-secret"
  key_vault_id = data.azurerm_key_vault.nodo-kv.id
}

resource "azurerm_api_management_authorization_server" "apiconfig-oauth2" {
  name                         = "apiconfig-oauth2"
  api_management_name          = local.pagopa_apim_name
  resource_group_name          = local.pagopa_apim_rg
  display_name                 = "apiconfig-oauth2"
  authorization_endpoint       = "https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize"
  client_id                    = data.azuread_application.apiconfig-fe-aks.application_id
  client_registration_endpoint = "http://localhost"

  grant_types           = ["authorizationCode"]
  authorization_methods = ["GET", "POST"]

  #tfsec:ignore:GEN003
  token_endpoint = "https://login.microsoftonline.com/organizations/oauth2/v2.0/token"
  default_scope = format("%s/%s",
    data.azuread_application.apiconfig-be-aks.identifier_uris[0],
    "access-apiconfig-be")
  client_secret = data.azurerm_key_vault_secret.apiconfig-client-secret.value

  bearer_token_sending_methods = ["authorizationHeader"]
  client_authentication_method = ["Body"]

}

locals {
  apim_api_config_service_api = {
    name                   = "apiconfig-service-%s-api"
    path                   = "apiconfig-%s/service"
    product_id             = "api-config-%s-aks"
    display_name           = "API Config %s - AKS"
    description            = "Management APIs to configure pagoPA - %s"
    service_url            = null
    pagopa_tenant_id       = data.azurerm_client_config.current.tenant_id
    apiconfig_be_client_id = data.azuread_application.apiconfig-be-aks.application_id
    apiconfig_fe_client_id = data.azuread_application.apiconfig-fe-aks.application_id
  }
}

# ------------------------------------------------------------------------------

##################
##   PRODUCTS  ###
##################

##################
##     OAuth    ##
##################

module "apim_api_config_oauth_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = format(local.apim_api_config_service_api.product_id, "oauth")
  display_name = format(local.apim_api_config_service_api.display_name, "OAuth")
  description  = format(local.apim_api_config_service_api.description, "OAuth")

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/apiconfig-service/_base_policy_oauth.xml")
}

##################
##    SubKey    ##
##################

module "apim_api_config_subkey_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = format(local.apim_api_config_service_api.product_id, "subkey")
  display_name = format(local.apim_api_config_service_api.display_name, "SubKey")
  description  = format(local.apim_api_config_service_api.description, "SubKey")

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/apiconfig-service/_base_policy_subkey.xml")
}

# ------------------------------------------------------------------------------

##################
##      API     ##
##################

##################
##     OAuth    ##
##################
resource "azurerm_api_management_api_version_set" "api_config_oauth_api" {
  name                = format("%s-%s", var.env_short, format(local.apim_api_config_service_api.name, "oauth"))
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = format(local.apim_api_config_service_api.display_name, "OAuth")
  versioning_scheme   = "Segment"
}

module "apim_api_config_oauth_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-%s", var.env_short, format(local.apim_api_config_service_api.name, "oauth"))
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_api_config_oauth_product.product_id]
  subscription_required = false
  oauth2_authorization = {
    authorization_server_name = "apiconfig-oauth2"
  }

  version_set_id = azurerm_api_management_api_version_set.api_config_oauth_api.id
  api_version    = "v1"

  display_name = format(local.apim_api_config_service_api.display_name, "OAuth")
  description  = format(local.apim_api_config_service_api.description, "OAuth")
  path         = format(local.apim_api_config_service_api.path, "oauth")
  protocols    = ["https"]
  service_url  = local.apim_api_config_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-service/oauth/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/apiconfig-service/oauth/v1/_base_policy.xml.tpl", {
    hostname               = local.nodo_hostname
    origin                 = format("https://%s.%s.%s", var.cname_record_name, var.apim_dns_zone_prefix, var.external_domain)
    pagopa_tenant_id       = local.apim_api_config_service_api.pagopa_tenant_id
    apiconfig_be_client_id = local.apim_api_config_service_api.apiconfig_be_client_id
    apiconfig_fe_client_id = local.apim_api_config_service_api.apiconfig_fe_client_id
  })
}

##################
##    SubKey    ##
##################

resource "azurerm_api_management_api_version_set" "api_config_subkey_api" {
  name                = format("%s-%s", var.env_short, format(local.apim_api_config_service_api.name, "subkey"))
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = format(local.apim_api_config_service_api.display_name, "SubKey")
  versioning_scheme   = "Segment"
}

module "apim_api_config_subkey_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                = format("%s-%s", var.env_short, format(local.apim_api_config_service_api.name, "subkey"))
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  product_ids         = [module.apim_api_config_subkey_product.product_id]

  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.api_config_subkey_api.id
  api_version    = "v1"

  display_name = format(local.apim_api_config_service_api.display_name, "SubKey")
  description  = format(local.apim_api_config_service_api.description, "SubKey")
  path         = format(local.apim_api_config_service_api.path, "subkey")
  protocols    = ["https"]

  service_url = local.apim_api_config_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-service/subkey/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/apiconfig-service/subkey/v1/_base_policy.xml.tpl", {
    hostname               = local.nodo_hostname
    origin                 = "*"
    pagopa_tenant_id       = local.apim_api_config_service_api.pagopa_tenant_id
    apiconfig_be_client_id = local.apim_api_config_service_api.apiconfig_be_client_id
  })
}
