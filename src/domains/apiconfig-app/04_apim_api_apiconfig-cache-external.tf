resource "azurerm_api_management_api_version_set" "apiconfig_cache_external_v1" {
  name                = format("%s-apiconfig-cache-external-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_cache_locals.display_name} - External"
  versioning_scheme   = "Segment"
}

module "apim_api_apiconfig_cache_external_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-apiconfig-cache-external-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_cache_external_product.product_id]
  subscription_required = local.apiconfig_cache_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.apiconfig_cache_external_v1.id
  api_version    = "v1"

  description  = local.apiconfig_cache_locals.description
  display_name = "${local.apiconfig_cache_locals.display_name} - External"

  path        = "${local.apiconfig_cache_locals.path}/external"
  protocols   = ["https"]
  service_url = local.apiconfig_cache_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-cache/node_fdr/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = "external"
  })

  xml_content = templatefile("./api/apiconfig-cache/external/_base_policy.xml", {
    hostname = format("%s/%s", local.apiconfig_cache_locals.hostname, "${local.apiconfig_cache_locals.path}/${local.postgres}")
  })
}
