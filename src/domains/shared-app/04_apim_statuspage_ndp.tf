module "apim_statuspage_nodo_pagamenti" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "statuspage_nodo_pagamenti"
  display_name = "Status Page Nodo Pagamenti"
  description  = "Prodotto Status Page Nodo Pagamenti"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1
  policy_xml            = file("./api_product/_statuspage_nodopagamenti_policy.xml")
}

###########
##  API  ##
###########
locals {
  apim_statuspage_nodopagamenti_service_api = {
    display_name          = "Status Page - API Nodo Pagamenti"
    description           = "API to Status Page Nodo Pagamenti"
    path                  = "nodopagamenti/statuspage"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_statuspage_nodopagamenti_api" {

  name                = format("%s-statuspage-nodopagamenti-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_statuspage_nodopagamenti_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_statuspage_nodopagamenti_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-statuspage-nodopagamenti-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_statuspage_nodo_pagamenti.product_id, "pagoPAPlatformStatusPage"]
  subscription_required = local.apim_statuspage_nodopagamenti_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_statuspage_nodopagamenti_api.id
  api_version           = "v1"

  description  = local.apim_statuspage_nodopagamenti_service_api.description
  display_name = local.apim_statuspage_nodopagamenti_service_api.display_name
  path         = local.apim_statuspage_nodopagamenti_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_statuspage_nodopagamenti_service_api.service_url

  content_format = "openapi"

  content_value = templatefile("./api/statuspage_nodopagamenti/v1/_NodoDeiPagamentiInfo.openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = file("./api/statuspage_nodopagamenti/v1/_base_policy.xml")

}
