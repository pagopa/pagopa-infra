##############
## Products ##
##############

module "apim_mock_payment_gateway_product" {
  count  = var.mock_payment_gateway_enabled ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "product-mock-payment-gateway"
  display_name = "product-mock-payment-gateway"
  description  = "product-mock-payment-gateway"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/mock_payment_gateway_api/_base_policy.xml")
}

##############
##    API   ##
##############

module "apim_mock_payment_gateway_api" {
  count  = var.mock_payment_gateway_enabled ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-mock-payment-gateway-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mock_payment_gateway_product[0].product_id]
  subscription_required = false

  description  = "mock payment gateway api"
  display_name = "mock payment gateway api"
  path         = "mock-payment-gateway/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/mock_payment_gateway_api/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = file("./api/mock_payment_gateway_api/v1/_base_policy.xml")
}


##############
## MNG API ##
##############

locals {
  apim_mock_payment_gateway_mng_api_name = format("%s-mock-payment-gateway-mng-api", local.project)
}

module "apim_mock_payment_gateway_mng_api" {
  count  = var.mock_payment_gateway_enabled ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = local.apim_mock_payment_gateway_mng_api_name
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mock_payment_gateway_product[0].product_id]
  subscription_required = true

  description  = "mock payment gateway mng api"
  display_name = "mock payment gateway mng api"
  path         = "mock-payment-gateway/mng-api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/mock_payment_gateway_mng_api/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = file("./api/mock_payment_gateway_mng_api/v1/_base_policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "this" {
  count               = var.mock_payment_gateway_enabled ? 1 : 0
  api_name            = local.apim_mock_payment_gateway_mng_api_name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "getappinfo"

  xml_content = file("./api/mock_payment_gateway_mng_api/v1/_getappinfo_policy.xml")
}
