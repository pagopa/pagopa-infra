###
### IT SHOULD BE DEPRECATED, PLEASE USE cfg-for-node PRODUCT
module "apim_apiconfig_cache_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = local.apiconfig_cache_locals.product_id
  display_name = local.apiconfig_cache_locals.display_name
  description  = local.apiconfig_cache_locals.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apiconfig_cache_locals.subscription_required
  approval_required     = true
  subscriptions_limit   = local.apiconfig_cache_locals.subscription_limit

  policy_xml = file("./api_product/apiconfig-cache/_base_policy.xml")
}


resource "azurerm_api_management_product_group" "access_control_developers_for_cache" {
  product_id          = module.apim_apiconfig_cache_product.product_id
  group_name          = data.azurerm_api_management_group.group_developers.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}


module "apim_apiconfig_cache_external_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "apiconfig-cache-external"
  display_name = "API Config Cache External"
  description  = local.apiconfig_cache_locals.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apiconfig_cache_locals.subscription_required
  approval_required     = true
  subscriptions_limit   = local.apiconfig_cache_locals.subscription_limit

  policy_xml = file("./api_product/apiconfig-cache/_base_policy.xml")
}
