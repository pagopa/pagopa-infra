module "apim_apiconfig_core_oauth_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.4.1"

  product_id   = "${local.apiconfig_core_locals.product_id}-oauth"
  display_name = "${local.apiconfig_core_locals.display_name} - Oauth"
  description  = local.apiconfig_core_locals.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = local.apiconfig_core_locals.subscription_required
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}
