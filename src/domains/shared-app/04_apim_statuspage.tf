##############
## Products ##
##############

module "apim_statuspage_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "statuspage"
  display_name = "Status Page"
  description  = "Prodotto Status Page"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_statuspage_policy.xml")
}

###########
##  API  ##
###########
locals {
  apim_statuspage_service_api = {
    display_name          = "Status Page - API"
    description           = "API to Status Page"
    path                  = "shared/statuspage"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_statuspage_api" {

  name                = format("%s-statuspage-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_statuspage_service_api.display_name
  versioning_scheme   = "Segment"
}

data "azurerm_app_service" "api_config" {
  name                = format("%s-%s-app-api-config", var.prefix, var.env_short)
  resource_group_name = format("%s-%s-api-config-rg", var.prefix, var.env_short)
}

module "apim_api_statuspage_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-statuspage-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_statuspage_product.product_id]
  subscription_required = local.apim_statuspage_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_statuspage_api.id
  api_version           = "v1"

  description  = local.apim_statuspage_service_api.description
  display_name = local.apim_statuspage_service_api.display_name
  path         = local.apim_statuspage_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_statuspage_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/status-page-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/status-page-service/v1/_base_policy.xml", {
    hostname = local.shared_hostname
    services = replace(jsonencode({
      "apiconfig" = format("%s/apiconfig/api/v1", data.azurerm_app_service.api_config.default_site_hostname)
      "afmcalcuator" = format("%s/pagopa-afm-calculator-service", var.env == "prod" ? "weuprod.afm.internal.platform.pagopa.it" : "weu${var.env}.afm.internal.${var.env}.platform.pagopa.it")
      "afmutils" = format("%s/pagopa-afm-utils-service", var.env == "prod" ? "weuprod.afm.internal.platform.pagopa.it" : "weu${var.env}.afm.internal.${var.env}.platform.pagopa.it")
      "afmmarketplace" = format("%s/pagopa-afm-marketplace-service", var.env == "prod" ? "weuprod.afm.internal.platform.pagopa.it" : "weu${var.env}.afm.internal.${var.env}.platform.pagopa.it")
    }), "\"", "\\\"")
  })
}
