##############
## Products ##
##############

module "apim_grafana_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "grafana"
  display_name = "Grafana for NDP"
  description  = "Grafana for NDP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/grafana-service/_base_policy.xml")
}

######################
##    Grafana    ##
######################
locals {
  apim_grafana_service_api = {
    display_name          = "Grafana for NDP"
    description           = "API Grafana for NDP"
    path                  = "grafana"
    subscription_required = false
    service_url           = null
  }
}

/*
resource "azurerm_api_management_api_version_set" "api_grafana_api" {
  name                = format("%s-grafana-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_grafana_service_api.display_name
  versioning_scheme   = "Segment"
}
*/

module "apim_api_grafana_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-grafana-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_grafana_product.product_id]
  subscription_required = local.apim_grafana_service_api.subscription_required
  #version_set_id        = azurerm_api_management_api_version_set.api_grafana_api.id
  #api_version           = "v1"

  description  = local.apim_grafana_service_api.description
  display_name = local.apim_grafana_service_api.display_name
  path         = local.apim_grafana_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_grafana_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/grafana-service/v1/_grafana.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/grafana-service/v1/_base_policy.xml", {
    hostname = "${var.location_short}${var.env}.kibana.internal.${var.env}.platform.pagopa.it"
    dns_pagopa_platform = format("api.%s.%s", var.apim_dns_zone_prefix, var.external_domain)
    apim_base_path      = "/grafana"
  })
  
}
