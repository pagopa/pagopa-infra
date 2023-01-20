##############
## Products ##
##############

module "apim_mock_psp_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "mock_psp"
  display_name = "Mock PSP for NDP"
  description  = "Mock PSP for NDP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/mock-psp-service/_base_policy.xml")
}

########################
##    Mock PSP NDP    ##
########################
locals {
  apim_mock_psp_service_api = {
    display_name          = "Mock PSP for NDP"
    description           = "API Mock PSP for NDP"
    path                  = "mock_psp-ndp/service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_mock_psp_api" {

  name                = format("%s-mock-psp-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_mock_psp_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_mock_psp_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-mock-psp-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mock_psp_product.product_id]
  subscription_required = local.apim_mock_psp_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_mock_psp_api.id
  api_version           = "v1"

  description  = local.apim_mock_psp_service_api.description
  display_name = local.apim_mock_psp_service_api.display_name
  path         = local.apim_mock_psp_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_mock_psp_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/mock-psp-service/v1/_mock-psp.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/mock-psp-service/v1/_base_policy.xml", {
    hostname = local.nodo_hostname
  })
}
