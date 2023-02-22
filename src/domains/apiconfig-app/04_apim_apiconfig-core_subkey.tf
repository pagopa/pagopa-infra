resource "azurerm_api_management_api_version_set" "api_apiconfig_core_api" {
  name                = format("%s-apiconfig-core-subkey-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apiconfig_core_service_api.display_name} - Subkey"
  versioning_scheme   = "Segment"
}


module "apim_api_apiconfig_core_subkey_api_v1" {
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.17"
  for_each = toset(["p", "o"])

  name                  = format("%s-apiconfig-core-%s-subkey-api", local.project, each.key)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_core_product.product_id]
  subscription_required = local.apiconfig_core_service_api.subscription_required

  version_set_id = azurerm_api_management_api_version_set.api_apiconfig_core_api.id
  api_version    = "v1"

  description  = local.apiconfig_core_service_api.description
  display_name = "${local.apiconfig_core_service_api.display_name} - ${each.key}"

  path        = "${local.apiconfig_core_service_api.path}/subkey/${each.key}"
  protocols   = ["https"]
  service_url = local.apiconfig_core_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-core/subkey/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/apiconfig-core/subkey/v1/_base_policy.xml.tpl", {
    hostname = local.apiconfig_core_service_api.hostname
    origin   = "*"
    database = each.key
  })
}
