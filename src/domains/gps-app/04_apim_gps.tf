##############
## Products ##
##############

module "apim_gps_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "spontaneouspayments"
  display_name = "GPS pagoPA"
  description  = "Prodotto GPS (Servizi Verticali)"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/_base_policy_no_forbid.xml")
}
