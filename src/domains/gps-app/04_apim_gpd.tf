########################################################
# Aggregated product for APIs of the following microservice
# - GPD-core: module.apim_api_debt_positions_api_v1
# - GPD-core: module.apim_api_debt_positions_api_v3
# - GPD-Payments: module.apim_api_gpd_payments_rest_external_api_v1
# - GPD-Reporting-Analysis: module.apim_api_gpd_reporting_analysis_api
# - GPD-Upload: module.apim_gpd_upload_api_v1
########################################################

module "apim_gpd_integration_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "debt-positions-integration"
  display_name = "GPD Debt Positions integration for organizations"
  description  = "GPD Debt Positions for organizations aggregated product"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/gpd/debt-position-services/_base_policy.xml")
}
