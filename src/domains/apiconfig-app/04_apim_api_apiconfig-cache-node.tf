resource "azurerm_api_management_api_version_set" "api_apiconfig_cache_node_api" {
  for_each = toset(["p", "o"])

  name                = format("%s-apiconfig-cache-node-%s-api", var.env_short, each.key)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_cache_locals.display_name} - Node ${each.key}"
  versioning_scheme   = "Segment"
}


module "apim_api_apiconfig_cache_node_api_v1" {
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v5.1.0"
  for_each = toset(["p", "o"])

  name                  = format("%s-apiconfig-cache-node-%s-api", local.project, each.key)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_cache_product.product_id]
  subscription_required = local.apiconfig_cache_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_cache_node_api[each.key].id
  api_version    = "v1"

  description  = local.apiconfig_cache_locals.description
  display_name = "${local.apiconfig_cache_locals.display_name} - Node ${each.key}"

  path        = "${local.apiconfig_cache_locals.path}/${each.key}"
  protocols   = ["https"]
  service_url = local.apiconfig_cache_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-cache/node/_openapi_nodev1.json.tpl", {
    host    = local.apim_hostname
    service = "node-${each.key}"
  })

  xml_content = templatefile("./api/apiconfig-cache/node/_base_policy.xml", {
    hostname = local.apiconfig_cache_locals.hostname
    hostname = format("%s/%s", local.apiconfig_cache_locals.hostname, "${local.apiconfig_cache_locals.path}/${each.key}")
  })
}
