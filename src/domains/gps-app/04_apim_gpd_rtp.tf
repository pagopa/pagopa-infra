
module "apim_gpd_rtp_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "gpdrtp"
  display_name = "GPD x RTP"
  description  = "Servizio per inviare i messaggi RTP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/gpd-rtp/_base_policy.xml")
}

