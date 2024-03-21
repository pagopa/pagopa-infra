########################################################
# Aggregated product for APIs of the following microservice
# - GPD-core: module.apim_api_debt_positions_api_v1
# - GPD-Payments: module.apim_api_gpd_payments_rest_external_api_v1
# - GPD-Reporting-Analysis: module.apim_api_gpd_reporting_analysis_api
# - GPD-Upload: module.apim_gpd_upload_api_v1
########################################################

module "apim_gpd_payments_pull_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v6.11.2"

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
