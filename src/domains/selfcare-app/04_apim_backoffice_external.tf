##############################
## API BackOffice with ApiKey ##
##############################
locals {
  apim_selfcare_backoffice_external_api = {
    display_name = "Selfcare Backoffice External Product pagoPA"
    description  = "API for Backoffice External"
  }
}


module "apim_selfcare_backoffice_external_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.7.0"

  product_id   = "selfcare-bo-external"
  display_name = local.apim_selfcare_backoffice_external_api.display_name
  description  = local.apim_selfcare_backoffice_external_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 10000

  policy_xml = file("./api_product/_base_policy.xml")
}


