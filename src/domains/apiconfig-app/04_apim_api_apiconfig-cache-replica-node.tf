resource "azurerm_api_management_api_version_set" "api_apiconfig_cache_replica_node_api_p" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-apiconfig-cache-replica-node-%s-api", var.env_short, "p")
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_cache_replica_locals.display_name} - Node p"
  versioning_scheme   = "Segment"
}
# resource "azurerm_api_management_api_version_set" "api_apiconfig_cache_replica_node_api_o" {
#   count               = var.env_short == "p" ? 0 : 1
#   name                = format("%s-apiconfig-cache-replica-node-%s-api", var.env_short, "o")
#   resource_group_name = local.pagopa_apim_rg
#   api_management_name = local.pagopa_apim_name
#   display_name        = "${local.apiconfig_cache_replica_locals.display_name} - Node o"
#   versioning_scheme   = "Segment"
# }


module "apim_api_apiconfig_cache_replica_node_api_v1_p" {
  source = "./.terraform/modules/__v3__/api_management_api"

  count = var.env_short == "p" ? 0 : 1

  name                  = format("%s-apiconfig-cache-replica-node-%s-api", local.project, "p")
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [local.cfg_x_node_product_id]
  subscription_required = local.apiconfig_cache_replica_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_cache_replica_node_api_p[0].id
  api_version    = "v1"

  description  = local.apiconfig_cache_replica_locals.description
  display_name = "${local.apiconfig_cache_replica_locals.display_name} - Node p"

  path        = format("%s/%s", local.apiconfig_cache_replica_locals.path_apim, "pr")
  protocols   = ["https"]
  service_url = local.apiconfig_cache_replica_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-cache/node_fdr/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = "node-p-replica"
  })

  xml_content = templatefile("./api/apiconfig-cache/node_fdr/_base_policy.xml", {
    hostname = format("%s/%s/%s", local.apiconfig_cache_replica_locals.hostname, local.apiconfig_cache_replica_locals.path_apim, "pr")
  })
}

# module "apim_api_apiconfig_cache_replica_node_api_v1_o" {
#   source = "./.terraform/modules/__v3__/api_management_api"
#
#   count = var.env_short == "p" ? 0 : 1
#
#   name                  = format("%s-apiconfig-cache-replica-node-%s-api", local.project, "o")
#   api_management_name   = local.pagopa_apim_name
#   resource_group_name   = local.pagopa_apim_rg
#   product_ids           = [local.cfg_x_node_product_id]
#   subscription_required = local.apiconfig_cache_replica_locals.subscription_required
#
#   version_set_id = azurerm_api_management_api_version_set.api_apiconfig_cache_replica_node_api_o[0].id
#   api_version    = "v1"
#
#   description  = local.apiconfig_cache_replica_locals.description
#   display_name = "${local.apiconfig_cache_replica_locals.display_name} - Node o"
#
#   path        = format("%s/%s", local.apiconfig_cache_replica_locals.path_apim, "or")
#   protocols   = ["https"]
#   service_url = local.apiconfig_cache_replica_locals.service_url
#
#   content_format = "openapi"
#   content_value = templatefile("./api/apiconfig-cache/node_fdr/_openapi.json.tpl", {
#     host    = local.apim_hostname
#     service = "node-o-replica"
#   })
#
#   xml_content = templatefile("./api/apiconfig-cache/node_fdr/_base_policy.xml", {
#     hostname = format("%s/%s/%s", local.apiconfig_cache_replica_locals.hostname, local.apiconfig_cache_replica_locals.path_apim, "or")
#   })
# }
