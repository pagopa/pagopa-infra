data "azurerm_storage_account" "pagopa_selfcare_fe_sa" {
  name                = replace("${var.prefix}-${var.env_short}-selfcare-sa", "-", "")
  resource_group_name = format("%s-%s-fe-rg", var.prefix, var.env_short)
}

data "azurerm_storage_account" "pagopa_apiconfig_fe_sa" {
  name                = replace("${var.prefix}-${var.env_short}-${var.location_short}-apiconfig-sa", "-", "")
  resource_group_name = format("%s-%s-api-config-rg", var.prefix, var.env_short)
}

##############
## Products ##
##############

module "apim_statuspage_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.4.1"

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
  aks_path           = var.env == "prod" ? "weuprod.%s.internal.platform.pagopa.it" : "weu${var.env}.%s.internal.${var.env}.platform.pagopa.it"
  fe_backoffice_path = replace(format("%s/ui/version.json", data.azurerm_storage_account.pagopa_selfcare_fe_sa.primary_web_host), "/{2}", "/")
  fe_apiconfig_path  = format("config.%s.%s/version.json", var.apim_dns_zone_prefix, var.external_domain)
}

resource "azurerm_api_management_api_version_set" "api_statuspage_api" {

  name                = format("%s-statuspage-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_statuspage_service_api.display_name
  versioning_scheme   = "Segment"
}

data "azurerm_function_app" "authorizer" {
  name                = format("%s-%s-%s-shared-authorizer-fn", var.prefix, var.env_short, var.location_short)
  resource_group_name = format("%s-%s-%s-shared-rg", var.prefix, var.env_short, var.location_short)
}

data "azurerm_function_app" "canone_unico" {
  name                = format("%s-%s-fn-canoneunico", var.prefix, var.env_short)
  resource_group_name = format("%s-%s-canoneunico-rg", var.prefix, var.env_short)
}

data "azurerm_function_app" "reporting_analysis" {
  name                = format("%s-%s-%s-fn-gpd-analysis", var.prefix, var.env_short, var.location_short)
  resource_group_name = format("%s-%s-%s-gps-gpd-rg", var.prefix, var.env_short, var.location_short)
}

data "azurerm_function_app" "reporting_batch" {
  name                = format("%s-%s-%s-fn-gpd-batch", var.prefix, var.env_short, var.location_short)
  resource_group_name = format("%s-%s-%s-gps-gpd-rg", var.prefix, var.env_short, var.location_short)
}

data "azurerm_function_app" "reporting_service" {
  name                = format("%s-%s-%s-fn-gpd-service", var.prefix, var.env_short, var.location_short)
  resource_group_name = format("%s-%s-%s-gps-gpd-rg", var.prefix, var.env_short, var.location_short)
}

data "azurerm_linux_function_app" "mockec" {
  count               = var.env_short != "p" ? 1 : 0
  name                = format("%s-%s-app-mock-ec", var.prefix, var.env_short)
  resource_group_name = format("%s-%s-mock-ec-rg", var.prefix, var.env_short)
}

data "azurerm_linux_web_app" "pdf_engine" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-shared-app-pdf-engine-java"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-shared-pdf-engine-rg"
}

module "apim_api_statuspage_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.4.1"

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
      "afmcalculator"            = format("%s/pagopa-afm-calculator-service", format(local.aks_path, "afm"))
      "afmmarketplace"           = format("%s/pagopa-afm-marketplace-service", format(local.aks_path, "afm"))
      "afmutils"                 = format("%s/pagopa-afm-utils-service", format(local.aks_path, "afm"))
      "apiconfig"                = format("%s/{{apicfg-core-cache-path}}", format(local.aks_path, "apiconfig")) // show status only one instances Ora OR Pgflex
      "apiconfig-fe"             = format("%s", local.fe_apiconfig_path)
      "apiconfigcacheo"          = format("%s/api-config-cache/o", format(local.aks_path, "apiconfig"))
      "apiconfigcachep"          = format("%s/api-config-cache/p", format(local.aks_path, "apiconfig"))
      "apiconfigselfcare"        = format("%s/{{apicfg-selfcare-integ-cache-path}}", format(local.aks_path, "apiconfig")) // show status only one instances Ora OR Pgflex
      "authorizer"               = format("%s/", data.azurerm_function_app.authorizer.default_hostname)
      "authorizerconfig"         = format("%s//authorizer-config", format(local.aks_path, "shared"))
      "bizevents"                = format("%s/pagopa-biz-events-service", format(local.aks_path, "bizevents"))
      "bizeventsdatastoreneg"    = format("%s/pagopa-negative-biz-events-datastore-service", format(local.aks_path, "bizevents"))
      "bizeventsdatastorepos"    = format("%s/pagopa-biz-events-datastore-service", format(local.aks_path, "bizevents"))
      "backofficepagopa"         = format("%s/selfcare/pagopa/v1", format(local.aks_path, "selfcare"))
      "backofficepagopa-fe"      = format("%s", local.fe_backoffice_path)
      "backofficeexternalpagopa" = format("%s/backoffice-external", format(local.aks_path, "selfcare"))
      "canoneunico"              = format("%s/", data.azurerm_function_app.canone_unico.default_hostname)
      "fdrndpnew"                = format("%s/pagopa-fdr-service", format(local.aks_path, "fdr"))
      "gpd"                      = format("%s/pagopa-gpd-core", format(local.aks_path, "gps"))
      "gpdpayments"              = format("%s/pagopa-gpd-payments", format(local.aks_path, "gps"))
      "gpdenrollment"            = format("%s/pagopa-gpd-reporting-orgs-enrollment", format(local.aks_path, "gps"))
      "gpdupload"                = format("%s/pagopa-gpd-upload", format(local.aks_path, "gps"))
      "gpdreportinganalysis"     = format("%s/", data.azurerm_function_app.reporting_analysis.default_hostname)
      "gpdreportingbatch"        = format("%s/api/", data.azurerm_function_app.reporting_batch.default_hostname)
      "gpdreportingservice"      = format("%s/api/", data.azurerm_function_app.reporting_service.default_hostname)
      "gps"                      = format("%s/pagopa-spontaneous-payments-service", format(local.aks_path, "gps"))
      "gpsdonation"              = format("%s/pagopa-gps-donation-service", format(local.aks_path, "gps"))
      "mockec"                   = var.env_short != "p" ? format("%s/", data.azurerm_linux_function_app.mockec[0].default_hostname) : "NA"
      "mockconfig"               = var.env_short != "p" ? format("%s/pagopa-mock-config-be", format(local.aks_path, "mock")) : "NA"
      "mocker"                   = var.env_short != "p" ? format("%s/pagopa-mocker/mocker", format(local.aks_path, "mock")) : "NA"
      "pdfengine"                = format("%s/", data.azurerm_linux_web_app.pdf_engine.default_hostname)
      "receiptpdfdatastore"      = format("%s/pagopa-receipt-pdf-datastore", format(local.aks_path, "receipts"))
      "receiptpdfgenerator"      = format("%s/pagopa-receipt-pdf-generator", format(local.aks_path, "receipts"))
      "receiptpdfnotifier"       = format("%s/pagopa-receipt-pdf-notifier", format(local.aks_path, "receipts"))
      "receiptpdfservice"        = format("%s/pagopa-receipt-pdf-service", format(local.aks_path, "receipts"))
      "receiptpdfhelpdesk"       = format("%s/pagopa-receipt-pdf-helpdesk", format(local.aks_path, "receipts"))
    }), "\"", "\\\"")
  })
}
