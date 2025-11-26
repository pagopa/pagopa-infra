####################
## Local variables #
####################

locals {
  apim_fdr_2_event_hub_api = {
    subscription_required = true
  }
}

##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_fdr_2_event_hub_api" {

  name                = "${var.env_short}-fdr-2-event-hub"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "FDR to FDR QI EVH"
  versioning_scheme   = "Segment"
}


module "apim_api_fdr_2_event_hub_api" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-fdr-2-event-hub-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_fdr_product_internal.product_id]
  subscription_required = local.apim_fdr_2_event_hub_api.subscription_required
  api_version           = "v1"
  version_set_id        = azurerm_api_management_api_version_set.api_fdr_2_event_hub_api.id
  service_url           = null # see base policy

  description  = "FDR to FDR QI EVH"
  display_name = "FDR to FDR QI EVH"
  path         = "fdr-2-event-hub/api"
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/fdr-2-event-hub/v1/openapi_helpdesk.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/fdr-2-event-hub/v1/_base_policy.xml.tpl", {
    hostname = local.fdr_2_eventhub-recovery
  })
}
