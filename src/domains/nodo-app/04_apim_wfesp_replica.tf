######################
## Products REPLICA ##
######################

module "apim_wfesp_product_replica" {
  source       = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"
  count        = var.env_short == "p" ? 0 : 1
  product_id   = "wfesp-replica"
  display_name = "WFESP for REPLICA NDP"
  description  = "WFESP for REPLICA NDP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/wfesp-service-replica/_base_policy.xml")
}

#############################
##    WFESP  NDP  REPLICA  ##
#############################
locals {
  apim_wfesp_service_api_replica = {
    display_name          = "WFESP for REPLICA NDP"
    description           = "API WFESP for REPLICA NDP"
    path                  = "wfesp-replica-ndp/service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_wfesp_api_replica" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-wfesp-service-api-replica", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_wfesp_service_api_replica.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_wfesp_api_replica_v1" {
  source                = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"
  count                 = var.env_short == "p" ? 0 : 1
  name                  = format("%s-wfesp-service-api-replica", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_wfesp_product_replica[0].product_id]
  subscription_required = local.apim_wfesp_service_api_replica.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_wfesp_api_replica[0].id
  api_version           = "v1"

  description  = local.apim_wfesp_service_api_replica.description
  display_name = local.apim_wfesp_service_api_replica.display_name
  path         = local.apim_wfesp_service_api_replica.path
  protocols    = ["https"]
  service_url  = local.apim_wfesp_service_api_replica.service_url

  content_format = "openapi"
  content_value = templatefile("./api/wfesp-service-replica/v1/_WFESP.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/wfesp-service-replica/v1/_base_policy.xml", {
    hostname = local.nodo_hostname
  })
}
