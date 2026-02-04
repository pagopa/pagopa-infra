##############
## Products ##
##############

module "apim_receipts_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "receipts"
  display_name = "Receipts Service PDF"
  description  = "Servizio per gestire recupero ricevute"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

module "apim_receipts_internal_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "receipts-internal"
  display_name = "Receipts Service PDF Internal"
  description  = "Servizio per gestire recupero ricevute, chiamato dai servizi interni"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

########################
##    API Biz Events  ##
########################
locals {
  apim_receipts_helpdesk_api = {
    display_name          = "Receipts Helpdesk PDF"
    description           = "API to handle receipts helpdesk"
    path                  = "receipts/helpdesk"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_receipts_helpdesk_api" {

  name                = format("%s-receipts-helpdesk-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_receipts_helpdesk_api.display_name
  versioning_scheme   = "Segment"
}

/*
 @Deprecated
 */
module "apim_api_receipts_helpdesk_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-receipts-helpdesk-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = ["technical_support_api"]
  subscription_required = local.apim_receipts_helpdesk_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_receipts_helpdesk_api.id
  api_version           = "v1"

  description  = local.apim_receipts_helpdesk_api.description
  display_name = local.apim_receipts_helpdesk_api.display_name
  path         = local.apim_receipts_helpdesk_api.path
  protocols    = ["https"]
  service_url  = local.apim_receipts_helpdesk_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/receipt-helpdesk/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/receipt-helpdesk/v1/_base_policy.xml", {
    hostname = "https://${local.receipts_hostname}"
  })
}
