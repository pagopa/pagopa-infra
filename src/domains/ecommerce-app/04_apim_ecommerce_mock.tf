##############
## Products ##
##############

module "apim_ecommerce_mock_product" {
  count  = var.env_short == "u" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "ecommerce-mock"
  display_name = "ecommerce pagoPA mock for nodeForPsp API"
  description  = "Product for ecommerce mocks pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

##############################
## API transactions service ##
##############################
locals {
  apim_ecommerce_nodo_mock_api = {
    display_name          = "ecommerce pagoPA - nodo mock API"
    description           = "API to support integration testing"
    path                  = "ecommerce/mock/nodo"
    subscription_required = false
    service_url           = null
  }
}

# Transactions service APIs
resource "azurerm_api_management_api_version_set" "apim_ecommerce_nodo_mock_api" {
  name                = format("%s-apim_ecommerce_nodo_mock", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_nodo_mock_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_ecommerce_nodo_mock" {
  count = var.env_short == "u" ? 1 : 0

  name                  = format("%s-apim_ecommerce_nodo_mock", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_nodo_mock_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_nodo_mock_api.id
  version               = "v1"
  revision              = "1"

  description  = local.apim_ecommerce_nodo_mock_api.description
  display_name = local.apim_ecommerce_nodo_mock_api.display_name
  path         = local.apim_ecommerce_nodo_mock_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_nodo_mock_api.service_url

  import {
    content_format = "wsdl"
    content_value  = file("./api/ecommerce-mock/nodeForPsp/v1/nodeForPsp.wsdl")
    wsdl_selector {
      service_name  = "nodeForPsp_Service"
      endpoint_name = "nodeForPsp_Port"
    }
  }
}
