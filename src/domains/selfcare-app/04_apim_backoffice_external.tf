##############################
## API BackOffice with ApiKey ##
##############################
locals {
  apim_selfcare_backoffice_external_api_ec = {
    display_name = "Selfcare Backoffice External for EC Product pagoPA"
    description  = "API for Backoffice External for EC"
  }
  apim_selfcare_backoffice_external_api_psp = {
    display_name = "Selfcare Backoffice External for PSP Product pagoPA"
    description  = "API for Backoffice External for PSP"
  }
  apim_selfcare_backoffice_helpdesk_api = {
    display_name = "Selfcare Backoffice Helpdesk Product pagoPA"
    description  = "API for Backoffice Helpdesk"
  }
}


module "apim_selfcare_backoffice_external_psp_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v8.15.1"

  product_id   = "selfcare-bo-external-psp"
  display_name = local.apim_selfcare_backoffice_external_api_psp.display_name
  description  = local.apim_selfcare_backoffice_external_api_psp.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 10000

  policy_xml = file("./api_product/_base_policy.xml")
}

module "apim_selfcare_backoffice_external_ec_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v8.15.1"

  product_id   = "selfcare-bo-external-ec"
  display_name = local.apim_selfcare_backoffice_external_api_ec.display_name
  description  = local.apim_selfcare_backoffice_external_api_ec.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 10000

  policy_xml = file("./api_product/_base_policy.xml")
}

module "apim_selfcare_backoffice_helpdesk_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v8.15.1"

  product_id   = "selfcare-bo-helpdesk"
  display_name = local.apim_selfcare_backoffice_helpdesk_api.display_name
  description  = local.apim_selfcare_backoffice_helpdesk_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 10000

  policy_xml = file("./api_product/_base_policy.xml")
}
