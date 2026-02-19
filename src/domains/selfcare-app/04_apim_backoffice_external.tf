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
  apim_selfcare_backoffice_institution_services_api = {
    display_name = "Selfcare Backoffice Helpdesk Product pagoPA"
    description  = "API for Backoffice Helpdesk"
  }
}


module "apim_selfcare_backoffice_external_psp_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

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
  source = "./.terraform/modules/__v3__/api_management_product"

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
  source = "./.terraform/modules/__v3__/api_management_product"

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

# SubKey 4 https://uptime.betterstack.com/team/263223/monitors recover maintenance
# Status Page Improvement https://pagopa.atlassian.net/wiki/x/AoBBSQ

data "azurerm_api_management_api" "apim_backoffice-helpdesk_v1" { # <env>-backoffice-helpdesk-api-v1
  name                = "${var.env_short}-backoffice-helpdesk-api-v1"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  revision            = "1"
}

resource "azurerm_api_management_subscription" "status_page_improvement_api_key_subkey" {
  count = var.env_short == "p" ? 1 : 0

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  # product_id    = module.apim_selfcare_backoffice_helpdesk_product.id
  api_id        = replace(data.azurerm_api_management_api.apim_backoffice-helpdesk_v1.id, ";rev=1", "")
  display_name  = "Status Page Improvement API Key for Backoffice Helpdesk"
  allow_tracing = false
  state         = "active"
}

#Backoffice institutions service product
module "apim_selfcare_backoffice_institution_services_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "selfcare-bo-institution-services"
  display_name = local.apim_selfcare_backoffice_institution_services_api.display_name
  description  = local.apim_selfcare_backoffice_institution_services_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 10000

  policy_xml = file("./api_product/_base_policy.xml")
}
