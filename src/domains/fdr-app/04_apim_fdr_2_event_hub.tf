####################
## Local variables #
####################

locals {
  apim_fdr_2_event_hub_api = {
    published             = true
    subscription_required = true
    approval_required     = false
    subscriptions_limit   = 100
  }
}

##############
## Products ##
##############

module "apim_fdr_2_event_hub_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "product-fdr-2-event-hub"
  display_name = "FDR to FDR QI pagoPA"
  description  = "Prodotto FDR to EVH"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = local.apim_fdr_2_event_hub_api.published
  subscription_required = local.apim_fdr_2_event_hub_api.subscription_required
  approval_required     = local.apim_fdr_2_event_hub_api.approval_required
  subscriptions_limit   = local.apim_fdr_2_event_hub_api.subscriptions_limit

  policy_xml = file("./api_product/fdr-service/psp/_base_policy.xml")

}

##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_fdr_2_event_hub_api" {

  name                = format("%s-api-fdr-2-event-hub", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "FDR to FDR QI EVH"
  versioning_scheme   = "Segment"
}


module "apim_api_fdr_2_event_hub_api" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-api-fdr-2-event-hub-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_fdr_2_event_hub_product.product_id]
  subscription_required = local.apim_fdr_2_event_hub_api.subscription_required
  api_version           = "v1"
  version_set_id        = azurerm_api_management_api_version_set.api_fdr_2_event_hub_api.id
  service_url           = null # see base policy

  description  = "Api FDR to FDR QI EVH"
  display_name = "FDR to FDR QI pagoPA"
  path         = "fdr-2-event-hub/api"
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/fdr-2-event-hub/v1/openapi_helpdesk.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/fdr-2-event-hub/v1/_base_policy.xml.tpl", {
    hostname = local.hostname
  })
}
