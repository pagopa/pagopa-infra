
#resource "azurerm_api_management_api_version_set" "api_apiconfig_core_api" {
#  name                = format("%s-apiconfig-core-oauth-api", var.env_short)
#  resource_group_name = local.pagopa_apim_rg
#  api_management_name = local.pagopa_apim_name
#  display_name        = local.apiconfig_core_service_api.display_name
#  versioning_scheme   = "Segment"
#}
#
#
#module "apim_api_apiconfig_core_oauth_postgres_api_v1" {
#  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.17"
##
#  name                  = format("%s-apiconfig-core-oauth-p-api", local.project)
#  api_management_name   = local.pagopa_apim_name
#  resource_group_name   = local.pagopa_apim_rg
#  product_ids           = [module.apim_apiconfig_core_product.product_id]
#  subscription_required = local.apiconfig_core_service_api.subscription_required
#
#  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_core_api.id
#  api_version    = "v1"
#
#  description  = local.apiconfig_core_service_api.description
#  display_name = local.apiconfig_core_service_api.display_name
#  path         = "${local.apiconfig_core_service_api.path}/oauth/p"
#  protocols    = ["https"]
#  service_url  = local.apiconfig_core_service_api.service_url
#
#  content_format = "openapi"
#  content_value = templatefile("./api/apiconfig-core/postgres/v1/_openapi.json.tpl", {
#    host = local.apim_hostname
#  })
#
#  xml_content = templatefile("./api/apiconfig-core/postgres/v1/_base_policy.xml.tpl", {
#    hostname               = local.apiconfig_hostname
#    origin                 = format("https://%s.%s.%s", var.cname_record_name, var.apim_dns_zone_prefix, var.external_domain)
#    pagopa_tenant_id       = local.apim_apiconfig_core_service_api.pagopa_tenant_id
#    apiconfig_be_client_id = local.apim_apiconfig_core_service_api.apiconfig_be_client_id
#    apiconfig_fe_client_id = local.apim_apiconfig_core_service_api.apiconfig_fe_client_id
#  })
#}
#
#
#module "apim_api_apiconfig_core_oauth_oracle_api_v1" {
#  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.17"
#
#  name                  = format("%s-apiconfig-core-oauth-o-api", local.project)
#  api_management_name   = local.pagopa_apim_name
#  resource_group_name   = local.pagopa_apim_rg
#  product_ids           = [module.apim_apiconfig_core_product.product_id]
#  subscription_required = local.apim_apiconfig_core_service_api.subscription_required
#
#  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_core_api.id
#  api_version    = "v1"
#
#  description  = local.apim_apiconfig_core_service_api.description
#  display_name = local.apim_apiconfig_core_service_api.display_name
#  path         = "${local.apim_apiconfig_core_service_api.path}/oauth/o"
#  protocols    = ["https"]
#  service_url  = local.apim_apiconfig_core_service_api.service_url
#
#  content_format = "openapi"
#  content_value = templatefile("./api/apiconfig-core/oracle/v1/_openapi.json.tpl", {
#    host = local.apim_hostname
#  })
#
#  xml_content = templatefile("./api/apiconfig-core/postgres/v1/_base_policy.xml.tpl", {
#    hostname               = local.apiconfig_hostname
#    origin                 = format("https://%s.%s.%s", var.cname_record_name, var.apim_dns_zone_prefix, var.external_domain)
#    pagopa_tenant_id       = local.apim_apiconfig_core_service_api.pagopa_tenant_id
#    apiconfig_be_client_id = local.apim_apiconfig_core_service_api.apiconfig_be_client_id
#    apiconfig_fe_client_id = local.apim_apiconfig_core_service_api.apiconfig_fe_client_id
#  })
#}
