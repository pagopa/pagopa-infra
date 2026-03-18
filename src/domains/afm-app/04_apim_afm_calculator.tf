# named-values

resource "azurerm_api_management_named_value" "afm_secondary_sub_key" {
  name                = "afm-secondary-sub-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "afm-secondary-sub-key"
  value               = "<TO_UPDATE_MANUALLY_BY_PORTAL>"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_api_management_named_value" "afm_ndp_test_sub_key" {
  name                = "afm-ndp-test-sub-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "afm-ndp-test-sub-key"
  value               = "<TO_UPDATE_MANUALLY_BY_PORTAL>"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#############################
## Product AFM Calculator ##
#############################

locals {
  apim_afm_calculator_service_api = {
    display_name          = "AFM Calculator pagoPA - calculator of advanced fees management service API"
    description           = "Calculator API to support advanced fees management service"
    path                  = "afm/calculator-service"
    subscription_required = true
    service_url           = null
  }

  apim_afm_calculator_service_node_api = {
    display_name          = "AFM Calculator pagoPA for Node - calculator of advanced fees management service API"
    description           = "Calculator API to support advanced fees management service"
    path                  = "afm/node/calculator-service"
    subscription_required = true
    service_url           = null
  }
}

module "apim_afm_calculator_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "afm-calculator"
  display_name = local.apim_afm_calculator_service_api.display_name
  description  = local.apim_afm_calculator_service_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = local.apim_afm_calculator_service_api.subscription_required
  approval_required     = false

  policy_xml = file("./api_product/calculator/_base_policy.xml")
}

module "apim_afm_calculator_node_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "afm-node-calculator"
  display_name = local.apim_afm_calculator_service_node_api.display_name
  description  = local.apim_afm_calculator_service_node_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apim_afm_calculator_service_node_api.subscription_required
  approval_required     = true
  subscriptions_limit   = 1

  policy_xml = file("./api_product/calculator/_base_policy.xml")
}

resource "azurerm_api_management_group" "api_afm_calculator_node_group" {
  name                = "afm-calculator"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "AFM Calculator for Node"
  description         = "API management group of AFM Calculator for Node"
}

data "azurerm_api_management_group" "api_afm_calculator_node_group" {
  name                = azurerm_api_management_group.api_afm_calculator_node_group.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  depends_on = [azurerm_api_management_group.api_afm_calculator_node_group]
}

resource "azurerm_api_management_product_group" "api_afm_calculator_node_product_group" {
  # for_each is avoided in order to not delete the relationship and re-create it

  product_id          = module.apim_afm_calculator_node_product.product_id
  api_management_name = local.pagopa_apim_name
  group_name          = data.azurerm_api_management_group.api_afm_calculator_node_group.name

  resource_group_name = local.pagopa_apim_rg
}