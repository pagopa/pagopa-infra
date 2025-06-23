
module "apim_gps_rtp_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "gpsrtp"
  display_name = "GPD x RTP - Helpdesk"
  description  = "Servizio di Helpdesk per GPDxRTP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/gpd-rtp/_base_policy.xml")
}

