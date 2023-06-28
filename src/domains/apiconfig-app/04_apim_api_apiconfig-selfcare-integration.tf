resource "azurerm_api_management_api_version_set" "apiconfig_selfcare_integration_api" {

  name                = format("%s-apiconfig-selfcare-integration-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apiconfig_selfcare_integration_locals.display_name
  versioning_scheme   = "Segment"
}

module "apim_apiconfig_selfcare_integration_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.7.0"

  name                  = format("%s-apiconfig-selfcare-integration-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_apiconfig_selfcare_integration_product.product_id]
  subscription_required = local.apiconfig_selfcare_integration_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.apiconfig_selfcare_integration_api.id
  api_version    = "v1"

  description  = local.apiconfig_selfcare_integration_locals.description
  display_name = local.apiconfig_selfcare_integration_locals.display_name
  path         = local.apiconfig_selfcare_integration_locals.path
  protocols    = ["https"]

  service_url = local.apiconfig_selfcare_integration_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig-selfcare-integration/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = "SelfCare integration"
  })

  xml_content = templatefile("./api/apiconfig-selfcare-integration/v1/_base_policy.xml", {
    hostname = local.apiconfig_selfcare_integration_locals.hostname
  })
}

resource "azurerm_api_management_group" "api_apiconfig_selfcare_integration_group" {
  name                = local.apiconfig_selfcare_integration_locals.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apiconfig_selfcare_integration_locals.display_name
  description         = local.apiconfig_selfcare_integration_locals.description
}
