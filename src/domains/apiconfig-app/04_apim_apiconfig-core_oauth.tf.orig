
# Postgres

resource "azurerm_api_management_api_version_set" "api_apiconfig_core_oauth_api_p" {
  name                = format("%s-apiconfig-core-oauth-%s-api", var.env_short, local.postgres)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_core_locals.display_name} - Oauth ${local.postgres}"
  versioning_scheme   = "Segment"
}


module "apim_api_apiconfig_core_oauth_api_v1_p" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v5.1.0"

  name                  = format("%s-apiconfig-core-%s-oauth-api", local.project, local.postgres)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_core_oauth_product.product_id]
  subscription_required = local.apiconfig_core_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_core_oauth_api_o.id
  api_version    = "v1"

  description  = local.apiconfig_core_locals.description
  display_name = "${local.apiconfig_core_locals.display_name} - Oauth ${local.postgres}"

  path        = "${local.apiconfig_core_locals.path}/oauth/${local.postgres}"
  protocols   = ["https"]
  service_url = local.apiconfig_core_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-core/oauth/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = "oauth-${local.oracle}"
  })

  xml_content = templatefile("./api/apiconfig-core/oauth/v1/_base_policy.xml.tpl", {
    hostname = local.apiconfig_core_locals.hostname
    origin   = format("https://%s.%s.%s", var.cname_record_name, var.apim_dns_zone_prefix, var.external_domain)
    database = local.oracle

    pagopa_tenant_id       = local.apiconfig_core_locals.pagopa_tenant_id
    apiconfig_be_client_id = local.apiconfig_core_locals.apiconfig_be_client_id
    apiconfig_fe_client_id = local.apiconfig_core_locals.apiconfig_fe_client_id
  })
}

# Oracle

resource "azurerm_api_management_api_version_set" "api_apiconfig_core_oauth_api_o" {
  name                = format("%s-apiconfig-core-oauth-%s-api", var.env_short, local.oracle)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_core_locals.display_name} - Oauth ${local.oracle}"
  versioning_scheme   = "Segment"
}


module "apim_api_apiconfig_core_oauth_api_v1_o" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v5.1.0"

  name                  = format("%s-apiconfig-core-%s-oauth-api", local.project, local.oracle)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_core_oauth_product.product_id]
  subscription_required = local.apiconfig_core_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_core_oauth_api_p.id
  api_version    = "v1"

  description  = local.apiconfig_core_locals.description
  display_name = "${local.apiconfig_core_locals.display_name} - Oauth ${local.oracle}"

  path        = "${local.apiconfig_core_locals.path}/oauth/${local.oracle}"
  protocols   = ["https"]
  service_url = local.apiconfig_core_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-core/oauth/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = "oauth-${local.oracle}"
  })

  xml_content = templatefile("./api/apiconfig-core/oauth/v1/_base_policy.xml.tpl", {
    hostname = local.apiconfig_core_locals.hostname
    origin   = format("https://%s.%s.%s", var.cname_record_name, var.apim_dns_zone_prefix, var.external_domain)
    database = local.oracle

    pagopa_tenant_id       = local.apiconfig_core_locals.pagopa_tenant_id
    apiconfig_be_client_id = local.apiconfig_core_locals.apiconfig_be_client_id
    apiconfig_fe_client_id = local.apiconfig_core_locals.apiconfig_fe_client_id
  })
}

# OAuth2 configuration

resource "azurerm_api_management_authorization_server" "apiconfig-oauth2" {
  name                         = "apiconfig-core-oauth2"
  api_management_name          = local.pagopa_apim_name
  resource_group_name          = local.pagopa_apim_rg
  display_name                 = "apiconfig-core-oauth2"
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
  client_secret = azurerm_key_vault_secret.apiconfig_client_secret.value

  bearer_token_sending_methods = ["authorizationHeader"]
  client_authentication_method = ["Body"]

}
