#############################
## Product gpd-for-aca ##
#############################

module "apim_gpd_for_aca_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "gpd-for-aca"
  display_name = "GPD for ACA pagoPA"
  description  = "Product GPD for A.C.A. pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/gpd-for-aca/_base_policy.xml")
}
