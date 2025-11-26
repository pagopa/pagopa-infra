##############
## Products ##
##############

module "apim_prometheus_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "prometheus"
  display_name = "Prometheus for NDP"
  description  = "Prometheus for NDP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 0

  policy_xml = file("./api_product/prometheus-service/_base_policy.xml")
}

######################
##    Prometheus    ##
######################
locals {
  apim_prometheus_service_api = {
    display_name          = "Prometheus for NDP"
    description           = "API Prometheus for NDP"
    path                  = "prometheus"
    subscription_required = false
    service_url           = null
  }
}

/*
resource "azurerm_api_management_api_version_set" "api_prometheus_api" {
  name                = format("%s-prometheus-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_prometheus_service_api.display_name
  versioning_scheme   = "Segment"
}
*/

module "apim_api_prometheus_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-prometheus-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_prometheus_product.product_id]
  subscription_required = local.apim_prometheus_service_api.subscription_required
  #version_set_id        = azurerm_api_management_api_version_set.api_prometheus_api.id
  #api_version           = "v1"

  description  = local.apim_prometheus_service_api.description
  display_name = local.apim_prometheus_service_api.display_name
  path         = local.apim_prometheus_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_prometheus_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/prometheus-service/v1/_prometheus.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/prometheus-service/v1/_base_policy.xml", {
    hostname            = var.env_short == "p" ? "${var.location_short}${var.env}.kibana.internal.platform.pagopa.it" : "${var.location_short}${var.env}.kibana.internal.${var.env}.platform.pagopa.it"
    dns_pagopa_platform = format("api.%s.%s", var.apim_dns_zone_prefix, var.external_domain)
    apim_base_path      = "/prometheus"
  })

}
