resource "azurerm_api_management_api_version_set" "mocker_core_api" {
  count               = var.env_short != "p" ? 1 : 0
  name                = format("%s-mocker-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.mocker_core_api_locals.display_name
  versioning_scheme   = "Segment"
}

module "apim_mocker_core_api_v1" {
  count  = var.env_short != "p" ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-mocker-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mocker_core_product[0].product_id]
  subscription_required = local.mocker_core_api_locals.subscription_required

  version_set_id = azurerm_api_management_api_version_set.mocker_core_api[0].id
  api_version    = "v1"

  description  = local.mocker_core_api_locals.description
  display_name = local.mocker_core_api_locals.display_name
  path         = local.mocker_core_api_locals.path
  protocols    = ["https"]

  service_url = local.mocker_core_api_locals.service_url

  content_format = "openapi"
  content_value = templatefile("./api/mocker-core/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = "SelfCare integration"
  })

  xml_content = templatefile("./api/mocker-core/v1/_base_policy.xml", {
    hostname = local.mock_hostname
  })
}

resource "azurerm_api_management_group" "api_mocker_group" {
  count               = var.env_short != "p" ? 1 : 0
  name                = local.mocker_core_api_locals.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.mocker_core_api_locals.display_name
  description         = local.mocker_core_api_locals.description
}
