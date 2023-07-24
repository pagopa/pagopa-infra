##########################################
## API Mock GPD create flow             ##
##########################################
locals {
  apim_gpd_create_flow_mock_api = {
    display_name          = "GPD for ACA pagoPA - GPD mock create flow"
    description           = "API to support integration testing"
    path                  = "aca/create/mock/gpd"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_gpd_create_mock_api" {
  name                = "${local.project}-gpd-create-mock"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_gpd_create_flow_mock_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_gpd_create_mock" {
  count = var.env_short == "u" ? 1 : 0

  name                  = "${local.project}-gpd-create-mock"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_gpd_create_flow_mock_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_gpd_create_mock_api[0].id
  version               = "v1"
  revision              = "1"

  description  = local.apim_gpd_create_flow_mock_api.description
  display_name = local.apim_gpd_create_flow_mock_api.display_name
  path         = local.apim_gpd_create_flow_mock_api.path
  protocols    = ["https"]
  service_url  = local.apim_gpd_create_flow_mock_api.service_url

  import {
    content_format = "openapi"
    content_value = templatefile("./api/aca-mock/gpd/createFlow/v1/_openapi.json.tpl", {
      host = local.apim_hostname
    })
  }
}

resource "azurerm_api_management_product_api" "apim_gpd_mock_create_product_api" {
  api_name            = azurerm_api_management_api.apim_gpd_create_mock[0].name
  product_id          = module.apim_aca_product.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_gpd_create_mock_policy" {
  api_name            = azurerm_api_management_api.apim_gpd_create_mock[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/aca-mock/gpd/createFlow/v1/_base_policy.xml.tpl")
}
