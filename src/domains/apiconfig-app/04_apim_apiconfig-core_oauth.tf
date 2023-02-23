resource "azurerm_api_management_api_version_set" "api_apiconfig_core_oauth_api" {
  for_each = toset(["p", "o"])

  name                = format("%s-apiconfig-core-oauth-%s-api", var.env_short, each.key)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_core_service_api.display_name} - Oauth ${each.key}"
  versioning_scheme   = "Segment"
}


module "apim_api_apiconfig_core_oauth_api_v1" {
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.17"
  for_each = toset(["p", "o"])

  name                  = format("%s-apiconfig-core-%s-oauth-api", local.project, each.key)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_core_oauth_product.product_id]
  subscription_required = local.apiconfig_core_service_api.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_core_oauth_api[each.key].id
  api_version    = "v1"

  description  = local.apiconfig_core_service_api.description
  display_name = "${local.apiconfig_core_service_api.display_name} - Oauth ${each.key}"

  path        = "${local.apiconfig_core_service_api.path}/oauth/${each.key}"
  protocols   = ["https"]
  service_url = local.apiconfig_core_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-core/oauth/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = "oauth-${each.key}"
  })

  xml_content = templatefile("./api/apiconfig-core/oauth/v1/_base_policy.xml.tpl", {
    hostname = local.apiconfig_core_service_api.hostname
    origin   = format("https://%s.%s.%s", var.cname_record_name, var.apim_dns_zone_prefix, var.external_domain)
    database = each.key

    pagopa_tenant_id       = local.apiconfig_core_service_api.pagopa_tenant_id
    apiconfig_be_client_id = local.apiconfig_core_service_api.apiconfig_be_client_id
    apiconfig_fe_client_id = local.apiconfig_core_service_api.apiconfig_fe_client_id
  })
}


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
