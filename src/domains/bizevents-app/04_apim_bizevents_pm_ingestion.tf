module "apim_pm_ingestion_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.4.1"

  product_id   = "bizevent-pm-ingestion"
  display_name = "PM Ingestion"
  description  = "PM Ingestion for Biz Events"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/transaction-service/_base_policy.xml")
}
