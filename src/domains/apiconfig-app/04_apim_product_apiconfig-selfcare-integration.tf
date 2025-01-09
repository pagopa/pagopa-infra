module "apim_apiconfig_selfcare_integration_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = local.apiconfig_selfcare_integration_locals.product_id
  display_name = local.apiconfig_selfcare_integration_locals.display_name
  description  = local.apiconfig_selfcare_integration_locals.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apiconfig_selfcare_integration_locals.subscription_required
  approval_required     = false
  subscriptions_limit   = local.apiconfig_selfcare_integration_locals.subscription_limit

  policy_xml = file("./api_product/apiconfig-selfcare-integration/_base_policy.xml")
}

resource "azurerm_api_management_product_group" "access_control_developers_for_selfcare_integration" {
  product_id          = module.apim_apiconfig_selfcare_integration_product.product_id
  group_name          = data.azurerm_api_management_group.group_developers.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

// API policy and endpoints are configured in the repository
