##############################
## API Payment Methods v1   ##
##############################
locals {
  apim_ecommerce_payment_methods_api_mock = {
    display_name          = "ecommerce pagoPA - Payment Methods API - Mock"
    description           = "API to support integration testing"
    path                  = "ecommerce/mock/payment-methods-service"
    subscription_required = true
    service_url           = null
    enabled               = var.env_short == "u" ? 1 : 0
  }
}

resource "azurerm_api_management_product" "apim_ecommerce_payment_methods_mock_product" {
  count        = var.env_short == "u" ? 1 : 0
  product_id   = "ecommerce-payment-methods-mock"
  display_name = "ecommerce pagoPA payment methods MOCK"
  description  = "API to support integration testing"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000
}

resource "azurerm_api_management_api_version_set" "apim_ecommerce_payment_methods_api_mock_v1" {
  count               = var.env_short == "u" ? 1 : 0
  name                = "${local.project}-ecommerce-payment-methods-mock"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_payment_methods_api_mock.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_ecommerce_payment_methods_mock_v1" {
  count = var.env_short == "u" ? 1 : 0

  name                  = "${local.project}-ecommerce-payment-methods-mock"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_payment_methods_api_mock.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_payment_methods_api_mock_v1[0].id
  version               = "v1"
  revision              = "1"

  description  = local.apim_ecommerce_payment_methods_api_mock.description
  display_name = local.apim_ecommerce_payment_methods_api_mock.display_name
  path         = local.apim_ecommerce_payment_methods_api_mock.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_payment_methods_api_mock.service_url

  import {
    content_format = "openapi"
    content_value  = file("./api/payment-wallet-mock/payment-methods/v1/_openapi.json.tpl")
  }
}

resource "azurerm_api_management_product_api" "apim_ecommerce_payment_methods_mock_product_api_v1" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_payment_methods_mock_v1[0].name
  product_id          = azurerm_api_management_product.apim_ecommerce_payment_methods_mock_product[0].product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}


resource "azurerm_api_management_api_policy" "apim_ecommerce_payment_methods_policy_v1" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_payment_methods_mock_v1[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/payment-wallet-mock/payment-methods/v1/_base_policy.xml.tpl")
}


resource "azurerm_api_management_api_operation_policy" "get_payment_methods_v1" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_payment_methods_mock_v1[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getPaymentMethod"

  xml_content = file("./api/payment-wallet-mock/payment-methods/v1/getPaymentMethod.xml.tpl")
}

##############################
## API Payment Methods v2   ##
##############################

resource "azurerm_api_management_api" "apim_ecommerce_payment_methods_mock_v2" {
  count = var.env_short == "u" ? 1 : 0

  name                  = "${local.project}-ecommerce-payment-methods-mock-v2"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_payment_methods_api_mock.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_payment_methods_api_mock_v1[0].id
  version               = "v2"
  revision              = "1"

  description  = local.apim_ecommerce_payment_methods_api_mock.description
  display_name = local.apim_ecommerce_payment_methods_api_mock.display_name
  path         = local.apim_ecommerce_payment_methods_api_mock.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_payment_methods_api_mock.service_url

  import {
    content_format = "openapi"
    content_value  = file("./api/payment-wallet-mock/payment-methods/v2/_openapi.json.tpl")
  }
}

resource "azurerm_api_management_product_api" "apim_ecommerce_payment_methods_mock_product_api_v2" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_payment_methods_mock_v2[0].name
  product_id          = azurerm_api_management_product.apim_ecommerce_payment_methods_mock_product[0].product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_ecommerce_payment_methods_policy_v2" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_payment_methods_mock_v2[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/payment-wallet-mock/payment-methods/v2/_base_policy.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "calculate_fees_v2" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_payment_methods_mock_v2[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "calculateFees"

  xml_content = file("./api/payment-wallet-mock/payment-methods/v2/calculateFees.xml.tpl")
}
