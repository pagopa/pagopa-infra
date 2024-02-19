###
### IT SHOULD BE DEPRECATED, PLEASE USE cfg-for-node PRODUCT
module "apim_apiconfig_cache_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.4.1"

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
