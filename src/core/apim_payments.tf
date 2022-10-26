###################
## SOAP Products ##
###################

################
# INTERNAL USE #
################

module "apim_gpd_payments_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-gpd-payments"
  display_name = "GPD Payments pagoPA - SOAP"
  description  = "Prodotto Payments gestione posizioni debitorie - SOAP"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/gpd/payments/soap/_base_policy.xml")
}

##############
## SOAP API ##
##############

resource "azurerm_api_management_api_version_set" "api_gpd_payments_api" {
  name                = format("%s-api-gpd-payments-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Payments"
  versioning_scheme   = "Segment"
}


resource "azurerm_api_management_api" "apim_api_gpd_payments_api" {
  name                  = format("%s-api-gpd-payments-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = false
  service_url           = format("https://%s/partner", module.payments_app_service.default_site_hostname)
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_payments_api.id
  version               = "v1"
  revision              = "1"

  description  = "SOAP API Payments per Gestione Posizione Debitorie"
  display_name = "GPD Payments pagoPA"
  path         = "gpd-payments/api"
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/gpd_api/payments/v1/soap/paForNode.wsdl")
    wsdl_selector {
      service_name  = "paForNode_Service"
      endpoint_name = "paForNode_Port"
    }
  }
}

###################
## REST Products ##
###################

module "apim_gpd_payments_rest_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-gpd-payments-rest"
  display_name = "GPD Payments pagoPA - REST"
  description  = "Prodotto Payments gestione posizioni debitorie - REST"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/gpd/payments/rest/_base_policy.xml")
}

##############
## REST API ##
##############

resource "azurerm_api_management_api_version_set" "api_gpd_payments_rest_api" {
  name                = format("%s-api-gpd-payments-rest-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Payment Receipts"
  versioning_scheme   = "Segment"
}

module "apim_api_gpd_payments_rest_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-api-gpd-payments-rest-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_gpd_payments_rest_product.product_id]
  subscription_required = true
  api_version           = "v1"
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_payments_rest_api.id
  service_url           = format("https://%s", module.payments_app_service.default_site_hostname)

  description  = "REST API Payments per Gestione Posizione Debitorie"
  display_name = "GPD Payments pagoPA - REST"
  path         = "payment-receipts/api"
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/gpd_api/payments/v1/rest/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/gpd_api/payments/v1/rest/_base_policy.xml", {
    origin = format("https://%s.%s.%s", var.cname_record_name, var.dns_zone_prefix, var.external_domain)
  })
}


########################
# GPD-GPS EXTERNAL USE #
########################

##############
## Products ##
##############

module "apim_payments_receipts_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "payments-receipts"
  display_name = "GPD Payments Receipts for organizations"
  description  = "GPD Payments Receipts for organizations"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/gpd/payments-receipts/_base_policy.xml")
}

locals {
  apim_payments_receipts_service_api = {
    display_name          = "GPD pagoPA - Payments Receipts service API for organizations"
    description           = "API to support payments receipts service for organizations"
    path                  = "gpd/payments-receipts-service"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_payments_receipts_api" {

  name                = format("%s-payments-receipts-service-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_payments_receipts_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_payments_receipts_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-payments-receipts-service-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payments_receipts_product.product_id]
  subscription_required = local.apim_payments_receipts_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_payments_receipts_api.id
  api_version           = "v1"

  description  = local.apim_payments_receipts_service_api.description
  display_name = local.apim_payments_receipts_service_api.display_name
  path         = local.apim_payments_receipts_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_payments_receipts_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/gpd_api/payments-receipts/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/gpd_api/payments-receipts/v1/_base_policy.xml", {
    env_short = var.env_short
  })
}
