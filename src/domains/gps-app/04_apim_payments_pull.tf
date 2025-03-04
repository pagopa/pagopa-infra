####################################
## GPD Payments Pull APIM Product ##
####################################

module "apim_gpd_payments_pull_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "gpd-payments-pull"
  display_name = "GPD Payments Pull"
  description  = "GPD Payments Pull API to recover payment notices data from ACA and GPD"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/payments-pull/_base_policy.xml")
}


######################################################
## GPD Payments Pull Test Products                  ##
## 1. product_id   = "gpd-payments-pull             ##
## 2. product_id   = "product-gpd"                  ##
######################################################


module "apim_gpd_payments_pull_product_and_debt_positions_product_test" {
  count  = 1 # var.env_short != "p" ? 1 : 0 # ppull-prod-test
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "test-gpd-payments-pull-and-debt-positions"
  display_name = "TEST GPD Payments Pull & GPD Debt Positions for organizations"
  description  = "TEST GPD Payments Pull & GPD Debt Positions for organizations"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 10 # only for test

  policy_xml = file("./api_product/payments-pull/_base_policy.xml")

}
