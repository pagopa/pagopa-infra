##############
## Products ##
##############

module "apim_mock_pm_product" {
  source = "./.terraform/modules/__v3__/api_management_product"
  count  = var.env_short == "p" ? 0 : 1

  product_id   = "mock_pm"
  display_name = "Mock PM for NDP"
  description  = "Mock PM for NDP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 0

  policy_xml = file("./api_product/mock-pm-service/_base_policy.xml")
}

########################
##    Mock EC  NDP    ##
########################
locals {
  apim_mock_pm_service_api = {
    display_name          = "Mock PM for NDP"
    description           = "API Mock PM for NDP"
    path                  = "mock-pm-ndp/service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_mock_pm_api" {
  count = var.env_short == "p" ? 0 : 1

  name                = format("%s-mock-pm-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_mock_pm_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_mock_pm_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"
  count  = var.env_short == "p" ? 0 : 1

  name                  = format("%s-mock-pm-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mock_pm_product[0].product_id, module.apim_apim_for_node_product.product_id]
  subscription_required = local.apim_mock_pm_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_mock_pm_api[0].id
  api_version           = "v1"

  description  = local.apim_mock_pm_service_api.description
  display_name = local.apim_mock_pm_service_api.display_name
  path         = local.apim_mock_pm_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_mock_pm_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/mock-pm-service/v1/_mock-pm.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/mock-pm-service/v1/_base_policy.xml", {
    hostname = local.nodo_hostname
  })
}
