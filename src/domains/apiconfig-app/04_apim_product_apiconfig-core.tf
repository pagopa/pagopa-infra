module "apim_apiconfig_core_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.17"

  product_id   = format(local.apiconfig_core_service_api.product_id)
  display_name = format(local.apiconfig_core_service_api.display_name)
  description  = format(local.apiconfig_core_service_api.description)

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = local.apiconfig_core_service_api.subscription_required
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}
