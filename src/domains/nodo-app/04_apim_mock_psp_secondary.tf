##############
## Products ##
##############

module "apim_mock_psp_secondary_product" {
  source = "./.terraform/modules/__v3__/api_management_product"
  count  = var.env_short == "d" ? 1 : 0

  product_id   = "mock_psp_secondary"
  display_name = "Mock PSP (Secondary) for NDP"
  description  = "Mock PSP (Secondary) for NDP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 0

  policy_xml = file("./api_product/mock-psp-secondary-service/_base_policy.xml")
}

########################
##    Mock PSP NDP    ##
########################
locals {
  apim_mock_psp_secondary_service_api = {
    display_name          = "Mock PSP (Secondary) for NDP"
    description           = "API Mock PSP (Secondary) for NDP"
    path                  = "mock-psp-secondary-ndp/service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_mock_psp_secondary_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-mock-psp-secondary-service-ndp-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_mock_psp_secondary_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_mock_psp_secondary_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"
  count  = var.env_short == "d" ? 1 : 0

  name                  = format("%s-mock-psp-secondary-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mock_psp_secondary_product[0].product_id, module.apim_apim_for_node_product.product_id]
  subscription_required = local.apim_mock_psp_secondary_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_mock_psp_secondary_api[0].id
  api_version           = "v1"

  description  = local.apim_mock_psp_secondary_service_api.description
  display_name = local.apim_mock_psp_secondary_service_api.display_name
  path         = local.apim_mock_psp_secondary_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_mock_psp_secondary_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/mock-psp-secondary-service/v1/_mock-psp-secondary.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/mock-psp-secondary-service/v1/_base_policy.xml", {
    hostname = local.nodo_hostname
  })
}
