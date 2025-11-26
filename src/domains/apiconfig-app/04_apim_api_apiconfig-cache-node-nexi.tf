resource "azurerm_api_management_api_version_set" "api_apiconfig_cache_node_nexi_api" {
  count               = var.env_short != "p" ? 1 : 0
  name                = format("%s-apiconfig-cache-node-%s-api", var.env_short, "nexi")
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_cache_locals.display_name} - Node Nexi"
  versioning_scheme   = "Segment"
}

module "apim_api_apiconfig_cache_node_nexi_api_dev_v1" {
  count  = var.env_short == "d" ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-apiconfig-cache-node-%s-api", local.project, "nexi")
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_cache_product.product_id, local.apim_x_node_product_id]
  subscription_required = local.apiconfig_cache_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_cache_node_nexi_api[0].id
  api_version    = "v1"

  description  = local.apiconfig_cache_locals.description
  display_name = "${local.apiconfig_cache_locals.display_name} - Node Nexi"

  path        = "${local.apiconfig_cache_locals.path}/odev"
  protocols   = ["https"]
  service_url = local.apiconfig_cache_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-cache/node_fdr/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = "node-nexi"
  })

  xml_content = templatefile("./api/apiconfig-cache/node_fdr/_base_policy.xml", {
    hostname = local.apiconfig_cache_locals.hostname
    hostname = format("%s/%s", local.apiconfig_cache_locals.hostname, "${local.apiconfig_cache_locals.path}dev/o")
  })
}
