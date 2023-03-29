resource "azurerm_api_management_api_version_set" "api_apiconfig_cache_replica_node_api_p" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-apiconfig-cache-replica-node-%s-api", var.env_short, "p")
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_cache_replica_locals.display_name} - Node p"
  versioning_scheme   = "Segment"
}
resource "azurerm_api_management_api_version_set" "api_apiconfig_cache_replica_node_api_o" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-apiconfig-cache-replica-node-%s-api", var.env_short, "o")
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_cache_replica_locals.display_name} - Node o"
  versioning_scheme   = "Segment"
}


module "apim_api_apiconfig_cache_replica_node_api_v1_p" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v5.1.0"
  count  = var.env_short == "p" ? 0 : 1

  name                  = format("%s-apiconfig-cache-node-%s-api", local.project, "p")
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_cache_replica_product.product_id]
  subscription_required = local.apiconfig_cache_replica_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_cache_replica_node_api_p[0].id
  api_version    = "v1"

  description  = local.apiconfig_cache_replica_locals.description
  display_name = "${local.apiconfig_cache_replica_locals.display_name} - Node p"

  path        = "${local.apiconfig_cache_replica_locals.path}/p"
  protocols   = ["https"]
  service_url = local.apiconfig_cache_replica_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-cache-replica/node/_openapi_nodev1.json.tpl", {
    host    = local.apim_hostname
    service = "node-p"
  })

  xml_content = templatefile("./api/apiconfig-cache-replica/node/_base_policy.xml", {
    hostname = local.apiconfig_cache_replica_locals.hostname
    hostname = format("%s/%s", local.apiconfig_cache_replica_locals.hostname, "${local.apiconfig_cache_replica_locals.path}/p")
  })
}

module "apim_api_apiconfig_cache_replica_node_api_v1_o" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v5.1.0"
  count  = var.env_short == "p" ? 0 : 1

  name                  = format("%s-apiconfig-cache-node-%s-api", local.project, "o")
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_cache_replica_product.product_id]
  subscription_required = local.apiconfig_cache_replica_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_cache_replica_node_api_o[0].id
  api_version    = "v1"

  description  = local.apiconfig_cache_replica_locals.description
  display_name = "${local.apiconfig_cache_replica_locals.display_name} - Node o"

  path        = "${local.apiconfig_cache_replica_locals.path}/o"
  protocols   = ["https"]
  service_url = local.apiconfig_cache_replica_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-cache-replica/node/_openapi_nodev1.json.tpl", {
    host    = local.apim_hostname
    service = "node-o"
  })

  xml_content = templatefile("./api/apiconfig-cache-replica/node/_base_policy.xml", {
    hostname = local.apiconfig_cache_replica_locals.hostname
    hostname = format("%s/%s", local.apiconfig_cache_replica_locals.hostname, "${local.apiconfig_cache_replica_locals.path}/o")
  })
}
