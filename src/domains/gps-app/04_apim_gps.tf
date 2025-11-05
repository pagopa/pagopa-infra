##############
## Products ##
##############

module "apim_gps_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "spontaneouspayments"
  display_name = "GPS pagoPA"
  description  = "Prodotto Gestione Posizione Spontanee"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy_no_forbid.xml")
}
