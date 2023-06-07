resource "azurerm_api_management_api_version_set" "api_apiconfig_core_subkey_api_p" {
  name                = format("%s-apiconfig-core-subkey-%s-api", var.env_short, local.postgres)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_core_locals.display_name} - Subkey ${local.postgres}"
  versioning_scheme   = "Segment"
}


module "apim_api_apiconfig_core_subkey_api_v1_p" {
  source                = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v5.1.0"
  name                  = format("%s-apiconfig-core-%s-subkey-api", local.project, local.postgres)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_core_subkey_product.product_id]
  subscription_required = local.apiconfig_core_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_core_subkey_api_p.id
  api_version    = "v1"

  description  = local.apiconfig_core_locals.description
  display_name = "${local.apiconfig_core_locals.display_name} - Subkey ${local.postgres}"

  path        = "${local.apiconfig_core_locals.path}/subkey/${local.postgres}"
  protocols   = ["https"]
  service_url = local.apiconfig_core_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-core/subkey/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = "subkey-${local.postgres}"
  })

  xml_content = templatefile("./api/apiconfig-core/subkey/v1/_base_policy.xml.tpl", {
    hostname = local.apiconfig_core_locals.hostname
    origin   = "*"
    database = local.postgres
  })
}

resource "azurerm_api_management_api_version_set" "api_apiconfig_core_subkey_api_o" {

  name                = format("%s-apiconfig-core-subkey-%s-api", var.env_short, local.oracle)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_core_locals.display_name} - Subkey ${local.oracle}"
  versioning_scheme   = "Segment"
}


module "apim_api_apiconfig_core_subkey_api_v1_o" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v5.1.0"

  name                  = format("%s-apiconfig-core-%s-subkey-api", local.project, local.oracle)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_core_subkey_product.product_id]
  subscription_required = local.apiconfig_core_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_core_subkey_api_p.id
  api_version    = "v1"

  description  = local.apiconfig_core_locals.description
  display_name = "${local.apiconfig_core_locals.display_name} - Subkey ${local.oracle}"

  path        = "${local.apiconfig_core_locals.path}/subkey/${local.oracle}"
  protocols   = ["https"]
  service_url = local.apiconfig_core_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-core/subkey/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = "subkey-${local.oracle}"
  })

  xml_content = templatefile("./api/apiconfig-core/subkey/v1/_base_policy.xml.tpl", {
    hostname = local.apiconfig_core_locals.hostname
    origin   = "*"
    database = local.oracle
  })
}
