
# Postgres

resource "azurerm_api_management_api_version_set" "api_apiconfig_cache_node_api_p" {
  name                = format("%s-apiconfig-cache-node-%s-api", var.env_short, local.postgres)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_cache_locals.display_name} - Node ${local.postgres}"
  versioning_scheme   = "Segment"
}

module "apim_api_apiconfig_cache_node_api_v1_p" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-apiconfig-cache-node-%s-api", local.project, local.postgres)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_cache_product.product_id, local.apim_x_node_product_id, local.cfg_x_node_product_id]
  subscription_required = local.apiconfig_cache_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_cache_node_api_p.id
  api_version    = "v1"

  description  = local.apiconfig_cache_locals.description
  display_name = "${local.apiconfig_cache_locals.display_name} - Node ${local.postgres}"

  path        = "${local.apiconfig_cache_locals.path}/${local.postgres}"
  protocols   = ["https"]
  service_url = local.apiconfig_cache_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-cache/node_fdr/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = "node-${local.postgres}"
  })

  xml_content = templatefile("./api/apiconfig-cache/node_fdr/_base_policy.xml", {
    hostname = local.apiconfig_cache_locals.hostname
    hostname = format("%s/%s", local.apiconfig_cache_locals.hostname, "${local.apiconfig_cache_locals.path}/${local.postgres}")
  })
}


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

# Oracle

resource "azurerm_api_management_api_version_set" "api_apiconfig_cache_node_api_o" {
  name                = format("%s-apiconfig-cache-node-%s-api", var.env_short, local.oracle)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_cache_locals.display_name} - Node ${local.oracle}"
  versioning_scheme   = "Segment"
}


module "apim_api_apiconfig_cache_node_api_v1_o" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-apiconfig-cache-node-%s-api", local.project, local.oracle)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_cache_product.product_id, local.apim_x_node_product_id, local.cfg_x_node_product_id]
  subscription_required = local.apiconfig_cache_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_cache_node_api_o.id
  api_version    = "v1"

  description  = local.apiconfig_cache_locals.description
  display_name = "${local.apiconfig_cache_locals.display_name} - Node ${local.oracle}"

  path        = "${local.apiconfig_cache_locals.path}/${local.oracle}"
  protocols   = ["https"]
  service_url = local.apiconfig_cache_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-cache/node_fdr/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = "node-${local.oracle}"
  })

  xml_content = templatefile("./api/apiconfig-cache/node_fdr/_base_policy.xml", {
    hostname = local.apiconfig_cache_locals.hostname
    hostname = format("%s/%s", local.apiconfig_cache_locals.hostname, "${local.apiconfig_cache_locals.path}/${local.oracle}")
  })
}
