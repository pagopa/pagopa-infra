######################
## Products PRF ##
######################

module "apim_mock_ec_product_prf" {
  source       = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"
  count        = var.env_short == "p" ? 0 : 1
  product_id   = "mock_ec_prf"
  display_name = "Mock EC for PRF NDP"
  description  = "Mock EC for PRF NDP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/mock-ec-service-prf/_base_policy.xml")
}

###############################
##    Mock EC  NDP  PRF  ##
###############################
locals {
  apim_mock_ec_service_api_prf = {
    display_name          = "Mock EC for PRF NDP"
    description           = "API Mock EC for PRF NDP"
    path                  = "mock-ec-prf-ndp/service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_mock_ec_api_prf" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-mock-ec-service-api-prf", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_mock_ec_service_api_prf.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_mock_ec_api_prf_v1" {
  source                = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"
  count                 = var.env_short == "p" ? 0 : 1
  name                  = format("%s-mock-ec-service-api-prf", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mock_ec_product_prf[0].product_id]
  subscription_required = local.apim_mock_ec_service_api_prf.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_mock_ec_api_prf[0].id
  api_version           = "v1"

  description  = local.apim_mock_ec_service_api_prf.description
  display_name = local.apim_mock_ec_service_api_prf.display_name
  path         = local.apim_mock_ec_service_api_prf.path
  protocols    = ["https"]
  service_url  = local.apim_mock_ec_service_api_prf.service_url

  content_format = "openapi"
  content_value = templatefile("./api/mock-ec-service-prf/v1/_mock-ec.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/mock-ec-service-prf/v1/_base_policy.xml", {
    hostname = local.nodo_hostname
  })
}
